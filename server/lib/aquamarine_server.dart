import 'dart:async';

import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/quadtree.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:aquamarine_util/async.dart';
import 'package:async/async.dart' hide AsyncCache;
import 'package:latlng/latlng.dart';
import 'package:logging/logging.dart';

import 'ofs_client.dart';
import 'persistence/persistence.dart';
import 'types.dart';

/// u/v response data for a particular sample hour.
///
/// Consumers must call [close]. Keeping a separate callback rather than relying
/// on the consumer disposing the [uv] stream makes it easier to code around
/// cases where response processing is cancelled before ever subscribing to the
/// stream, where the entire construct can be wrapped in a `try`/`finally`
/// rather than special-casing depending on whether or not the stream was
/// listened to.
class UvResponseEntry {
  static Future<void> _noop() async {}

  UvResponseEntry({
    required this.t,
    required this.simulationTime,
    required this.latLngHash,
    required this.uv,
    required this.close,
  });
  UvResponseEntry.empty(this.t)
      : latLngHash = Hex32.zero,
        simulationTime = null,
        uv = Stream.empty(),
        close = _noop;

  final HourUtc t;
  final SimulationTime? simulationTime;
  final Hex32 latLngHash;
  final Stream<List<int>> uv;
  final Future<void> Function() close;
}

/// Common storage for a given request
class UvRequestContext {
  UvRequestContext({required this.bounds, required this.resolution});
  final LatLngBounds bounds;
  final double resolution;

  final samplingCache = AsyncCache<Hex32, List<QuadtreeEntry<int>>>.ephemeral();
}

class AquamarineServer {
  static final log = Logger('AquamarineServer');

  AquamarineServer({
    required this.ofsClient,
    required this.persistence,
    this.clock = DateTime.now,
  });

  final OfsClient ofsClient;
  final Persistence persistence;
  final DateTime Function() clock;

  final latlngCache = AsyncCache<Hex32, Quadtree<int>>.persistent();
  final uvRefreshCache = AsyncCache<HourUtc, bool>.ephemeral();

  Future<Stream<List<int>>?> latlng(Hex32 hash) => persistence.readLatLng(hash);

  /// Consumers should close each entry in turn rather than awaiting the entire
  /// stream, as awaiting the entire stream can deadlock a refresh, which cannot
  /// write to persistence while a from-persistence entry is open.
  Stream<UvResponseEntry> uv(
    HourUtc begin,
    HourUtc end,
    LatLngBounds bounds, [
    double resolution = 0,
  ]) {
    final context = UvRequestContext(bounds: bounds, resolution: resolution);

    return StreamGroup.merge(() sync* {
      for (HourUtc t = begin; t <= end; ++t) {
        yield _uvForHour(t, context);
      }
    }());
  }

  bool _isSimulationAvailable(HourUtc timestamp) {
    const maxSimulationAge = Duration(days: 31);

    final now = clock();
    return timestamp.t.isBefore(now) &&
        timestamp.t.isAfter(now.subtract(maxSimulationAge));
  }

  Stream<UvResponseEntry> _uvForHour(
    HourUtc t,
    UvRequestContext context,
  ) async* {
    bool hasResponse = false;
    final reader = await _readUv(t, context);

    // The simulations we consider, in order, will be first the nowcasts, then
    // the forecasts, preferring later simulations, filtering out simulations
    // that could not have run yet, until we encounter the last simulation we
    // fetched.
    final simulationTimes =
        OfsClient.samplesCoveringTime(t, SimulationSchedule.nowcast)
            .followedBy(
                OfsClient.samplesCoveringTime(t, SimulationSchedule.forecast))
            .where((s) => _isSimulationAvailable(s.timestamp))
            .takeWhile((s) => s != reader?.simulationTime);

    if (reader != null) {
      final protector = ClosableProtector(reader);
      try {
        yield* protector.stream;
      } finally {
        protector.close();
      }
      hasResponse = true;

      if (!OfsClient.needsFutureRefresh(reader.simulationTime!) ||
          simulationTimes.isEmpty) {
        // No need to refresh.
        return;
      }
    }

    // When we fetch UVs from the server, go ahead and write them to persistence
    // first as we'll need random access to decimate.
    if (await uvRefreshCache.computeIfAbsent(
        t, () => refreshUv(simulationTimes))) {
      final protector = ClosableProtector((await _readUv(t, context))!);
      try {
        yield* protector.stream;
      } finally {
        protector.close();
      }
    } else if (!hasResponse) {
      // Send a tombstone so that the client knows this timestamp won't have a
      // repsonse for this request, so that the client doesn't have to wait for
      // all other responses to have arrived.
      yield UvResponseEntry.empty(t);
    }
  }

  Future<UvResponseEntry?> _readUv(HourUtc t, UvRequestContext context) async {
    final reader = await persistence.readUv(t);
    if (reader == null) return null;

    try {
      final latlngHash = await reader.readLatLngHash();

      // Since quadtree traversal can be on the slow side and we'll usually be
      // asked for several hours at a time, cache the traversal. We might want
      // to skip this for smaller requests.
      final samplePoints =
          await context.samplingCache.computeIfAbsent(latlngHash, () async {
        final quadtree = await latlngCache.computeIfAbsent(
            latlngHash,
            () async =>
                indexLatLng((await persistence.readLatLng(latlngHash))!));
        return [
          ...quadtree.sample(context.bounds, resolution: context.resolution)
        ];
      });

      return UvResponseEntry(
        t: t,
        simulationTime: reader.simulationTime,
        latLngHash: latlngHash,
        uv: () async* {
          for (final entry in samplePoints) {
            yield await reader.readVectorBytes(entry.value);
          }
        }(),
        close: reader.close,
      );
    } on Object {
      unawaited(reader.close());
      rethrow;
    }
  }

  /// Fetches latlng data if not cached or in persistence.
  ///
  /// Since latlngs don't change often if ever, and we'll need to read from
  /// persistence to decimate UVs anyway, don't bother indexing the latlngs here
  /// or splitting the stream in a latlnguv download; just download again and
  /// write them to persistence. We'll index them on cache miss later, which
  /// would happen on every server restart.
  ///
  /// [representativeSample] is the sample from which to download latlng data.
  /// It should be consistent with [hash], or else it will fail verification and
  /// be deleted in the next startup check.
  Future<void> ensureLatLngFetched(
    Hex32 hash,
    SimulationTime representativeSample,
  ) async {
    if (!latlngCache.containsKey(hash) &&
        !await persistence.latlngFileExists(hash)) {
      final latlng = await ofsClient.fetchLatLng(representativeSample);
      // It is an exception for the latlngs to be unavailable when the uvs were
      // available.
      latlng!;

      await persistence.writeLatLng(hash, latlng);
      // Waiting for the write to finish before proceeding lets us expect that
      // the latlng file corresponding to this uv file exists by the time we
      // try to use it.
    }
  }

  Future<bool> refreshUv(Iterable<SimulationTime> simulationTimes) async {
    for (final s in simulationTimes) {
      final uv = await ofsClient.fetchLatLngUv(s);
      if (uv == null) continue;

      try {
        await ensureLatLngFetched(uv.latlngHash, s);
        await persistence.writeUv(s, uv.latlngHash, uv.uv);
      } finally {
        uv.close();
      }

      return true;
    }
    return false;
  }

  /// Refreshes UV for all simulation samples generated by a simulation run at
  /// [runTime], skipping samples for which a refresh is already underway or for
  /// which the latest simulation has already been fetched. Samples are fetched
  /// one at a time to avoid clogging the network. Returns true if all samples
  /// were available. Returns false if any of the fetches fails, including any
  /// for which a refresh was already underway.
  Future<bool> fetchSimulationRun(
    HourUtc runTime, {
    bool failFast = true,
  }) async {
    Future<bool> needsRefresh(HourUtc t) async {
      final reader = await persistence.readUv(t);
      if (reader == null) return true;
      try {
        return reader.simulationTime.timestamp < runTime;
      } finally {
        reader.close();
      }
    }

    bool allSucceeded = true;
    Hex32? latlngHash;
    for (final simulationTime
        in OfsClient.samplesForRun(runTime, SimulationSchedule.nowcast)
            .followedBy(
                OfsClient.samplesForRun(runTime, SimulationSchedule.forecast)
                    // Forecast 0 overlaps with nowcast 6.
                    .skip(1))) {
      if (!await needsRefresh(simulationTime.representedTimestamp)) {
        log.info('Skipping up-to-date sample $simulationTime');
        continue;
      }

      log.info('Fetching $simulationTime');

      if (!await uvRefreshCache
          .computeIfAbsent(simulationTime.representedTimestamp, () async {
        if (latlngHash == null) {
          final uv = await ofsClient.fetchLatLngUv(simulationTime);
          if (uv == null) return false;

          try {
            latlngHash = uv.latlngHash;
            await ensureLatLngFetched(latlngHash!, simulationTime);
            await persistence.writeUv(simulationTime, latlngHash!, uv.uv);
          } finally {
            uv.close();
          }
        } else {
          final uv = await ofsClient.fetchUv(simulationTime);
          if (uv == null) return false;

          await persistence.writeUv(simulationTime, latlngHash!, uv);
        }
        return true;
      })) {
        log.warning('Unable to fetch $simulationTime');
        if (failFast) {
          return false;
        } else {
          allSucceeded = false;
        }
      }
    }

    return allSucceeded;
  }
}
