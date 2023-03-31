import 'package:equatable/equatable.dart';

class HourUtc extends Equatable implements Comparable<HourUtc> {
  HourUtc(int year, int month, int day, int hour)
      : this.fromDateTime(DateTime.utc(year, month, day, hour));
  HourUtc.fromDateTime(this.t)
      : assert(t.isUtc &&
            t.minute == 0 &&
            t.second == 0 &&
            t.millisecond == 0 &&
            t.microsecond == 0);
  HourUtc.truncate(DateTime t)
      : assert(t.isUtc),
        t = t.copyWith(
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
  HourUtc.fromHoursSinceEpoch(int hoursSinceEpoch)
      : t = DateTime.fromMillisecondsSinceEpoch(
            hoursSinceEpoch * Duration.millisecondsPerHour,
            isUtc: true);

  final DateTime t;

  @override
  get props => [t];

  /// This easily fits into 32 bits.
  int get hoursSinceEpoch =>
      t.millisecondsSinceEpoch ~/ Duration.millisecondsPerHour;

  int get year => t.year;
  int get month => t.month;
  int get day => t.day;
  int get hour => t.hour;

  HourUtc operator +(int hours) =>
      HourUtc.fromDateTime(t.copyWith(hour: t.hour + hours));
  HourUtc operator -(int hours) => this + -hours;

  @override
  int compareTo(HourUtc other) => t.compareTo(other.t);

  bool operator <(HourUtc other) => t.isBefore(other.t);
  bool operator >(HourUtc other) => t.isAfter(other.t);
  bool operator <=(HourUtc other) => !(this > other);
  bool operator >=(HourUtc other) => !(this < other);
  // == is defined by Equatable

  /// ISO 8601
  @override
  String toString() {
    final yyyy = t.year.toString().padLeft(4, '0'),
        mm = t.month.toString().padLeft(2, '0'),
        dd = t.day.toString().padLeft(2, '0'),
        hh = t.hour.toString().padLeft(2, '0');
    return '$yyyy-$mm-${dd}T${hh}Z';
  }
}
