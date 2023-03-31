import 'package:meta/meta.dart';

abstract class AsyncCacheMap<K, V> {
  AsyncCacheMap();
  factory AsyncCacheMap.single() => _SingleAsyncCacheMap();
  factory AsyncCacheMap.ephemeral() => _EphemeralAsyncCacheMap();
  factory AsyncCacheMap.persistent() => _PersistentAsyncCacheMap();

  bool containsKey(K key);
  Future<V> computeIfAbsent(K key, Future<V> Function() operation);
  void clear();
}

class _SingleAsyncCacheMap<K, V> implements AsyncCacheMap<K, V> {
  K? _key;
  Future<V>? _future;

  @override
  void clear() {
    _key = null;
    _future = null;
  }

  @override
  Future<V> computeIfAbsent(K key, Future<V> Function() operation) {
    if (_key == key) return _future!;

    _key = key;
    late Future<V> wrapped;
    return _future = wrapped = operation().catchError((Object e) {
      if (_future == wrapped) {
        clear();
      }
      throw e;
    });
  }

  @override
  bool containsKey(K key) => _key == key;
}

abstract class _ClearOnlyAsyncCacheMap<K, V> implements AsyncCacheMap<K, V> {
  Map<K, Future<V>> _futures = {};

  bool containsKey(K key) => _futures.containsKey(key);

  Future<V> computeIfAbsent(K key, Future<V> Function() operation) {
    // Capture the map so that we can easily invalidate removal callbacks across
    // clears.
    final futures = _futures;
    return _futures[key] ??= wrapFuture(operation(), () {
      // This can't be a => even though the signature is void Function(), as
      // even then it seems to pass along the Future returned by remove to
      // whenComplete.
      futures.remove(key);
    });
  }

  void clear() {
    _futures.clear();
    _futures = {}; // Keep older futures from removing their replacements.
  }

  @protected
  Future<V> wrapFuture(Future<V> future, void Function() remove);
}

class _EphemeralAsyncCacheMap<K, V> extends _ClearOnlyAsyncCacheMap<K, V> {
  @override
  wrapFuture(Future<V> future, void Function() remove) =>
      future.whenComplete(remove);
}

class _PersistentAsyncCacheMap<K, V> extends _ClearOnlyAsyncCacheMap<K, V> {
  @override
  wrapFuture(Future<V> future, void Function() remove) =>
      future.catchError((Object e) {
        remove();
        throw e;
      });
}
