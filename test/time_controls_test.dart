import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joda/time.dart';
import 'package:timezone/data/latest_10y.dart';

import 'package:trip_planner_aquamarine/widgets/tide_panel.dart';

void main() {
  initializeTimeZones();
  final timeZone = TimeZone.forId('America/Los_Angeles');

  GraphTimeWindow testWindow(Date t0, LocalDateTime t, int days) =>
      GraphTimeWindow(
        DateTime.atStartOfDay(t0, timeZone),
        DateTime.resolve(t, timeZone),
        days,
        TimeWindowCorrectionPolicy.strict,
      );

  GraphTimeWindow? result;

  Widget buildTestHarness(GraphTimeWindow timeWindow) => MaterialApp(
        home: Scaffold(
          body: TimeControls(
            timeWindow: timeWindow,
            onWindowChanged: (timeWindow) => result = timeWindow,
          ),
        ),
      );

  testWidgets('shifts window when date is picked', (tester) async {
    await tester.pumpWidget(
      buildTestHarness(
        testWindow(
          const Date(2022, 12, 4),
          const Date(2022, 12, 5) & const Time(4, 30),
          4,
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.calendar_month));
    await tester.pump();
    await tester.tap(find.text('6'));
    await tester.tap(find.text('OK'));

    expect(
      result,
      testWindow(
        const Date(2022, 12, 5),
        const Date(2022, 12, 6) & const Time(4, 30),
        4,
      ),
    );
  });

  testWidgets('preserves offset around fall back', (tester) async {
    await tester.pumpWidget(
      buildTestHarness(
        testWindow(
          const Date(2022, 11, 5),
          const Date(2022, 11, 5) & const Time(0, 30),
          1,
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.keyboard_arrow_right));

    expect(
      result,
      testWindow(
        const Date(2022, 11, 6),
        const Date(2022, 11, 6) & const Time(1, 30),
        1,
      ),
    );
  });

  testWidgets('preserves offset around spring forward', (tester) async {
    await tester.pumpWidget(
      buildTestHarness(
        testWindow(
          const Date(2022, 3, 14),
          const Date(2022, 3, 14) & const Time(2, 30),
          1,
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.keyboard_arrow_left));

    expect(
      result,
      testWindow(
        const Date(2022, 3, 13),
        const Date(2022, 3, 13) & const Time(3, 30),
        1,
      ),
    );
  });
}
