import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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

class CompassState extends State<Compass> with TickerProviderStateMixin {
  late final ValueStream<Position?> devicePosition;
  late final ValueStream<double> geomagneticCorrection,
      upsampledOrientation,
      upsampledGeomag;

  late final Widget compass;

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
              .asBroadcastStream(),
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
              .asBroadcastStream(),
        );

    compass = Padding(
      padding: const EdgeInsets.all(16),
      child: CompassDisk(
        magnetic: upsampledOrientation,
        geomagneticCorrection: upsampledGeomag,
      ),
    );
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
          appBar: AppBar(),
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
                          Flexible(child: compass),
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
                            child: compass,
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
            ? Column(
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  StreamBuilder(
                    initialData: magneticCorrection.value,
                    stream: magneticCorrection.stream,
                    builder: (context, correction) => Text(
                      formatBearing(
                        magnetic.data! + (correction.data ?? 0),
                        'true',
                      ),
                    ),
                  ),
                  Text(formatBearing(magnetic.data!, 'magnetic')),
                ],
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
          final sizeBasis = min(
            min(constraints.maxWidth, constraints.maxHeight),
            referenceSize,
          );
          final largeText = TextStyle(
            fontSize: sizeBasis * 72 / referenceSize,
            fontWeight: FontWeight.bold,
          );
          final smallText = TextStyle(
            fontSize: sizeBasis * 32 / referenceSize,
            fontWeight: FontWeight.bold,
          );

          return Stack(
            fit: StackFit.expand,
            children: [
              ...['N', 'E', 'S', 'W'].mapIndexed(
                (index, element) => Transform.rotate(
                  angle: index * pi / 2,
                  child: Text(
                    element,
                    textAlign: TextAlign.center,
                    style: largeText,
                  ),
                ),
              ),
              ...['NE', 'SE', 'SW', 'NW'].mapIndexed(
                (index, element) => Transform.rotate(
                  angle: (index + .5) * pi / 2,
                  child: Text(
                    element,
                    textAlign: TextAlign.center,
                    style: smallText,
                  ),
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
