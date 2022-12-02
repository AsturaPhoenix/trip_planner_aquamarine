import 'package:joda/time.dart';
import 'package:test/test.dart';
import 'package:timezone/data/latest.dart';
import 'package:trip_planner_aquamarine/widgets/tide_panel.dart';

void main() {
  initializeTimeZones();
  final tz = TimeZone.forId('America/Los_Angeles');

  group('GraphTimeWindow', () {
    test(
        '1-day window on a fall-back boundary should adjust t0 by an hour to '
        'correspond with xtide behavior', () {
      final t = DateTime.resolve(const Date(2022, 11, 6) & Time.zero, tz);
      expect(
        GraphTimeWindow(t, t, 1, TimeWindowCorrectionPolicy.preserveBounds).t0,
        DateTime.resolve(
          const Date(2022, 11, 6) & const Time(1, 0),
          tz,
          fallBack: Resolvers.fallBackEarlier,
        ),
      );
    });

    test(
        'adding a day at midnight before fall-back should advance the window '
        'to the next day', () {
      final t = DateTime.resolve(const Date(2022, 11, 5) & Time.zero, tz);
      final w =
          GraphTimeWindow(t, t, 1, TimeWindowCorrectionPolicy.preserveBounds);
      expect(
        (w + const Period(days: 1)).t0.date,
        w.t0.date + const Period(days: 1),
      );
    });

    test(
        'adding a day to a multi-day window towards the end of the day before '
        'fall-back should advance the window to the next day', () {
      final w = GraphTimeWindow(
        DateTime.resolve(const Date(2022, 11, 4) & Time.zero, tz),
        DateTime.resolve(const Date(2022, 11, 6) & Time.zero, tz),
        2,
        TimeWindowCorrectionPolicy.preserveBounds,
      );
      expect(
        (w + const Period(days: 1)).t0.date,
        w.t0.date + const Period(days: 1),
      );
    });
  });
}
