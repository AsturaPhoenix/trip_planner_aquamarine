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

class TidePanel extends StatefulWidget {
  TidePanel({
    super.key,
    required this.client,
    required this.station,
    required this.t,
    this.graphWidth = 455,
    this.graphHeight = 231,
    OverlaySwatch? overlaySwatch,
    this.onTimeChanged,
  }) : overlaySwatch =
            overlaySwatch ?? OverlaySwatch.fromSeed(const Color(0xff999900));

  final TripPlannerClient client;
  final Station station;
  final DateTime t;
  final double graphWidth, graphHeight;
  final OverlaySwatch overlaySwatch;
  final void Function(DateTime t)? onTimeChanged;

  @override
  State<StatefulWidget> createState() => TidePanelState();
}

/// Represents a consistent time window configuration that is valid for the
/// graph.
class GraphTimeWindow {
  static TZDateTime _quantizeT0(TZDateTime t0, int days) {
    t0 = TZDateTime(t0.location, t0.year, t0.month, t0.day);

    // tides.php; For a single-day graph at the fall-back transition, xtide
    // draws starting from 1 AM PDT.
    if (days == 1 &&
        t0.timeZone.isDst &&
        !t0.add(const Duration(days: 1)).timeZone.isDst) {
      t0 = t0.add(const Duration(hours: 1));
    }

    return t0;
  }

  static bool _isMidnight(TZDateTime t) =>
      t == TZDateTime(t.location, t.year, t.month, t.day);

  GraphTimeWindow._(this.t0, this.t, this.days) {
    assert(!t0.isAfter(t) && !t0.add(timespan).isBefore(t));
  }

  /// A graph time window where [t] falls on the leading day.
  factory GraphTimeWindow.leftAligned(TZDateTime t, int days) {
    var t0 = _quantizeT0(t, days);

    if (t0.isAfter(t)) {
      // This can only happen if we're [12AM-1AM) on the fall-back transition in a
      // 1-day window, and we can only show this time on a multi-day window.
      days = 2;
      t0 = _quantizeT0(t, days);
    }

    return GraphTimeWindow._(t0, t, days);
  }

  /// A graph time window where [t] falls on the trailing day.
  factory GraphTimeWindow.rightAligned(TZDateTime t, int days) {
    var t0 = _quantizeT0(
      t.subtract(Duration(days: _isMidnight(t) ? days : days - 1)),
      days,
    );

    if (t0.isAfter(t)) {
      // This can only happen if we're (12AM-1AM) on the fall-back transition in a
      // 1-day window, and we can only show this time on a multi-day window.
      days = 2;
      t0 = _quantizeT0(t.subtract(const Duration(days: 1)), days);
    } else if (t0.add(Duration(days: days)).isBefore(t)) {
      // This is the trailing end of a multi-day fall-back window.
      t0 = _quantizeT0(
        t.subtract(Duration(days: _isMidnight(t) ? days - 1 : days - 2)),
        days,
      );
    }

    return GraphTimeWindow._(t0, t, days);
  }

  /// [t0] is set from the year, month, and day, and location of the given time,
  /// and is adjusted so that the window includes [t].
  ///
  /// The adjustment is chosen to minimize the number of changes while
  /// "scrolling", so `t < t0` will adjust to a right-aligned window and
  /// `t > t0 + timespan` will adjust to a left-aligned window.
  factory GraphTimeWindow(TZDateTime t0, DateTime t, int days) {
    t0 = _quantizeT0(t0, days);

    if (t0.isAfter(t)) {
      return GraphTimeWindow.rightAligned(
        TZDateTime.from(t, t0.location),
        days,
      );
    } else if (t0.add(Duration(days: days)).isBefore(t)) {
      return GraphTimeWindow.leftAligned(TZDateTime.from(t, t0.location), days);
    } else {
      return GraphTimeWindow._(t0, t, days);
    }
  }

  final TZDateTime t0;
  final DateTime t;
  final int days;
  Duration get timespan => Duration(days: days);
  TZDateTime lerp(double f) => t0.add(timespan * f);

  /// Creates a copy with the given overrides, potentially adjusting the window
  /// to contain [t].
  GraphTimeWindow copyWith({TZDateTime? t0, DateTime? t, int? days}) =>
      GraphTimeWindow(t0 ?? this.t0, t ?? this.t, days ?? this.days);
}

class TidePanelState extends State<TidePanel> {
  late GraphTimeWindow timeWindow = GraphTimeWindow.leftAligned(
    TZDateTime.from(widget.t, widget.client.timeZone),
    1,
  );

  @override
  void didUpdateWidget(TidePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    timeWindow = timeWindow.copyWith(t: widget.t);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: visual feedback of current selections (today/weekend/days)
    // TODO: date picker
    return SizedBox(
      width: widget.graphWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: theme.colorScheme.secondaryContainer,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: FittedBox(
              child: Text(
                '${widget.station.type == 'tide' ? 'Tide Height' : 'Currents'}: ${widget.station.shortTitle}',
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          FittedBox(
            child: TideGraph(
              client: widget.client,
              station: widget.station,
              timeWindow: timeWindow,
              width: widget.graphWidth,
              height: widget.graphHeight,
              overlaySwatch: widget.overlaySwatch,
              onTimeChanged: widget.onTimeChanged,
            ),
          ),
          FittedBox(
            child: TimeControls(
              timeZone: widget.client.timeZone,
              timeWindow: timeWindow,
              onWindowChanged: (timeWindow) {
                setState(() => this.timeWindow = timeWindow);
                widget.onTimeChanged?.call(timeWindow.t);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TideGraph extends StatelessWidget {
  static const dayLabels = [
    '',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  const TideGraph({
    super.key,
    required this.client,
    required this.station,
    required this.timeWindow,
    required this.width,
    required this.height,
    required this.overlaySwatch,
    this.onTimeChanged,
  });

  final TripPlannerClient client;
  final Station station;
  final GraphTimeWindow timeWindow;
  final double width, height;
  final OverlaySwatch overlaySwatch;
  final void Function(DateTime t)? onTimeChanged;

  @override
  Widget build(BuildContext context) {
    int gridDivisions = timeWindow.days == 7 ? 14 : 24;
    return SizedBox(
      width: width,
      height: height,
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
                      timeWindow.days,
                      width.round(),
                      height.round() + 81,
                      timeWindow.t0,
                    )
                    .toString(),
              ),
            ),
            for (int t = 1; t < gridDivisions; ++t)
              Positioned(
                left: t * width / gridDivisions,
                top: 0,
                bottom: 0,
                child: _HourGrid(
                  timeWindow.lerp(t / gridDivisions),
                  swatch: overlaySwatch.grid,
                ),
              ),
            for (int d = 0; d < timeWindow.days; ++d)
              Positioned(
                left: d * width / timeWindow.days,
                width: width / timeWindow.days,
                bottom: 0,
                child: Text(
                  dayLabels[
                      timeWindow.lerp((d + .5) / timeWindow.days).weekday],
                  textAlign: TextAlign.center,
                ),
              )
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

class TimeControls extends StatelessWidget {
  static TZDateTime nextWeekday(TZDateTime t, int weekday) =>
      t.add(Duration(days: (weekday - t.weekday) % 7));

  // TODO: Joda/FluxCapacitor port. The caveats here:
  // * Spring-forward hole: 2 AM becomes 1 AM.
  // * Fall-back ambiguity: 1 AM is in DST.
  static TZDateTime addDays(TZDateTime t, int days) {
    final r = DateTime.utc(
      t.year,
      t.month,
      t.day,
      t.hour,
      t.minute,
      t.second,
      t.millisecond,
      t.microsecond,
    ).add(Duration(days: days));
    return TZDateTime(
      t.location,
      r.year,
      r.month,
      r.day,
      r.hour,
      r.minute,
      r.second,
      r.millisecond,
      r.microsecond,
    );
  }

  const TimeControls({
    super.key,
    required this.timeZone,
    required this.timeWindow,
    this.onWindowChanged,
  });

  final Location timeZone;
  final GraphTimeWindow timeWindow;
  final void Function(GraphTimeWindow window)? onWindowChanged;

  void Function()? _changeTime(int days) => onWindowChanged == null
      ? null
      : () => onWindowChanged!(
            timeWindow.copyWith(
              t0: addDays(timeWindow.t0, days),
              t: addDays(TZDateTime.from(timeWindow.t, timeZone), days),
            ),
          );

  void Function()? _changeDays(int days) => onWindowChanged == null
      ? null
      : () => onWindowChanged!(
            timeWindow.copyWith(days: days),
          );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        dividerTheme:
            theme.dividerTheme.copyWith(indent: 8, endIndent: 8, space: 8),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(minimumSize: Size.zero),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            IconButton(
              onPressed: _changeTime(-1),
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
            const Text('Day'),
            IconButton(
              onPressed: _changeTime(1),
              icon: const Icon(Icons.keyboard_arrow_right),
            ),
            const VerticalDivider(),
            IconButton(
              onPressed: _changeTime(-7),
              icon: const Icon(Icons.keyboard_double_arrow_left),
            ),
            const Text('Week'),
            IconButton(
              onPressed: _changeTime(7),
              icon: const Icon(Icons.keyboard_double_arrow_right),
            ),
            const VerticalDivider(),
            TextButton(
              onPressed: onWindowChanged == null
                  ? null
                  : () {
                      onWindowChanged!(
                        GraphTimeWindow.leftAligned(
                          TZDateTime.now(timeZone),
                          1,
                        ),
                      );
                    },
              child: const Text('Today'),
            ),
            const VerticalDivider(),
            TextButton(
              onPressed: onWindowChanged == null
                  ? null
                  : () {
                      onWindowChanged!(
                        GraphTimeWindow.leftAligned(
                          nextWeekday(
                            TZDateTime.now(timeZone),
                            DateTime.saturday,
                          ),
                          2,
                        ),
                      );
                      // Even if it's Sunday, go to next Saturday.
                    },
              child: const Text('Weekend'),
            ),
            const VerticalDivider(),
            TextButton(
              onPressed: _changeDays(1),
              child: const Text('1'),
            ),
            TextButton(
              onPressed: _changeDays(2),
              child: const Text('2'),
            ),
            TextButton(
              onPressed: _changeDays(4),
              child: const Text('4'),
            ),
            TextButton(
              onPressed: _changeDays(7),
              child: const Text('7'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('days'),
            ),
          ],
        ),
      ),
    );
  }
}
