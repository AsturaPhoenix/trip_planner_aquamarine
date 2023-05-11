import 'memory_cache_specializations.dart';

/// LRU cache backed by a map.
class MemoryCache<K, V extends Object> {
  MemoryCache({required this.capacity, this.onEvict});
  factory MemoryCache.single({void Function(V value)? onEvict}) =>
      Single(onEvict: onEvict);
  factory MemoryCache.unbounded() => Unbounded();

  final _data = <K, V>{};
  int capacity;

  /// Function called when a value is evicted. Subclasses should ensure that
  /// eviction is atomic prior to calling this callback.
  void Function(V value)? onEvict;

  bool containsKey(K key) => _data.containsKey(key);

  V? operator [](K key) {
    final value = _data.remove(key);
    if (value != null) {
      _data[key] = value;
    }
    return value;
  }

  operator []=(K key, V value) {
    _data.remove(key);
    _data[key] = value;
    while (_data.length > capacity) {
      evict(_data.keys.first);
    }
  }

  /// Removes the entry for [key] from the cache and calls [onEvict] if it was
  /// present.
  void evict(K key) {
    final evicted = _data.remove(key);
    if (evicted != null) {
      onEvict?.call(evicted);
    }
  }

  /// Removes the entry for [key] from the cache without calling [onEvict].
  /// A value can optionally be provided such that the entry is only removed if
  /// the value matches.
  V? remove(K key, [V? value]) =>
      value == null || _data[key] == value ? _data.remove(key) : null;

  /// Clears the cache without calling [onEvict];
  void clear() => _data.clear();
}
