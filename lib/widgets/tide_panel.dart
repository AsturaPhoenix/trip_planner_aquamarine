import 'dart:core';
import 'dart:core' as core;
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:joda/time.dart';
import 'package:logging/logging.dart';

import '../providers/trip_planner_client.dart';
import '../util/optional.dart';

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
  static const double defaultGraphWidth = 455, defaultGraphHeight = 231;

  // TODO: It might be nice to use a layout dryrun, but right now it looks like
  // we'd have to override a lot to make that happen.
  static double estimateHeight(
    BuildContext context,
    double maxWidth, {
    double graphWidth = defaultGraphWidth,
    double graphHeight = defaultGraphHeight,
  }) {
    final double timeControlsHeight =
        Theme.of(context).materialTapTargetSize == MaterialTapTargetSize.padded
            ? 48
            : 40;

    double scale(double nominalWidth, double nominalHeight) =>
        nominalHeight * min(1, maxWidth / nominalWidth);
    return scale(graphWidth, graphHeight + 31 + 24) +
        scale(503, timeControlsHeight);
  }

  TidePanel({
    super.key,
    required this.client,
    required this.station,
    required this.t,
    this.graphWidth = defaultGraphWidth,
    this.graphHeight = defaultGraphHeight,
    OverlaySwatch? overlaySwatch,
    this.onTimeChanged,
    this.onModal,
  }) : overlaySwatch =
            overlaySwatch ?? OverlaySwatch.fromSeed(const Color(0xff999900));

  final TripPlannerClient client;
  final Station station;
  final Instant t;
  final double graphWidth, graphHeight;
  final OverlaySwatch overlaySwatch;
  final void Function(Instant t)? onTimeChanged;
  final void Function(bool modal)? onModal;

  @override
  State<StatefulWidget> createState() => TidePanelState();
}

/// Determines how to correct [GraphTimeWindow]s where [GraphTimeWindow.t] falls
/// outside the window bounds.
enum TimeWindowCorrectionPolicy {
  /// The bounds are adjusted. The adjustment is chosen to minimize the number
  /// of changes while "scrolling", so `t < t0` will adjust to a right-aligned
  /// window and `t > t0 + timespan` will adjust to a left-aligned window.
  preserveTime,

  /// [GraphTimeWindow.t] is clamped to the bounds.
  preserveBounds,

  /// The bounds are adjusted as in [preserveTime], but if an adjustment to
  /// [GraphTimeWindow.days] would be necessary due to DST quirks,
  /// [GraphTimeWindow.t] is adjusted instead.
  preserveDays,
}

/// Represents a consistent time window configuration that is valid for the
/// graph.
class GraphTimeWindow {
  static DateTime _quantizeT0(DateTime t0, int days) {
    t0 = t0.withTimeAtStartOfDay();

    // tides.php; For a single-day graph at the fall-back transition, xtide
    // draws starting from 1 AM PDT.
    if (days == 1 && t0.isDst && !(t0 + const Period(days: 1)).isDst) {
      t0 += const Duration(hours: 1);
    }

    return t0;
  }

  GraphTimeWindow._(this.t0, this.t, this.days) {
    assert(t0 <= t && t <= t0 + timespan);
  }

  /// A graph time window where [t] falls on the leading day. [mayMove]
  /// determines whether we will adjust [t] if it falls outside the normal
  /// window due to DST quirks or instead change the window.
  factory GraphTimeWindow.leftAligned(DateTime t, int days, bool mayMove) {
    var t0 = _quantizeT0(t, days);

    if (t < t0) {
      // This can only happen if we're [12AM-1AM) on the fall-back transition in
      // a 1-day window, and we can only show this time on a multi-day window.
      if (mayMove) {
        t += const Duration(hours: 1);
      } else {
        days = 2;
        t0 = _quantizeT0(t, days);
      }
    }

    return GraphTimeWindow._(t0, t, days);
  }

  /// A graph time window where [t] falls on the trailing day. [mayMove]
  /// determines whether we will adjust [t] if it falls outside the normal
  /// window due to DST quirks or instead change the window.
  factory GraphTimeWindow.rightAligned(DateTime t, int days, bool mayMove) {
    var t0 = _quantizeT0(
      t - Period(days: t.time == Time.zero ? days : days - 1),
      days,
    );

    if (t < t0) {
      // This can only happen if we're (12AM-1AM) on the fall-back transition in
      // a 1-day window, and we can only show this time on a multi-day window.
      if (mayMove) {
        t += const Duration(hours: 1);
      } else {
        days = 2;
        t0 = _quantizeT0(t - const Period(days: 1), days);
      }
    } else if (t0 + Period(days: days) < t) {
      // This is the trailing end of a multi-day fall-back window.
      if (mayMove) {
        t -= const Duration(hours: 1);
      } else {
        t0 = _quantizeT0(t0 - const Period(days: 1), days);
      }
    }

    return GraphTimeWindow._(t0, t, days);
  }

  /// Creates a time window corresponding with an `xtide` graph.
  ///
  /// [t0] may be adjusted to conform with `xtide` behavior. Then if [t] falls
  /// outside the window, it is adjusted according to [correctionPolicy].
  factory GraphTimeWindow(
    DateTime t0,
    Instant t,
    int days,
    TimeWindowCorrectionPolicy correctionPolicy,
  ) {
    t0 = _quantizeT0(t0, days);

    if (t < t0) {
      if (correctionPolicy == TimeWindowCorrectionPolicy.preserveBounds) {
        return GraphTimeWindow._(t0, t0, days);
      } else {
        return GraphTimeWindow.rightAligned(
          DateTime(t, t0.timeZone),
          days,
          correctionPolicy == TimeWindowCorrectionPolicy.preserveDays,
        );
      }
    } else {
      final tf = t0 + Duration(days: days);
      if (tf < t) {
        if (correctionPolicy == TimeWindowCorrectionPolicy.preserveBounds) {
          return GraphTimeWindow._(t0, tf, days);
        } else {
          return GraphTimeWindow.leftAligned(
            DateTime(t, t0.timeZone),
            days,
            correctionPolicy == TimeWindowCorrectionPolicy.preserveDays,
          );
        }
      } else {
        return GraphTimeWindow._(t0, t, days);
      }
    }
  }

  final DateTime t0;
  final Instant t;
  final int days;
  Duration get timespan => Duration(days: days);
  Instant get tf => t0 + timespan;
  DateTime lerp(double f) => t0 + timespan * f;

  /// Creates a copy with the given overrides, potentially adjusting the window
  /// to contain [t]. If [mayMove] is true, [t] itself may be adjusted as well.
  GraphTimeWindow copyWith({
    DateTime? t0,
    Instant? t,
    int? days,
    required TimeWindowCorrectionPolicy correctionPolicy,
  }) =>
      GraphTimeWindow(
        t0 ?? this.t0,
        t ?? this.t,
        days ?? this.days,
        correctionPolicy,
      );

  /// Shifts a [GraphTimeWindow] by the given [Period]. If [t] falls on a DST
  /// edge case, it is adjusted. Furthermore, if [days] = 1,
  /// [Resolvers.fallBackLater] is used since xtide ends up shifting the graph
  /// start by an hour anyway; combined with the [t] adjustment for [12AM-1AM),
  /// this creates a continuous mapping.
  GraphTimeWindow operator +(Period period) {
    return copyWith(
      t0: t0.add(period, fallBack: Resolvers.fallBackLater),
      t: DateTime(t, t0.timeZone)
          .add(period, fallBack: Resolvers.fallBackLater),
      correctionPolicy: TimeWindowCorrectionPolicy.preserveBounds,
    );
  }
}

class TidePanelState extends State<TidePanel> {
  late GraphTimeWindow timeWindow = GraphTimeWindow.leftAligned(
    DateTime(widget.t, widget.client.timeZone),
    1,
    false,
  );

  @override
  void didUpdateWidget(TidePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.t != oldWidget.t) {
      timeWindow = timeWindow.copyWith(
        t: widget.t,
        correctionPolicy: TimeWindowCorrectionPolicy.preserveTime,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: visual feedback of current selections (today/weekend/days)
    // TODO: date picker
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        var effectiveMaxWidth = double.infinity;
        // Compensating for width scaling can inflate the time controls a
        // little, so do a couple layout estimations.
        for (int i = 0; i < 2; ++i) {
          final preferredHeight = TidePanel.estimateHeight(
            context,
            effectiveMaxWidth,
            graphWidth: widget.graphWidth,
            graphHeight: widget.graphHeight,
          );
          effectiveMaxWidth = boxConstraints.maxWidth *
              max(1, preferredHeight / boxConstraints.maxHeight);
        }

        return FittedBox(
          alignment: Alignment.topCenter,
          fit: BoxFit.scaleDown,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: max(widget.graphWidth, effectiveMaxWidth),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  color: theme.colorScheme.secondaryContainer,
                  elevation: 1,
                  textStyle: theme.textTheme.titleMedium,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    constraints: BoxConstraints(
                      minWidth: widget.graphWidth,
                      minHeight: 31,
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          '${widget.station.type == StationType.tide ? 'Tide Height' : 'Currents'}: '
                          '${widget.station.shortTitle}'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
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
                TimeDisplay(
                  t: DateTime(timeWindow.t, widget.client.timeZone),
                  contentWidth: widget.graphWidth,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TimeControls(
                    timeZone: widget.client.timeZone,
                    timeWindow: timeWindow,
                    onWindowChanged: (timeWindow) {
                      setState(() => this.timeWindow = timeWindow);
                      widget.onTimeChanged?.call(timeWindow.t);
                    },
                    onModal: widget.onModal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

const dayLabels = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

const monthLabels = [
  '',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

class TideGraph extends StatefulWidget {
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
  int get imageWidth => width.round();
  int get imageHeight => height.round() + 81;
  final OverlaySwatch overlaySwatch;
  final void Function(Instant t)? onTimeChanged;

  @override
  State<StatefulWidget> createState() => TideGraphState();

  Stream<Uint8List> getTideGraph() => client.getTideGraph(
        station,
        timeWindow.days,
        imageWidth,
        imageHeight,
        timeWindow.t0,
      );
}

class RectangularSliderThumbShape extends SliderComponentShape {
  RectangularSliderThumbShape({
    this.width = 2,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
  });
  final double width;

  /// The resting elevation adds shadow to the unpressed thumb.
  ///
  /// The default is 1.
  ///
  /// Use 0 for no shadow. The higher the value, the larger the shadow. For
  /// example, a value of 12 will create a very large shadow.
  ///
  final double elevation;

  /// The pressed elevation adds shadow to the pressed thumb.
  ///
  /// The default is 6.
  ///
  /// Use 0 for no shadow. The higher the value, the larger the shadow. For
  /// example, a value of 12 will create a very large shadow.
  final double pressedElevation;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromWidth(width);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final colorValue = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    ).evaluate(enableAnimation)!;

    final elevationValue = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    ).evaluate(activationAnimation);

    final rect = Rect.fromCenter(
      center: center,
      width: width,
      height: parentBox.size.height,
    );

    final path = Path()..addRect(rect);

    if (kDebugMode && debugDisableShadows) {
      if (elevation > 0.0) {
        canvas.drawPath(
          path,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = elevation * 2.0,
        );
      }
    } else {
      canvas.drawShadow(path, Colors.black, elevationValue, true);
    }

    canvas.drawRect(rect, Paint()..color = colorValue);
  }
}

class TideGraphState extends State<TideGraph> {
  static final log = Logger('TideGraphState');

  late Stream<Uint8List> graphImages;

  @override
  void initState() {
    super.initState();
    getTideGraph();
  }

  void getTideGraph() {
    graphImages = widget.getTideGraph().handleError(
          (e, StackTrace s) => log.warning('Failed to fetch tide graph.', e, s),
        );
  }

  @override
  void didUpdateWidget(covariant TideGraph oldWidget) {
    super.didUpdateWidget(oldWidget);

    List<Object?> graphDependencies(TideGraph widget) => [
          widget.client,
          widget.station,
          widget.timeWindow.t0,
          widget.timeWindow.days,
          widget.imageWidth,
          widget.imageHeight,
        ];

    if (!graphDependencies(widget).equals(graphDependencies(oldWidget))) {
      getTideGraph();
    }
  }

  @override
  Widget build(BuildContext context) {
    int gridDivisions = widget.timeWindow.days == 7 ? 14 : 24;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DefaultTextStyle(
        style: TextStyle(color: widget.overlaySwatch.text),
        child: Stack(
          children: [
            Positioned(
              top: -37,
              child: StreamBuilder(
                stream: graphImages,
                builder: (context, snapshot) => snapshot.hasData
                    ? Image.memory(
                        snapshot.requireData,
                        width: widget.imageWidth.toDouble(),
                        height: widget.imageHeight.toDouble(),
                        gaplessPlayback: true,
                      )
                    : const Text('...'),
              ),
            ),
            SliderTheme(
              data: SliderThemeData(
                mouseCursor: MaterialStateProperty.resolveWith(
                  (states) => states.contains(MaterialState.dragged)
                      ? SystemMouseCursors.grabbing
                      : SystemMouseCursors.grab,
                ),
                overlayShape: SliderComponentShape.noOverlay,
                thumbColor: Theme.of(context).colorScheme.tertiary,
                thumbShape: RectangularSliderThumbShape(),
                trackHeight: 0,
              ),
              child: Slider(
                value: widget.timeWindow.t.millisecondsSinceEpoch.toDouble(),
                min: widget.timeWindow.t0.millisecondsSinceEpoch.toDouble(),
                max: widget.timeWindow.tf.millisecondsSinceEpoch.toDouble(),
                onChanged: (double value) => widget.onTimeChanged?.call(
                  Instant.fromMillisecondsSinceEpoch(
                    // Limit this to an exclusive upper bound for more intuitive
                    // behavior. There's no functional problem if we let the
                    // user select the inclusive found, but the date display can
                    // be confusing to the user since it then shows the next
                    // day.
                    min(
                      value.toInt(),
                      widget.timeWindow.tf.millisecondsSinceEpoch - 1,
                    ),
                  ),
                ),
              ),
            ),
            for (int t = 1; t < gridDivisions; ++t)
              Positioned(
                left: t * widget.width / gridDivisions,
                top: 0,
                bottom: 0,
                child: _HourGrid(
                  widget.timeWindow.lerp(t / gridDivisions),
                  swatch: widget.overlaySwatch.grid,
                ),
              ),
            for (int d = 0; d < widget.timeWindow.days; ++d)
              Positioned(
                left: d * widget.width / widget.timeWindow.days,
                width: widget.width / widget.timeWindow.days,
                bottom: 0,
                child: Text(
                  dayLabels[widget.timeWindow
                      .lerp((d + .5) / widget.timeWindow.days)
                      .weekday],
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

  final Time t;
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

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({super.key, required this.t, this.contentWidth});
  final DateTime t;
  final double? contentWidth;

  String get dateString =>
      '${dayLabels[t.weekday]} ${monthLabels[t.month]} ${t.day}, ${t.year}';

  String get timeString => '${t.hour12}:${t.minute.toString().padLeft(2, '0')} '
      '${t.hour < 12 ? 'AM' : 'PM'} ${t.timeZoneOffset.abbreviation}';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.secondaryContainer,
      elevation: .5,
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.tertiary,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(4),
          width: contentWidth,
          child: Row(
            children: [
              Expanded(child: Text(dateString)),
              Expanded(child: Text(timeString, textAlign: TextAlign.right)),
              const SizedBox(
                width: 195,
                child: Text(
                  '(move the slider to change)',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeControls extends StatelessWidget {
  TimeControls({
    super.key,
    required this.timeZone,
    required this.timeWindow,
    this.onWindowChanged,
    this.onModal,
  });

  final TimeZone timeZone;
  final GraphTimeWindow timeWindow;
  final void Function(GraphTimeWindow window)? onWindowChanged;
  final void Function(bool modal)? onModal;

  void Function()? _changeTime(int days) => Optional(onWindowChanged)
      .map((f) => () => f(timeWindow + Period(days: days)));

  late final void Function(int days)? _changeDays =
      Optional(onWindowChanged).map(
    (f) => (days) => f(
          timeWindow.copyWith(
            days: days,
            correctionPolicy: TimeWindowCorrectionPolicy.preserveDays,
          ),
        ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        dividerTheme: const DividerThemeData(
          color: Color(0x40000000),
          indent: 8,
          endIndent: 8,
          space: 8,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(minimumSize: Size.zero),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            IconButton(
              onPressed: _changeTime(-1),
              tooltip: 'Previous day',
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
            const Text('Day'),
            IconButton(
              onPressed: _changeTime(1),
              tooltip: 'Next day',
              icon: const Icon(Icons.keyboard_arrow_right),
            ),
            const VerticalDivider(),
            IconButton(
              onPressed: _changeTime(-7),
              tooltip: 'Previous week',
              icon: const Icon(Icons.keyboard_double_arrow_left),
            ),
            const Text('Week'),
            IconButton(
              onPressed: _changeTime(7),
              tooltip: 'Next week',
              icon: const Icon(Icons.keyboard_double_arrow_right),
            ),
            const VerticalDivider(),
            TextButton(
              onPressed: Optional(onWindowChanged).map(
                (f) => () => f(
                      GraphTimeWindow.leftAligned(
                        DateTime.now(timeZone),
                        1,
                        true,
                      ),
                    ),
              ),
              child: const Text('Today'),
            ),
            const VerticalDivider(),
            TextButton(
              onPressed: Optional(onWindowChanged).map(
                (f) => () => f(
                      GraphTimeWindow.leftAligned(
                        DateTime.now(timeZone)
                                // Even if it's Sunday, go to next Saturday.
                                .nextWeekday(core.DateTime.saturday) &
                            DateTime(timeWindow.t, timeZone),
                        2,
                        true,
                      ),
                    ),
              ),
              child: const Text('Weekend'),
            ),
            const VerticalDivider(),
            IconButton(
              onPressed: Optional(onWindowChanged).map(
                (f) => () async {
                  final today = DateTime(timeWindow.t, timeZone).date;

                  onModal?.call(true);
                  final core.DateTime? date;
                  try {
                    date = await showDatePicker(
                      context: context,
                      initialDate: today.toCoreFields(),
                      firstDate: Date(today.year - 8, 1, 1).toCoreFields(),
                      lastDate: Date(today.year + 10, 1, 0).toCoreFields(),
                    );
                  } finally {
                    onModal?.call(false);
                  }

                  if (date != null) {
                    f(
                      timeWindow.copyWith(
                        t: DateTime(timeWindow.t, timeZone)
                            .withDate(Date.fromCore(date)),
                        correctionPolicy:
                            TimeWindowCorrectionPolicy.preserveDays,
                      ),
                    );
                  }
                },
              ),
              tooltip: 'Calendar',
              icon: const Icon(Icons.calendar_month),
            ),
            const VerticalDivider(),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 12),
              child: DaysMenuButton(
                buttonColor: const Color(0xff90a0ff),
                menuColor: const Color(0xfff8f8ff),
                menuSelectionColor: const Color(0xff6080ff),
                menuTextColor: const Color(0xff404040),
                daysSelection: timeWindow.days,
                daysChoices: const [1, 2, 4, 7],
                onSelected: _changeDays,
                onModal: onModal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DaysMenuButton extends StatelessWidget {
  static final ShapeBorder shape =
      // Create a capsule shape. A "large" radius does it, but if it evaluates
      // as infinite, it becomes a rectangle again.
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(1e16));

  const DaysMenuButton({
    super.key,
    this.buttonColor,
    this.menuColor,
    this.menuSelectionColor,
    this.menuTextColor,
    required this.daysSelection,
    required this.daysChoices,
    this.onSelected,
    this.onModal,
  });
  final Color? buttonColor, menuColor, menuSelectionColor, menuTextColor;
  final int daysSelection;
  final List<int> daysChoices;
  final void Function(int days)? onSelected;
  final void Function(bool)? onModal;

  @override
  Widget build(BuildContext context) => MaterialButton(
        color: buttonColor,
        highlightColor: Colors.transparent,
        elevation: 1.5,
        hoverElevation: 2,
        highlightElevation: 3,
        padding: EdgeInsets.zero,
        minWidth: 64,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: shape,
        onPressed: Optional(onSelected).map(
          (f) => () async {
            onModal?.call(true);
            try {
              Optional(await showMenu(context)).map(f);
            } finally {
              onModal?.call(false);
            }
          },
        ),
        child: Text(
          '$daysSelection ${daysSelection == 1 ? 'day' : 'days'}',
          textAlign: TextAlign.center,
        ),
      );

  Future<int?> showMenu(BuildContext context) {
    final button = context.findRenderObject() as RenderBox;
    final navigator = Navigator.of(context);
    final overlay = navigator.overlay!.context.findRenderObject() as RenderBox;
    return navigator.push(
      DaysMenuRoute(
        color: menuColor,
        selectionColor: menuSelectionColor,
        textColor: menuTextColor,
        daysSelection: daysSelection,
        daysChoices: daysChoices,
        lowerRight: overlay.size.bottomRight(
          -button.localToGlobal(
            button.size.topRight(Offset.zero),
            ancestor: overlay,
          ),
        ),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
      ),
    );
  }
}

class DaysMenuRoute extends PopupRoute<int> {
  DaysMenuRoute({
    this.daysSelection,
    this.color,
    this.selectionColor,
    this.textColor,
    required this.daysChoices,
    required this.lowerRight,
    required this.barrierLabel,
  });

  final Color? color, selectionColor, textColor;
  final int? daysSelection;
  final List<int> daysChoices;
  final Offset lowerRight;

  @override
  final String barrierLabel;
  @override
  Color? get barrierColor => null;
  @override
  bool get barrierDismissible => true;
  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(right: lowerRight.dx, bottom: lowerRight.dy),
        child: Card(
          color: color,
          elevation: 4,
          shape: DaysMenuButton.shape,
          clipBehavior: Clip.hardEdge,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Align(
              alignment: Alignment.centerRight,
              widthFactor: animation.value,
              heightFactor: 1,
              child: child,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final days in daysChoices)
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: textColor,
                      minimumSize: const Size(40, 28),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor:
                          days == daysSelection ? selectionColor : null,
                      elevation: days == daysSelection ? 1 : 0,
                      shape: const RoundedRectangleBorder(),
                    ),
                    onPressed: () => Navigator.of(context).pop(days),
                    child: Text(days.toString()),
                  )
              ],
            ),
          ),
        ),
      );
}
