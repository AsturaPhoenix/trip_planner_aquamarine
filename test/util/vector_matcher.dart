import 'package:test/test.dart';

class VectorIsCloseTo<T> extends TypeMatcher<T> {
  VectorIsCloseTo(
    this.value,
    this.delta, {
    required this.distance,
    double Function(T, T)? distanceSquared,
  }) : distanceSquared = distanceSquared ??
            ((a, b) {
              final d = distance(a, b);
              return d * d;
            });
  final T value;
  final num delta;
  final double Function(T, T) distance, distanceSquared;

  @override
  bool matches(dynamic item, Map matchState) =>
      super.matches(item, matchState) &&
      distanceSquared(value, item as T) <= delta * delta;

  @override
  Description describe(Description description) => description
      .add('a vector within ')
      .addDescriptionOf(delta)
      .add(' of ')
      .addDescriptionOf(value);

  @override
  Description describeMismatch(
    Object? item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    if (item is T) {
      return mismatchDescription
          .add(' differs by ')
          .addDescriptionOf(distance(value, item));
    }

    return super.describe(mismatchDescription.add('not an '));
  }
}
