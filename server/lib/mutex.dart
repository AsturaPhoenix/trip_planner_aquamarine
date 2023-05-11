import 'package:mutex/mutex.dart';

class VersionedReadWriteMutex extends ReadWriteMutex {
  var _version = Object();

  /// Completes true once the write has been acquired if no intervening writes
  /// have been acquired; false if other writes were acquired in the meantime.
  @override
  Future<bool> acquireWrite() async {
    final version = _version;
    await super.acquireWrite();
    final stable = version == _version;
    _version = Object();
    return stable;
  }
}

class MutexMap {
  final _backing = <Object, MapMutex>{};

  bool get isEmpty => _backing.isEmpty;

  MapMutex operator [](Object key) =>
      _backing[key] ??= MapMutex._(_backing, key);
}

class MapMutex extends VersionedReadWriteMutex {
  MapMutex._(this._map, this._key);
  final Map<Object, MapMutex> _map;
  final Object _key;

  /// Releases the mutex without performing cleanup on the underlying map. This
  /// is useful for changing the lock type on the mutex.
  void transientRelease() => super.release();

  @override
  void release() {
    super.release();
    if (!isLocked) {
      final removed = _map.remove(_key);
      assert(this == removed);
    }
  }
}
