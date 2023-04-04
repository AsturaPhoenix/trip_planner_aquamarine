import 'memory_cache.dart';

class AsyncCache<K, V> {
  AsyncCache.single() : this.persistent(MemoryCache.single());
  AsyncCache.ephemeral([MemoryCache<K, Future<V>>? backing])
      : _futures = backing ?? MemoryCache.unbounded(),
        _wrapFuture = ((future, remove) => future.whenComplete(remove));
  AsyncCache.persistent([MemoryCache<K, Future<V>>? backing])
      : _futures = backing ?? MemoryCache.unbounded(),
        _wrapFuture = ((future, remove) => future.catchError((Object e) {
              remove();
              throw e;
            }));

  final MemoryCache<K, Future<V>> _futures;
  final Future<V> Function(Future<V> future, void Function() remove)
      _wrapFuture;

  bool containsKey(K key) => _futures.containsKey(key);

  Future<V> computeIfAbsent(K key, Future<V> Function() operation) {
    late Future<V> wrapped;
    return _futures[key] ??= wrapped = _wrapFuture(operation(), () {
      // This can't be a => even though the signature is void Function(), as
      // even then it seems to pass along the Future returned by remove to
      // whenComplete.
      _futures.remove(key, wrapped);
    });
  }

  void clear() => _futures.clear();
}
