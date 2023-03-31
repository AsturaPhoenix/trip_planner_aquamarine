import 'dart:io';

import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/quadtree.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:aquamarine_util/async.dart';
import 'package:async/async.dart';

import 'ofs_client.dart';
import 'persistence.dart';
import 'types.dart';

class UvResponseEntry {
  UvResponseEntry({
    required this.t,
    required this.latLngHash,
    required this.uv,
  });
  UvResponseEntry.empty(this.t)
      : latLngHash = Hex32.zero,
        uv = Stream.empty();

  final HourUtc t;
  final Hex32 latLngHash;
  final Stream<List<int>> uv;
}

/// Common storage for a given request
class UvRequestContext {
  UvRequestContext({required this.bounds, required this.resolution});
  final LatLngBounds bounds;
  final double resolution;

  final samplingCache =
      AsyncCacheMap<Hex32, List<QuadtreeEntry<int>>>.ephemeral();
}

class AquamarineServer {
  AquamarineServer({
    required this.ofsClient,
    required this.persistence,
    this.clock = DateTime.now,
  });

  final OfsClient ofsClient;
  final Persistence persistence;
  final DateTime Function() clock;

  final latlngCache = AsyncCacheMap<Hex32, Quadtree<int>>.persistent();
  final uvRefreshCache = AsyncCacheMap<HourUtc, bool>.ephemeral();

  Future<Stream<List<int>>?> latlng(Hex32 hash) => persistence.readLatLng(hash);

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

  Stream<UvResponseEntry> _uvForHour(
    HourUtc t,
    UvRequestContext context,
  ) async* {
    final now = clock();
    final simulationTime = persistence.simulationTime(t);

    // The simulations we consider, in order, will be first the nowcasts, then
    // the forecasts, preferring later simulations, filtering out simulations
    // that could not have run yet, until we encounter the last simulation we
    // fetched.
    final simulationTimes = OfsClient.simulationTimes(
            t, SimulationSchedule.nowcast)
        .followedBy(OfsClient.simulationTimes(t, SimulationSchedule.forecast))
        .where((s) => !s.timestamp.t.isAfter(now))
        .takeWhile((s) => s != simulationTime);

    bool hasResponse = false;

    try {
      yield await _readUv(t, context);
      hasResponse = true;

      if (simulationTime == null || simulationTimes.isEmpty) {
        // No need to refresh.
        return;
      }
    } on FileSystemException {
      // cache miss
    }

    // When we fetch UVs from the server, go ahead and write them to the disk
    // first as we'll need random access to decimate.
    if (await uvRefreshCache.computeIfAbsent(
        t, () => refreshUv(t, simulationTimes))) {
      yield await _readUv(t, context);
    } else if (!hasResponse) {
      // Send a tombstone so that the client knows this timestamp won't have a
      // repsonse for this request, so that the client doesn't have to wait for
      // all other responses to have arrived.
      yield UvResponseEntry.empty(t);
    }
  }

  Future<UvResponseEntry> _readUv(HourUtc t, UvRequestContext context) async {
    final reader = await persistence.readUv(t);
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
        latLngHash: latlngHash,
        uv: () async* {
          try {
            for (final entry in samplePoints) {
              yield await reader.readVectorBytes(entry.value);
            }
          } finally {
            reader.close();
          }
        }(),
      );
    } on Exception {
      reader.close();
      rethrow;
    }
  }

  Future<bool> refreshUv(
      HourUtc t, Iterable<SimulationTime> simulationTimes) async {
    for (final s in simulationTimes) {
      final uv = await ofsClient.fetchUv(s);
      if (uv == null) continue;

      // Since latlngs don't change often if ever, and we'll need to read from
      // disk to decimate UVs anyway, don't bother indexing the latlngs or
      // splitting the stream here; just write them to the disk. We'll index
      // them on cache miss later, which would happen on every server restart.
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

      await persistence.writeUv(t, s, uv.latlngHash, uv.uv);

      return true;
    }
    return false;
  }
}
