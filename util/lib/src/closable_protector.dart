import 'dart:async';

/// Protects a disposable object from leaking through the stream contract.
///
/// Streams are generally allowed to buffer and discard events if a subscription
/// is cancelled. This means they're likely to leak if events need to be
/// disposed. This could be worked around using a custom controller/sync/stream
/// trinity, but it seems a shame to reimplement so much and lose `await for`
/// and `async*` syntax.
///
/// In `async*` generators, `yield` may drop its value on the floor when a
/// stream subscription is cancelled, which can orphan values that may need to
/// be cleaned up. This function wraps the value in a stream that executes the
/// [close] callback if the subscription is cancelled.
///
/// Unfortunately the language spec and implementations are a bit of a mess for
/// this kind of edge case, and some potential implementations can produce
/// different results on vm and dart2js. For example, if a stream is cancelled
/// synchronously after receiving an event, dart2js will execute code after the
/// `yield` that produced the event, but the vm will not.
///
/// It's unclear whether there's an issue filed for this particular
/// inconsistency.
/// https://github.com/dart-lang/sdk/issues?page=1&q=is%3Aissue+is%3Aopen+yield+stream
///
/// `yield*` may also never actually start listening to a stream if the
/// subscription was cancelled. This seems to be contrary to the language spec.
/// https://dart.dev/guides/language/spec
/// https://github.com/dart-lang/language/blob/main/accepted/future-releases/async-star-behavior/feature-specification.md
///
/// Thus, a safe way to guard against all of this is:
///
/// ```dart
/// final protector = ClosableProtector(value);
/// try {
///   yield* protector.stream;
/// } finally {
///   protector.close(); // optionally awaited
/// }
/// ```
class ClosableProtector<T> {
  ClosableProtector(
    T value, [
    FutureOr<void> Function(T) close = _defaultClose,
  ]) : // Use a sync controller to atomically clear the cancel callback and deliver
        // the event. Use `await null` (i.e. `scheduleMicrotask`) to stick with the
        // stream contract.
        _controller = StreamController<T>(
          onCancel: () => close(value),
          sync: true,
        ) {
    _controller.onListen = () async {
      await null;
      _controller.onCancel = null;
      _controller.add(value);
      await null;
      _controller.close();
    };
  }

  final StreamController<T> _controller;
  Stream<T> get stream => _controller.stream;
  FutureOr<void> close() => _controller.onCancel?.call();
}

FutureOr<void> _defaultClose(dynamic value) => value.close();
