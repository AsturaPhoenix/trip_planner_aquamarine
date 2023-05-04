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
