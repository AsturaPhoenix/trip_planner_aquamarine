import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import '../providers/trip_planner_client.dart';

class TideChart extends StatelessWidget {
  const TideChart({
    super.key,
    required this.client,
    required this.station,
    required this.t,
    this.days = 1,
    this.width = 455,
    this.height = 262,
    this.overlayColor = const Color(0xff999900),
  });

  final TripPlannerClient client;
  final Station station;
  final DateTime t;
  final int days;
  final double width, height;
  final Color overlayColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    assert(!t.isUtc);

    final ts = TZDateTime.from(t, client.timeZone);
    var t0 = TZDateTime(client.timeZone, ts.year, ts.month, ts.day);
    final timespan = Duration(days: days);

    if (days == 1 && t0.timeZone.isDst && !t0.add(timespan).timeZone.isDst) {
      // tides.php; For a single-day graph at the fall-back transition, xtide
      // draws starting from 1 AM PDT.
      t0 = t0.add(const Duration(hours: 1));
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: theme.colorScheme.secondaryContainer,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              alignment: Alignment.center,
              height: 31,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${station.type == 'tide' ? 'Tide Height' : 'Currents'}: ${station.shortTitle}',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            Expanded(
              child: DividerTheme(
                data: theme.dividerTheme
                    .copyWith(color: overlayColor.withAlpha(0x80)),
                child: DefaultTextStyle(
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(color: overlayColor),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -37,
                        child: Image.network(
                          client
                              .tideGraphUrl(
                                station,
                                1,
                                width.round(),
                                height.round() + 50,
                                t,
                              )
                              .toString(),
                        ),
                      ),
                      for (int h = 1; h < 24; ++h)
                        Positioned(
                          left: h * width / 24,
                          top: 0,
                          bottom: 0,
                          child: _HourGrid(t0.add(timespan * (h / 24))),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HourGrid extends StatelessWidget {
  const _HourGrid(this.t);

  final DateTime t;
  int get hour => t.hour;
  String get label => hour == 0
      ? 'm'
      : hour == 12
          ? 'n'
          : (hour % 12).toString();

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 0,
        child: Stack(
          children: [
            OverflowBox(
              maxWidth: double.infinity,
              alignment: Alignment.topCenter,
              child: Text(label),
            ),
            const VerticalDivider(),
          ],
        ),
      );
}
