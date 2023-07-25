import 'dart:async';
import 'dart:typed_data';

import 'package:aquamarine_server_interface/types.dart';
import 'package:aquamarine_util/memory_cache.dart';

import '../types.dart';
import 'persistence.dart';

abstract class _UvCache {
  _UvCache({
    required this.simulationTime,
    required this.latlngHash,
  });
  final SimulationTime simulationTime;
  final Hex32 latlngHash;
}

abstract class _CacheUvReader implements UvReader {
  _UvCache get cache;

  @override
  SimulationTime get simulationTime => cache.simulationTime;
  @override
  Future<Hex32> readLatLngHash() async => cache.latlngHash;
}

class _CompleteUvCache extends _UvCache {
  _CompleteUvCache({
    required super.simulationTime,
    required super.latlngHash,
    required this.vectorBytes,
  });

  final Uint8List vectorBytes;
}

class _CompleteUvReader extends _CacheUvReader {
  _CompleteUvReader(this.cache);
  @override
  final _CompleteUvCache cache;

  @override
  Future<void> close() async {}

  @override
  Future<Uint8List> readVectorBytes(int index) async {
    const vectorSize = 8;
    final position = vectorSize * index;
    return Uint8List.sublistView(
        cache.vectorBytes, position, position + vectorSize);
  }
}

class _RandomAccessUvCache extends _UvCache {
  _RandomAccessUvCache({
    required super.simulationTime,
    required super.latlngHash,
  });
  final uv = <int, Future<Uint8List>>{};
}

class _RandomAccessUvReader extends _CacheUvReader {
  _RandomAccessUvReader(this.cache, this.reader);
  @override
  final _RandomAccessUvCache cache;
  final Future<UvReader> reader;

  @override
  Future<void> close() async => (await reader).close();

  @override
  Future<Uint8List> readVectorBytes(int index) async =>
      cache.uv[index] ??= (await reader).readVectorBytes(index);
}

extension on Stream<List<int>> {
  Future<Uint8List> toBytes() async {
    final accumulator = BytesBuilder(copy: false);
    await forEach(accumulator.add);
    return accumulator.takeBytes();
  }
}

/// A persistence wrapper that maintains LRU caches. Write operations also first
/// write to the cache to minimize the chances of file lock contention. This
/// does not guarantee that cache entries will not be evicted while a file write
/// is in progress, so contention may still occur under heavy load, which may be
/// an opportunity for future optimization.
///
/// Since latlng is infrequently read and rarely ever written, it is not cached.
/// Caching would require that we be notified if the underlying persistence
/// impl decides to delete an invalid latlng file upon verification.
class CachingPersistence implements Persistence {
  CachingPersistence(
    this._backing, {
    int uvCacheSize = 128,
  }) : _uvCache = MemoryCache(capacity: uvCacheSize);
  final Persistence _backing;
  // This is not an AsyncCache because we don't expect transient errors from
  // persistence, while errors may come from the source stream during a write,
  // and we'll also be caching explicit writes.
  final MemoryCache<HourUtc, Future<_UvCache?>> _uvCache;

  @override
  Future<bool> latlngFileExists(Hex32 hash) => _backing.latlngFileExists(hash);

  @override
  Future<Stream<List<int>>?> readLatLng(Hex32 hash) =>
      _backing.readLatLng(hash);

  @override
  Future<void> writeLatLng(Hex32 hash, Stream<List<int>> stream) =>
      _backing.writeLatLng(hash, stream);

  @override
  Future<UvReader?> readUv(HourUtc t) async {
    UvReader? reader;

    final cache = await (_uvCache[t] ??= () async {
      // Ownership of this reader will be transferred to the
      // _RandomAccessUvReader below.
      reader = await _backing.readUv(t);
      return reader == null
          ? null
          : _RandomAccessUvCache(
              simulationTime: reader!.simulationTime,
              latlngHash: await reader!.readLatLngHash());
    }());

    if (cache is _RandomAccessUvCache) {
      return _RandomAccessUvReader(
          cache,
          reader != null
              ? Future.value(reader)
              : (() async => (await _backing.readUv(t))!)());
    } else if (cache is _CompleteUvCache) {
      assert(reader == null);
      return _CompleteUvReader(cache);
    } else {
      assert(cache == null);
      assert(reader == null);
      return null;
    }
  }

  @override
  Future<void> writeUv(
    SimulationTime s,
    Hex32 latlngHash,
    Stream<List<int>> vectorBytes,
  ) async {
    // Don't cache or start writing until we have all the data so that we get
    // older cache hits in the meantime. We could possibly do more complex
    // coordination to do something as the bytes come in, but that gets very
    // complex for minimal return.
    final bytes = await vectorBytes.toBytes();
    _uvCache[s.representedTimestamp] = Future.value(_CompleteUvCache(
      simulationTime: s,
      latlngHash: latlngHash,
      vectorBytes: bytes,
    ));
    await _backing.writeUv(s, latlngHash, Stream.value(bytes));
  }
}
