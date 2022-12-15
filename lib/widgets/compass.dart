import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart' hide ValueStream;

import '../platform/location.dart' as location;
import '../platform/orientation.dart' as orientation;
import '../util/upsample_stream.dart';
import '../util/value_stream.dart';
import 'blinking_icon.dart';
import 'map.dart';

class Compass extends StatefulWidget {
  const Compass({super.key});

  @override
  State<Compass> createState() => CompassState();
}

typedef CompassBuilder = Widget Function({
  required ValueStream<double> magnetic,
  required ValueStream<double> geomagneticCorrection,
});

class CompassState extends State<Compass> with TickerProviderStateMixin {
  late final ValueStream<Position?> devicePosition;
  late final ValueStream<double> geomagneticCorrection,
      upsampledOrientation,
      upsampledGeomag;
  StreamSubscription? orientationBroadcastSubscription,
      geomagBroadcastSubscription;

  CompassBuilder compass = CompassDisk.new;

  @override
  void initState() {
    super.initState();

    location.requestPermission();
    devicePosition = location.passivePosition;

    double polar(double radians) => (radians + pi) % (2 * pi) - pi;

    orientation.updateInterval = const Duration(microseconds: 100000 ~/ 6);
    upsampledOrientation = orientation.bearing
        .map((bearing) => orientation.radians(bearing))
        .transform(
          // We unsubscribe from the orientation sensors while they're not
          // needed, which seems to cause the platform channel to buffer some
          // events. We need to skip these buffered events to animate properly
          // between the last cached state and the first updated state. If we
          // don't skip the buffered events, the upsampler treats all but the
          // first event as an immediate series of movements that causes the
          // animation to skip.
          //
          // Unfortunately there doesn't seem to be a great way to reliably skip
          // all buffered events, so at some point we might want to explore
          // limiting the deltas instead.
          (s, v) => s
              .skipBuffered()
              .upsample(
                tickerProvider: this,
                initialState: polar(v ?? 0),
                applyDelta: (orientation, delta) => polar(orientation + delta),
                calculateDelta: (after, before) => polar(after - before),
                lerp: (delta, t) => delta * t,
              )
              .asBroadcastStream(
                onListen: (subscription) =>
                    orientationBroadcastSubscription = subscription,
              ),
        );
    geomagneticCorrection = devicePosition
        .map(orientation.CachingGeoMag().getFromPosition)
        .transform((s, _) => s.whereNotNull())
        .map((r) => r.dec);
    upsampledGeomag = geomagneticCorrection
        .map((dec) => orientation.radians(dec))
        .transform(
          (s, v) => s
              .skipBuffered()
              .upsample(
                tickerProvider: this,
                initialState: polar(v ?? 0),
                applyDelta: (correction, delta) => polar(correction + delta),
                calculateDelta: (after, before) => polar(after - before),
                lerp: (delta, t) => delta * t,
              )
              .asBroadcastStream(
                onListen: (subscription) =>
                    geomagBroadcastSubscription = subscription,
              ),
        );
  }

  @override
  void dispose() {
    orientationBroadcastSubscription?.cancel();
    geomagBroadcastSubscription?.cancel();
    // This needs to happen after the subscription cancellations or the ticker
    // provider mixin will complain about leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black45,
            brightness: Brightness.dark,
            primary: Colors.black45,
          ),
          scaffoldBackgroundColor: Colors.black,
        ),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              PopupMenuButton<CompassBuilder>(
                icon: const Icon(Icons.settings),
                tooltip: 'Compass style',
                initialValue: compass,
                onSelected: (value) => setState(() => compass = value),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: CompassDisk.new,
                    child: Text('Classic'),
                  ),
                  const PopupMenuItem(
                    value: NauticalCompass.new,
                    child: Text('Nautical'),
                  )
                ],
              )
            ],
          ),
          body: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            child: OrientationBuilder(
              builder: (context, screenOrientation) => screenOrientation ==
                      Orientation.portrait
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const LocationInfo(),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: compass(
                                magnetic: upsampledOrientation,
                                geomagneticCorrection: upsampledGeomag,
                              ),
                            ),
                          ),
                          BearingInfo(
                            magnetic: orientation.bearing,
                            magneticCorrection: geomagneticCorrection,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          )
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: compass(
                              magnetic: upsampledOrientation,
                              geomagneticCorrection: upsampledGeomag,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LocationInfo(),
                              BearingInfo(
                                magnetic: orientation.bearing,
                                magneticCorrection: geomagneticCorrection,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      );
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: location.isEnabled.value,
        stream: location.isEnabled.stream,
        builder: (context, isEnabled) => StreamBuilder(
          initialData: location.passivePosition.value,
          stream: location.passivePosition.stream,
          builder: (context, position) {
            final gpsState = [
                  position.hasData,
                  position.hasError,
                  isEnabled.data,
                ].indexOf(true) %
                4;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const [
                  Icon(Icons.my_location),
                  Icon(Icons.location_disabled),
                  BlinkingIcon(
                    icons: [Icons.my_location, Icons.location_searching],
                  ),
                  Icon(Icons.location_disabled)
                ][gpsState],
                const SizedBox(width: 8),
                AnimatedSize(
                  alignment: Alignment.centerLeft,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  child: [
                    () => Text(formatPosition(position.data!)),
                    () => const Text('could not acquire gps'),
                    () => const Text('acquiring GPS...'),
                    () => const Text('GPS disabled'),
                  ][gpsState](),
                ),
              ],
            );
          },
        ),
      );
}

class BearingInfo extends StatelessWidget {
  const BearingInfo({
    super.key,
    required this.magnetic,
    required this.magneticCorrection,
    required this.crossAxisAlignment,
  });
  final ValueStream<double> magnetic, magneticCorrection;
  final CrossAxisAlignment crossAxisAlignment;

  static String formatBearing(double degrees, String suffix) =>
      '${degrees.round() % 360}° $suffix';

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: magnetic.value,
        stream: magnetic.stream,
        builder: (context, magnetic) => magnetic.hasData
            ? StreamBuilder(
                initialData: magneticCorrection.value,
                stream: magneticCorrection.stream,
                builder: (context, correction) => Column(
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    if (correction.hasData)
                      Text(
                        formatBearing(
                          magnetic.data! + correction.data!,
                          'true',
                        ),
                      ),
                    Text(formatBearing(magnetic.data!, 'magnetic')),
                  ],
                ),
              )
            : magnetic.hasError
                ? const Text('Could not acquire compass.')
                : const CircularProgressIndicator(),
      );
}

class CompassDisk extends StatelessWidget {
  const CompassDisk({
    super.key,
    required this.magnetic,
    required this.geomagneticCorrection,
  });
  final ValueStream<double> magnetic, geomagneticCorrection;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: StreamBuilder(
          initialData: magnetic.value,
          stream: magnetic.stream,
          builder: (context, magnetic) {
            return Transform.rotate(
              angle: -(magnetic.data ?? 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  StreamBuilder(
                    initialData: geomagneticCorrection.value,
                    stream: geomagneticCorrection.stream,
                    builder: (context, geomagneticCorrection) {
                      return Transform.rotate(
                        angle: -(geomagneticCorrection.data ?? 0),
                        child: const CompassRose(elevation: 1),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: AspectRatio(
                      aspectRatio: 7 / 72,
                      child: CustomPaint(painter: CompassArrow(elevation: 4)),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
}

class CompassRose extends StatelessWidget {
  const CompassRose({super.key, this.elevation = 0});
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const CircleBorder(),
      elevation: elevation,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const referenceSize = 0x180;
          final fontScale = min(
            min(constraints.maxWidth, constraints.maxHeight) / referenceSize,
            1,
          );
          final textStyles = [
            for (final fontSize in [72.0, 32.0])
              TextStyle(
                fontSize: fontSize * fontScale,
                fontWeight: FontWeight.bold,
              )
          ];

          return RingStack(
            children: [
              ...['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'].mapIndexed(
                (index, label) => Text(
                  label,
                  textAlign: TextAlign.center,
                  style: textStyles[index % 2],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class CompassArrow extends CustomPainter {
  const CompassArrow({this.elevation = 0});
  final double elevation;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outline = [
      Offset(0, center.dy),
      Offset(center.dx, 0),
      Offset(size.width, center.dy),
      Offset(center.dx, size.height),
    ];

    canvas.drawShadow(
      Path()..addPolygon(outline, true),
      Colors.black,
      elevation,
      false,
    );

    canvas.drawPath(
      Path()
        ..addPolygon(
          [
            center,
            outline[0],
            outline[1],
          ],
          true,
        ),
      Paint()..color = const Color(0xffc84031),
    );
    canvas.drawPath(
      Path()
        ..addPolygon(
          [
            center,
            outline[1],
            outline[2],
          ],
          true,
        ),
      Paint()..color = const Color(0xffb73327),
    );
    canvas.drawPath(
      Path()
        ..addPolygon(
          [
            center,
            outline[2],
            outline[3],
          ],
          true,
        ),
      Paint()..color = const Color(0xffd1d3d7),
    );
    canvas.drawPath(
      Path()
        ..addPolygon(
          [
            center,
            outline[3],
            outline[0],
          ],
          true,
        ),
      Paint()..color = const Color(0xffbdc0c5),
    );
  }

  @override
  bool shouldRepaint(covariant CompassArrow oldDelegate) =>
      elevation != oldDelegate.elevation;
}

class NauticalCompass extends StatelessWidget {
  static const color = Colors.pinkAccent;
  static const fontSize = 10.0;
  static const textStyle = TextStyle(color: color, fontSize: fontSize);
  static const innerRadius = 48.0;

  static String formatMagneticCorrection(double degrees) {
    final minutes = (degrees.abs() * 60).round();
    return "VAR ${minutes ~/ 60}°${minutes % 60}'${degrees >= 0 ? 'E' : 'W'}";
  }

  const NauticalCompass({
    super.key,
    required this.magnetic,
    required this.geomagneticCorrection,
  });
  final ValueStream<double> magnetic, geomagneticCorrection;

  @override
  Widget build(BuildContext context) => DividerTheme(
        data: const DividerThemeData(color: color, space: 0),
        child: DefaultTextStyle(
          style: textStyle,
          child: AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                const threshold =
                    2 * (innerRadius + 2 * fontSize + 16 + 28 + 40);
                bool compact = constraints.maxWidth < threshold ||
                    constraints.maxHeight < threshold;

                return StreamBuilder(
                  initialData: geomagneticCorrection.value,
                  stream: geomagneticCorrection.stream,
                  builder: (context, geomagneticCorrection) => Stack(
                    alignment: Alignment.center,
                    children: [
                      StreamBuilder(
                        initialData: magnetic.value,
                        stream: magnetic.stream,
                        builder: (context, magnetic) => Transform.rotate(
                          angle: -(magnetic.data ?? 0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Transform.rotate(
                                angle: -(geomagneticCorrection.data ?? 0),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/nautical_star.svg',
                                      height: 16,
                                      color: color,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: _DecimalRing(
                                        labelInterval: compact ? 30 : 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(40 + fontSize),
                                child: _NauticalCompassInnerRing(
                                  compact: compact,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (!compact)
                        const ArcText(
                          radius: innerRadius,
                          text: 'MAGNETIC',
                          textStyle: NauticalCompass.textStyle,
                          startAngleAlignment: StartAngleAlignment.center,
                          placement: Placement.inside,
                        ),
                      if (!compact && geomagneticCorrection.hasData)
                        ArcText(
                          radius: innerRadius,
                          text: formatMagneticCorrection(
                            orientation.degrees(geomagneticCorrection.data!),
                          ),
                          textStyle: NauticalCompass.textStyle,
                          startAngle: pi,
                          startAngleAlignment: StartAngleAlignment.center,
                          direction: Direction.counterClockwise,
                          placement: Placement.inside,
                        ),
                      const Icon(Icons.add, color: color)
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
}

class _DecimalRing extends StatelessWidget {
  static const quarterMark = _TickMark(length: 8);
  const _DecimalRing({
    this.labelInterval = 10,
    this.increment = 1,
    this.northMarker = quarterMark,
  });
  final int labelInterval, increment;
  final Widget northMarker;

  @override
  Widget build(BuildContext context) => RingStack(
        children: [
          for (int degrees = 0; degrees < 360; degrees += increment)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 24 + NauticalCompass.fontSize,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (degrees % 90 == 0)
                      degrees == 0 ? northMarker : quarterMark,
                    if (degrees % labelInterval == 0) Text('$degrees'),
                    degrees % 10 == 0
                        ? const _TickMark(length: 10)
                        : degrees % 5 == 0 && increment < 5
                            ? const _TickMark(length: 7)
                            : const _TickMark(length: 4),
                  ],
                ),
              ),
            )
        ],
      );
}

class _NauticalCompassInnerRing extends StatelessWidget {
  const _NauticalCompassInnerRing({this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          _DecimalRing(
            labelInterval: 30,
            increment: compact ? 5 : 1,
            northMarker: const Icon(
              Icons.arrow_upward,
              size: 8,
              color: NauticalCompass.color,
            ),
          ),
          if (!compact)
            Padding(
              padding: const EdgeInsets.all(28 + NauticalCompass.fontSize),
              child: RingStack(
                children: [
                  for (int tick = 0; tick < 128; ++tick)
                    Align(
                      alignment: Alignment.topCenter,
                      child: tick % 32 == 0
                          ? const _InsideRelativeTickMark(
                              innerRadius: NauticalCompass.innerRadius,
                            )
                          : tick % 4 == 0
                              ? const _TickMark(length: 16)
                              : tick % 2 == 0
                                  ? const _TickMark(length: 8)
                                  : const _TickMark(length: 4),
                    )
                ],
              ),
            ),
        ],
      );
}

class _TickMark extends StatelessWidget {
  const _TickMark({required this.length});
  final double length;

  @override
  Widget build(BuildContext context) =>
      SizedBox(height: length, child: const VerticalDivider());
}

class _InsideRelativeTickMark extends StatelessWidget {
  const _InsideRelativeTickMark({required this.innerRadius});
  final double innerRadius;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
        alignment: Alignment.topCenter,
        heightFactor: .5,
        child: VerticalDivider(endIndent: innerRadius),
      );
}

class RingStack extends StatelessWidget {
  const RingStack({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          ...children.mapIndexed(
            (index, child) => Transform.rotate(
              angle: index / children.length * 2 * pi,
              child: child,
            ),
          )
        ],
      );
}
