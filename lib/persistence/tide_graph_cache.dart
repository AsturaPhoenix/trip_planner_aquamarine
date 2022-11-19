import 'package:joda/time.dart';

class TideGraphKey {
  TideGraphKey(this.stationId, this.begin, this.days);
  final String stationId;
  final Date begin;
  final int days;

  @override
  String toString() =>
      '$stationId@${begin.year}-${begin.month}-${begin.day}:$days';
}

// In the future we might want a more sophisticated cache that assembles graphs
// from pieces with different days, but there are a couple difficulties with
// this:
// * `tide` draws a '+' at `now`.
// * The graph shifts at the DST changes, including a quirk at fall-back.
