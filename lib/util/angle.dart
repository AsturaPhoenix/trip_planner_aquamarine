import 'dart:math';

abstract class Angle {
  static const zero = Radians(0);

  const Angle();
  double get degrees;
  double get radians;
  Angle operator -();
  Angle operator +(Angle other);
  Angle operator -(Angle other) => this + -other;
  Angle operator *(double factor);
  Angle get norm360;
  Angle get norm180;
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
