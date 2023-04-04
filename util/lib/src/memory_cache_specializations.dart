import 'memory_cache.dart';

class Single<K, V extends Object> implements MemoryCache<K, V> {
  Single({this.onEvict});

  K? _key;
  V? _value;

  @override
  void Function(V value)? onEvict;

  @override
  int get capacity => 1;

  @override
  set capacity(int _) =>
      throw UnsupportedError('Cannot set the capacity of a singleton cache.');

  @override
  bool containsKey(K key) => _key == key;

  @override
  V? operator [](K key) => _key == key ? _value : null;
  @override
  operator []=(K key, V value) {
    _key = key;
    _value = value;
  }

  @override
  void clear() {
    _key = null;
    _value = null;
  }

  @override
  void evict(K key) {
    if (_key == key) {
      final value = _value!;
      _value = null;
      onEvict?.call(value);
    }
  }

  @override
  V? remove(K key, [V? value]) {
    if (_key == key && (value == null || _value == value)) {
      value = _value;
      clear();
      return value;
    } else {
      return null;
    }
  }
}

class Unbounded<K, V extends Object> implements MemoryCache<K, V> {
  Unbounded();

  final _data = <K, V>{};

  @override
  void Function(V value)? get onEvict => null;
  @override
  set onEvict(void Function(V value)? _) =>
      throw UnsupportedError('Unbounded cache does not support eviction.');

  @override
  int get capacity =>
      throw UnsupportedError('Unbounded cache does not have a capacity.');

  @override
  set capacity(int _) =>
      throw UnsupportedError('Unbounded cache does not have a capacity.');

  @override
  bool containsKey(K key) => _data.containsKey(key);

  @override
  V? operator [](K key) => _data[key];
  @override
  operator []=(K key, V value) => _data[key] = value;

  @override
  void evict(K _) =>
      throw UnsupportedError('Unbounded cache does not support eviction.');

  @override
  V? remove(K key, [V? value]) =>
      value == null || _data[key] == value ? _data.remove(key) : null;

  @override
  void clear() => _data.clear();
}
