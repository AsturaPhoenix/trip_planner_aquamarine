import 'dart:math';

abstract class Angle {
  static const zero = _Zero();

  const Angle();
  double get degrees;
  double get radians;
  Angle operator -();
  Angle operator +(Angle other);
  Angle operator -(Angle other) => this + -other;
  Angle operator *(double factor);
  Angle get norm360;
  Angle get norm180;

  @override
  operator ==(Object other) =>
      identical(this, other) || other is Angle && radians == other.radians;
  @override
  get hashCode => radians.hashCode;
}

class _Zero extends Angle {
  const _Zero();
  @override
  double get degrees => 0;
  @override
  double get radians => 0;
  @override
  Angle operator *(double factor) => this;
  @override
  Angle operator +(Angle other) => other;
  @override
  Angle operator -() => this;
  @override
  Angle get norm180 => this;
  @override
  Angle get norm360 => this;
}

class Degrees extends Angle {
  const Degrees(this.degrees);
  @override
  final double degrees;
  @override
  get radians => degrees * pi / 180;
  @override
  Angle operator -() => Degrees(-degrees);
  @override
  Angle operator +(Angle other) => Degrees(degrees + other.degrees);
  @override
  Angle operator *(double factor) => Degrees(degrees * factor);
  @override
  Angle get norm360 => Degrees(degrees % 360);
  @override
  Angle get norm180 => Degrees((degrees + 180) % 360 - 180);

  @override
  String toString() => '$degrees°';

  @override
  // This is just an optimization of super.operator ==. We can't optimize
  // hashCode the same way since it has to remain consistent.
  // ignore: hash_and_equals
  operator ==(Object other) =>
      identical(this, other) || other is Angle && degrees == other.degrees;
}

class Radians extends Angle {
  const Radians(this.radians);
  @override
  get degrees => radians * 180 / pi;
  @override
  final double radians;
  @override
  Angle operator -() => Radians(-radians);
  @override
  Angle operator +(Angle other) => Radians(radians + other.radians);
  @override
  Angle operator *(double factor) => Radians(radians * factor);
  @override
  Angle get norm360 => Radians(radians % (2 * pi));
  @override
  Angle get norm180 => Radians((radians + pi) % (2 * pi) - pi);

  @override
  String toString() => '$radians rad';
}
