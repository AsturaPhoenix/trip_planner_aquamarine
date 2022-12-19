import 'dart:async';

import 'optional.dart';

typedef ValueStream<T> = ValueStreamBase<T, T?>;
typedef InitializedValueStream<T> = ValueStreamBase<T, T>;

/// A dart-idiomatic version of rxdart's `ValueStream`, which plays well with
/// `StreamBuilder`s and doesn't necessarily exhibit #452.
abstract class ValueStreamBase<T extends Initial, Initial> {
  ValueStreamBase();

  /// Constructs a [ValueStream] that intercepts and caches values from a
  /// single-subscription stream. Using a [ValueStreamController] is preferred
  /// for broadcast cases, as using a stream means that [value] is updated
  /// asynchronously and only when there are listeners. The source need not
  /// necessarily prohibit multiple listeners, but ideally events should only
  /// publish once. If a broadcast is needed, it should be done using
  /// [transform].
  factory ValueStreamBase.fromSeededStream(Stream<T> source, Initial initial) {
    late _CachedValueStream<T, Initial> impl;
    impl = _CachedValueStream(
      source.map((e) {
        impl._value = e;
        return e;
      }),
      initial,
    );
    return impl;
  }

  static ValueStream<T> fromStream<T>(Stream<T> source) =>
      ValueStreamBase.fromSeededStream(source, null);

  Initial get value;
  Stream<T> get stream;

  late final Stream<Initial> seededStream = Stream.multi((controller) {
    controller
      ..add(value)
      ..addStream(stream);
  });

  ValueStreamBase<U, Initial> transform<U extends Initial>(
    Stream<U> Function(Stream<T> stream, Initial initialValue) transformation,
  ) =>
      _TransformedValueStream(this, transformation);
}

extension UninitializedMap<T extends Object> on ValueStream<T> {
  ValueStream<U> map<U>(U Function(T) f) => _MappedValueStream(this, f);
}

extension InitializedMap<T> on InitializedValueStream<T> {
  InitializedValueStream<U> map<U>(U Function(T) f) =>
      _MappedInitializedValueStream(this, f);
}

class _CachedValueStream<T extends Initial, Initial>
    extends ValueStreamBase<T, Initial> {
  _CachedValueStream(this.stream, this._value);

  @override
  Initial get value => _value;
  // populated externally
  Initial _value;
  @override
  final Stream<T> stream;
}

class _MappedValueStream<T, U> extends ValueStream<U> {
  _MappedValueStream(this.source, this.mapping);
  final ValueStream<T> source;
  final U Function(T) mapping;

  @override
  U? get value => Optional(source.value).map(mapping);
  @override
  late final stream = source.stream.map(mapping);
}

class _MappedInitializedValueStream<T, U> extends InitializedValueStream<U> {
  _MappedInitializedValueStream(this.source, this.mapping);
  final InitializedValueStream<T> source;
  final U Function(T) mapping;

  @override
  U get value => mapping(source.value);
  @override
  late final stream = source.stream.map(mapping);
}

class _TransformedValueStream<T extends Initial, U extends Initial, Initial>
    extends ValueStreamBase<U, Initial> {
  _TransformedValueStream(this.source, this.transformation);
  final ValueStreamBase<T, Initial> source;
  final Stream<U> Function(Stream<T> stream, Initial initialValue)
      transformation;

  @override
  Initial get value => source.value;
  @override
  late final stream = transformation(source.stream, source.value);
}

class CombinedValueStream<T extends Object, U extends Object, V>
    extends ValueStream<V> {
  CombinedValueStream(this.a, this.b, this.combine)
      : stream = Stream<V>.multi((controller) {
          final sa = a.stream.listen(
            (a) {
              if (b.value != null) controller.add(combine(a, b.value!));
            },
            onError: controller.addError,
          );
          final sb = b.stream.listen(
            (b) {
              if (a.value != null) controller.add(combine(a.value!, b));
            },
            onError: controller.addError,
          );
          controller.onCancel = () {
            sa.cancel();
            sb.cancel();
          };
        }).refCount();
  final ValueStream<T> a;
  final ValueStream<U> b;
  final V Function(T, U) combine;

  @override
  final Stream<V> stream;

  @override
  get value =>
      a.value == null || b.value == null ? null : combine(a.value!, b.value!);
}

typedef InitializedValueStreamController<T> = ValueStreamControllerBase<T, T>;

class ValueStreamControllerBase<T extends Initial, Initial> {
  ValueStreamControllerBase(this.streamController, Initial initialValue)
      : valueStream = _CachedValueStream(streamController.stream, initialValue);

  final StreamController<T> streamController;
  final ValueStreamBase<T, Initial> valueStream;

  void add(T value) {
    (valueStream as _CachedValueStream)._value = value;
    streamController.add(value);
  }
}

class ValueStreamController<T> extends ValueStreamControllerBase<T, T?> {
  ValueStreamController(StreamController<T> streamController)
      : super(streamController, null);
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
