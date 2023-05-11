import 'dart:async';

import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/quadtree.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:aquamarine_util/async.dart';
import 'package:async/async.dart' hide AsyncCache;
import 'package:latlng/latlng.dart';

import 'ofs_client.dart';
import 'persistence/caching.dart';
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
  AquamarineServer({
    required this.ofsClient,
    required Persistence persistence,
    this.clock = DateTime.now,
  }) : persistence = CachingPersistence(persistence);

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
    final simulationTimes = OfsClient.simulationTimes(
            t, SimulationSchedule.nowcast)
        .followedBy(OfsClient.simulationTimes(t, SimulationSchedule.forecast))
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

    // When we fetch UVs from the server, go ahead and write them to the disk
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

  Future<bool> refreshUv(Iterable<SimulationTime> simulationTimes) async {
    for (final s in simulationTimes) {
      final uv = await ofsClient.fetchUv(s);
      if (uv == null) continue;

      // Since latlngs don't change often if ever, and we'll need to read from
      // disk to decimate UVs anyway, don't bother indexing the latlngs or
      // splitting the stream here; just download again and write them to the
      // disk. We'll index them on cache miss later, which would happen on every
      // server restart.
      if (!latlngCache.containsKey(uv.latlngHash) &&
          !await persistence.latlngFileExists(uv.latlngHash)) {
        final latlng = await ofsClient.fetchLatLng(s);
        // It is an exception for the latlngs to be unavailable when the uvs
        // were.
        latlng!;

        await persistence.writeLatLng(uv.latlngHash, latlng);
        // Waiting for the write to finish before proceeding lets us expect that
        // the latlng file corresponding to this uv file exists by the time we
        // try to use it.
      }

      await persistence.writeUv(s, uv.latlngHash, uv.uv);

      return true;
    }
    return false;
  }
}
