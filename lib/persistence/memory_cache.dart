/// LRU cache backed by a map.
class MemoryCache<K, V extends Object> {
  MemoryCache({required this.capacity, this.onEvict});
  final _data = <K, V>{};
  int capacity;
  void Function(V value)? onEvict;

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
      final evicted = _data.remove(_data.keys.first)!;
      onEvict?.call(evicted);
    }
  }
}
