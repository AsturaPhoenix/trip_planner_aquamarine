import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

import '../providers/trip_planner_client.dart';

class GridSwatch {
  const GridSwatch({
    required this.hourly,
    required this.noon,
    required this.midnight,
  });
  GridSwatch.fromSeed(Color seed)
      : this(
          hourly: Color.lerp(seed, null, .5)!,
          noon: Color.lerp(seed, null, .25)!,
          midnight: Color.lerp(seed, Colors.black, .5)!,
        );

  final Color hourly, noon, midnight;
}

class OverlaySwatch {
  const OverlaySwatch({required this.text, required this.grid});
  OverlaySwatch.fromSeed(Color seed)
      : this(text: seed, grid: GridSwatch.fromSeed(seed));

  final Color text;
  final GridSwatch grid;
}

class TideChart extends StatelessWidget {
  TideChart({
    super.key,
    required this.client,
    required this.station,
    required this.t,
    this.days = 1,
    this.width = 455,
    this.height = 262,
    OverlaySwatch? overlaySwatch,
  }) : overlaySwatch =
            overlaySwatch ?? OverlaySwatch.fromSeed(const Color(0xff999900));

  final TripPlannerClient client;
  final Station station;
  final DateTime t;
  final int days;
  final double width, height;
  final OverlaySwatch overlaySwatch;

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
              child: DefaultTextStyle(
                style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(color: overlaySwatch.text),
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
                        child: _HourGrid(
                          t0.add(timespan * (h / 24)),
                          swatch: overlaySwatch.grid,
                        ),
                      )
                  ],
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
  const _HourGrid(this.t, {required this.swatch});

  final DateTime t;
  int get hour => t.hour;
  String get label => hour == 0
      ? 'm'
      : hour == 12
          ? 'n'
          : (hour % 12).toString();

  final GridSwatch swatch;

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
            VerticalDivider(
              color: hour == 0
                  ? swatch.midnight
                  : hour == 12
                      ? swatch.noon
                      : swatch.hourly,
            ),
          ],
        ),
      );
}
