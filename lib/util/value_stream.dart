import 'dart:async';

/// A dart-idiomatic version of rxdart's `ValueStream`, which plays well with
/// `StreamBuilder`s and doesn't necessarily exhibit #452.
class ValueStream<T> {
  ValueStream(this.stream);
  T? get value => _value;
  T? _value;
  final Stream<T> stream;
  late final Stream<T?> seededStream = Stream.multi((controller) {
    controller
      ..add(value)
      ..addStream(stream);
  });
}

class ValueStreamController<T> {
  ValueStreamController(
    this.streamController, [
    Stream<T> Function(Stream<T>)? streamTransformations,
  ]) : valueStream = ValueStream(
          streamTransformations == null
              ? streamController.stream
              : streamTransformations(streamController.stream),
        );
  final StreamController<T> streamController;
  final ValueStream<T> valueStream;

  void add(T value) {
    valueStream._value = value;
    streamController.add(value);
  }
}

extension RefCount<T> on Stream<T> {
  /// Like [Stream.asBroadcastStream] or rxdart `share`, but cancels when there
  /// are no listeners and resubscribes if new listeners are added later. This
  /// requires that the source stream support multiple listeners.
  Stream<T> refCount() {
    StreamSubscription? subscription;
    final controller = StreamController<T>.broadcast();
    controller.onListen = () => subscription = listen(controller.add);
    controller.onCancel = () => subscription!.cancel();
    return controller.stream;
  }
}
