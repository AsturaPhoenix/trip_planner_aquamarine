import 'package:logging/logging.dart';

/// Similar to [pacakge:async/async.dart AsyncCache.ephemeral()], but triggers
/// the last of any concurrent operations attempted while one is already
/// underway after the one underway has completed.
class AsyncThrottle {
  static final log = Logger('AsyncThrottle');

  bool _busy = false, _disposed = false;
  Object? _key, _nextKey;
  Iterable<Future<void> Function()>? _next;

  void dispose() => _disposed = true;

  void clearNext() {
    _next = null;
    _nextKey = null;
  }

  /// Schedules a sequence of operations. Subsequent calls pre-empt sequences
  /// previously scheduled. [key], if supplied, will deduplicate the sequences
  /// so that two consecutive sequences with the same key will not be executed.
  ///
  /// A different way to implement such operations could be to use
  /// [package:async/async.dart CancellableOperation]. However, they [key]
  /// functionality wouldn't work as well as operations can't be uncancelled, so
  /// sequences pre-empted by subsequent unique operations couldn't then be
  /// resumed if a later operation had the same key.
  void schedule(Iterable<Future<void> Function()> operations, {Object? key}) {
    assert(!_disposed);

    if (key != null && _key == key) {
      clearNext();
      return;
    }

    _next = operations;
    _nextKey = key;

    if (!_busy) {
      _busy = true;
      () async {
        while (_next != null) {
          final current = _next!;
          _next = null;
          _key = _nextKey;
          _nextKey = null;

          try {
            for (final task in current) {
              await task();
              if (_disposed) return;
              if (_next != null) break;
            }
          } on Exception catch (e) {
            log.warning('Uncaught', e);
            // TODO(AsturaPhoenix): Expose _busy and make AsyncThrottle
            // observable, and expose the last thrown exception. This can be
            // used for a spinner UI that indicates whether there was an error.
          }
        }
        _busy = false;
      }();
    }
  }
}
