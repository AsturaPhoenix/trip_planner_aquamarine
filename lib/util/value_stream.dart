import 'dart:async';

import 'optional.dart';

/// A dart-idiomatic version of rxdart's `ValueStream`, which plays well with
/// `StreamBuilder`s and doesn't necessarily exhibit #452.
abstract class ValueStream<T> {
  ValueStream();

  /// Constructs a [ValueStream] that intercepts and caches values from a
  /// single-subscription stream. Using a [ValueStreamController] is preferred
  /// for broadcast cases, as using a stream means that [value] is updated
  /// asynchronously and only when there are listeners. The source need not
  /// necessarily prohibit multiple listeners, but ideally events should only
  /// publish once. If a broadcast is needed, it should be done using
  /// [transform].
  factory ValueStream.fromStream(Stream<T> source) {
    late _CachedValueStream<T> impl;
    impl = _CachedValueStream(
      source.map((e) {
        impl._value = e;
        return e;
      }),
    );
    return impl;
  }

  T? get value;
  Stream<T> get stream;

  late final Stream<T?> seededStream = Stream.multi((controller) {
    controller
      ..add(value)
      ..addStream(stream);
  });

  ValueStream<U> map<U>(U Function(T) f) => _MappedValueStream(this, f);
  ValueStream<U> transform<U>(
    Stream<U> Function(Stream<T> stream, T? initialValue) transformation,
  ) =>
      _TransformedValueStream(this, transformation);
}

class _CachedValueStream<T> extends ValueStream<T> {
  _CachedValueStream(this.stream);

  @override
  T? get value => _value;
  // populated externally
  T? _value;
  @override
  final Stream<T> stream;
}

class _MappedValueStream<T, U> extends ValueStream<U> {
  _MappedValueStream(this.source, this.mapping);
  final ValueStream<T> source;
  final U Function(T) mapping;

  U? optionalMapping(T? value) => Optional(value).map(mapping);

  @override
  U? get value => optionalMapping(source.value);
  @override
  late final Stream<U> stream = source.stream.map(mapping);
}

class _TransformedValueStream<T, U> extends ValueStream<U> {
  _TransformedValueStream(this.source, this.transformation);
  final ValueStream<T> source;
  final Stream<U> Function(Stream<T> stream, T? initialValue) transformation;

  // This actually requires T extends U, but we can't enforce that because Dart
  // doesn't have generic lower bounds.
  @override
  U? get value => source.value as U?;
  @override
  late final Stream<U> stream = transformation(source.stream, source.value);
}

class ValueStreamController<T> {
  ValueStreamController(this.streamController)
      : valueStream = _CachedValueStream(streamController.stream);
  final StreamController<T> streamController;
  final ValueStream<T> valueStream;

  void add(T value) {
    (valueStream as _CachedValueStream)._value = value;
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
