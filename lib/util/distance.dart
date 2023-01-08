enum DistanceSystem {
  miles('mi'),
  kilometers('km'),
  nauticalMiles('nm');

  const DistanceSystem(this.description);
  final String description;
}

abstract class Distance {
  static const zero = Meters(0);

  const Distance();
  double get kilometers;
  double get meters;
  double get miles;
  double get feet;
  double get nauticalMiles;
  Distance operator -();
  Distance operator +(Distance other);
  Distance operator -(Distance other) => this + -other;
  Distance operator *(double factor);
}

class Meters extends Distance {
  const Meters(this.meters);
  @override
  double get kilometers => meters / 1000;
  @override
  final double meters;
  @override
  get miles => kilometers * 0.621371;
  @override
  get feet => miles * 5280;
  @override
  get nauticalMiles => miles * 0.868976;
  @override
  Distance operator -() => Meters(-meters);
  @override
  Distance operator +(Distance other) => Meters(meters + other.meters);
  @override
  Distance operator *(double factor) => Meters(meters * factor);
}

class Speed implements Comparable<Speed> {
  static const zero = Speed(Meters(0), Duration(seconds: 1));

  static String systemDescription(DistanceSystem distanceSystem) {
    switch (distanceSystem) {
      case DistanceSystem.miles:
        return 'mph';
      case DistanceSystem.kilometers:
        return 'kph';
      case DistanceSystem.nauticalMiles:
        return 'kt';
    }
  }

  const Speed(this.distance, this.time);
  final Distance distance;
  final Duration time;
  double get _hours => time.inMicroseconds / Duration.microsecondsPerHour;
  double get mph => distance.miles / _hours;
  double get kph => distance.kilometers / _hours;
  double get kt => distance.nauticalMiles / _hours;

  @override
  int compareTo(Speed other) => kph.compareTo(other.kph);

  double forSystem(DistanceSystem distanceSystem) {
    switch (distanceSystem) {
      case DistanceSystem.miles:
        return mph;
      case DistanceSystem.kilometers:
        return kph;
      case DistanceSystem.nauticalMiles:
        return kt;
    }
  }
}
