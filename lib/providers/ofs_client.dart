import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aquamarine_server_interface/io.dart';
import 'package:aquamarine_server_interface/quadtree.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:aquamarine_util/async.dart';
import 'package:aquamarine_util/memory_cache.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:logging/logging.dart';
import 'package:vector_math/vector_math_64.dart';

import '../widgets/tide_panel.dart';

class _HourRange extends Equatable {
  const _HourRange(this.begin, this.end);
  final HourUtc begin, end;
  @override
  get props => [begin, end];
}

class _UvTimelineKey extends Equatable {
  const _UvTimelineKey(this.bounds, this.zoom);

  final LatLngBounds bounds;
  final double zoom;

  @override
  get props => [bounds, zoom];
}

class _UvRequest extends Equatable {
  const _UvRequest(this.time, this.space);

  final _HourRange time;
  final _UvTimelineKey space;

  @override
  get props => [time, space];
}

class _SamplingKey extends Equatable {
  const _SamplingKey(this.hash, this.bounds, this.resolution);

  final Hex32 hash;
  final LatLngBounds bounds;
  final double resolution;

  @override
  get props => [hash, bounds, resolution];
}

class _UvCacheEntry {
  _UvCacheEntry(this.latlngHash);

  final Hex32 latlngHash;
  final uv = <Vector2>[];
}

class OfsClient extends ChangeNotifier {
  static final log = Logger('OfsClient');
  static const host = '34.83.198.158';

  static double resolutionForZoom(double zoom) {
    const baseResolution = 24.0;
    return baseResolution / pow(2, zoom);
  }

  OfsClient({required this.client});
  final http.Client client;
  // TODO(AsturaPhoenix): smarter caching policy with persistent cache
  final _latlngCache = AsyncCache<Hex32, Quadtree<int>>.persistent();
  final _uvCache = MemoryCache<HourUtc, _UvCacheEntry>(capacity: 72);
  _UvTimelineKey? _uvTimelineKey;

  final _samplingCache = AsyncCache<_SamplingKey, List<LatLng>>.single();
  final _immediateUvFetch = AsyncCache<_UvRequest, void>.ephemeral();

  Future<Quadtree<int>> _latlng(Hex32 hash) async =>
      _latlngCache.computeIfAbsent(hash, () => _fetchLatLng(hash));

  Future<Quadtree<int>> _fetchLatLng(Hex32 hash) async {
    final response = await client.send(
      http.Request('get', Uri.http('$host:1080', '/latlng/$hash')),
    );

    return indexLatLng(response.stream);
  }

  Future<void> _refresh(HourUtc t) {
    final key = _UvRequest(_HourRange(t, t), _uvTimelineKey!);
    return _immediateUvFetch.computeIfAbsent(key, () => _fetchUv(key));
  }

  Future<void> _fetchUv(_UvRequest request) async {
    final resolution = resolutionForZoom(request.space.zoom);
    final bounds = request.space.bounds;
    final response = await client.send(
      http.Request(
        'get',
        Uri.http('$host:1080', '/uv', {
          'begin': request.time.begin.toString(),
          'end': request.time.end.toString(),
          'bounds': jsonEncode({
            'sw': [
              bounds.southwest.latitude,
              bounds.southwest.longitude,
            ],
            'ne': [
              bounds.northeast.latitude,
              bounds.northeast.longitude,
            ],
          }),
          'resolution': resolution.toString(),
        }),
      ),
    );

    if (response.statusCode != HttpStatus.ok) throw response;

    final reader = BufferedReader(response.stream);
    try {
      bool isCancelled() => _uvTimelineKey != request.space;
      while (!isCancelled() &&
          (reader.buffer.isNotEmpty || await reader.moveNext())) {
        final t = await readHourUtc(reader);
        final hash = await readHex32(reader);
        final entry = _UvCacheEntry(hash);

        if (hash != Hex32.zero) {
          final samplePoints =
              await _samplePoints(_SamplingKey(hash, bounds, resolution));

          await readVectors(
            reader,
            () => !isCancelled() && entry.uv.length < samplePoints.length,
            entry.uv.add,
          );

          if (isCancelled()) return;

          if (samplePoints.length != entry.uv.length) {
            throw FormatException('Unexpected end of stream; received '
                '${entry.uv.length} of ${samplePoints.length} data points.');
          }
        }

        if (isCancelled()) return;

        _uvCache[t] = entry;
        notifyListeners();
      }
    } finally {
      reader.cancel();
    }
  }

  Future<List<LatLng>> _samplePoints(_SamplingKey key) =>
      _samplingCache.computeIfAbsent(
        key,
        () async => [
          for (final entry in (await _latlng(key.hash))
              .sample(key.bounds, resolution: key.resolution))
            entry.location
        ],
      );

  Future<List<_UvCacheEntry>> _getUvsAboutHour(HourUtc t0) async {
    final t1 = t0 + 1;
    var uv0 = _uvCache[t0], uv1 = _uvCache[t1];

    if (uv0 == null || uv1 == null) {
      final refresh = Future.wait([
        if (uv0 == null) _refresh(t0),
        if (uv1 == null) _refresh(t1),
      ]);

      final completer = Completer();
      void listener() {
        uv0 = _uvCache[t0];
        uv1 = _uvCache[t1];
        if (uv0 != null && uv1 != null) {
          removeListener(listener);
          completer.complete();
        }
      }

      refresh.onError((Object e, s) {
        if (!completer.isCompleted) {
          removeListener(listener);
          completer.completeError(e, s);
        }
        throw e;
      });

      addListener(listener);
      await completer.future;
    }

    return [uv0!, uv1!];
  }

  /// Gets interpolated currents for a view. Produces a null iterable if data
  /// for this view has not yet been fetched (or was evicted from the cache), or
  /// an empty iterable if no data for this view is available on the server yet.
  ///
  /// Although currents are only returned for [timewindow.t], the extents of the
  /// window may be used to inform caching for animation.
  Future<Iterable<QuadtreeEntry<Vector2>>> getCurrents({
    required GraphTimeWindow timeWindow,
    required LatLngBounds bounds,
    required double zoom,
  }) async {
    final timelineKey = _UvTimelineKey(bounds, zoom);
    if (timelineKey != _uvTimelineKey) {
      _uvTimelineKey = timelineKey;
      _uvCache.clear();
      _immediateUvFetch.clear();
    }

    final t0 = HourUtc.truncate(timeWindow.t.value);
    final uv = await _getUvsAboutHour(t0);

    if (uv[1].latlngHash == Hex32.zero) {
      // No data (yet?) for at least one side of this interval. For now, we
      // won't query the server for an update, but we should be more intelligent
      // about this.
      return const [];
    }

    if (uv[0].latlngHash != uv[1].latlngHash) {
      // Don't interpolate between different meshes. (We don't expect this to
      // happen often if at all.)
      return const [];
    }

    final samplePoints = await _samplePoints(
      _SamplingKey(uv[0].latlngHash, bounds, resolutionForZoom(zoom)),
    );

    assert(
      uv[0].uv.length == samplePoints.length &&
          uv[1].uv.length == samplePoints.length,
    );

    final f = timeWindow.t.value.difference(t0.t).inMilliseconds /
        Duration.millisecondsPerHour;
    return () sync* {
      for (int i = 0; i < samplePoints.length; ++i) {
        final v0 = uv[0].uv[i], v1 = uv[1].uv[i];
        yield QuadtreeEntry<Vector2>(samplePoints[i], v0 + (v1 - v0) * f);
      }
    }();
  }
}
