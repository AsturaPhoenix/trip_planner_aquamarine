import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../platform/orientation.dart' as orientation;
import '../util/upsample_stream.dart';
import 'map.dart';

class Compass extends StatefulWidget {
  const Compass({super.key});

  @override
  State<Compass> createState() => CompassState();
}

class CompassState extends State<Compass> with TickerProviderStateMixin {
  late final Stream<Position> positionStream;
  late final Stream<double> orientationStream, geomagneticCorrectionStream;

  @override
  void initState() {
    super.initState();

    positionStream = () async* {
      await Permission.locationWhenInUse.request().isGranted;
      yield* Geolocator.getPositionStream();
    }()
        .asBroadcastStream();

    double polar(double radians) => (radians + pi) % (2 * pi) - pi;

    orientation.updateInterval = const Duration(microseconds: 100000 ~/ 6);
    orientationStream = orientation.bearing
        .map((bearing) => orientation.radians(bearing))
        .upsample(
          tickerProvider: this,
          initialState: 0,
          applyDelta: (orientation, delta) => polar(orientation + delta),
          calculateDelta: (after, before) => polar(after - before),
          lerp: (delta, t) => delta * t,
        );
    geomagneticCorrectionStream = positionStream
        .map(orientation.CachingGeoMag().getFromPosition)
        .whereNotNull()
        .map((r) => orientation.radians(r.dec))
        .upsample(
          tickerProvider: this,
          initialState: 0,
          applyDelta: (correction, delta) => polar(correction + delta),
          calculateDelta: (after, before) => polar(after - before),
          lerp: (delta, t) => delta * t,
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
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder(
                  stream: positionStream,
                  builder: (context, positionSnapshot) =>
                      positionSnapshot.hasData
                          ? Text(
                              formatPosition(positionSnapshot.data!),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const LinearProgressIndicator(),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: CompassDisk(
                      magnetic: orientationStream,
                      geomagneticCorrection: geomagneticCorrectionStream,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class CompassDisk extends StatelessWidget {
  const CompassDisk({
    super.key,
    required this.magnetic,
    required this.geomagneticCorrection,
  });
  final Stream<double> magnetic, geomagneticCorrection;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: StreamBuilder(
          stream: magnetic,
          builder: (context, magnetic) {
            return Transform.rotate(
              angle: -(magnetic.data ?? 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  StreamBuilder(
                    stream: geomagneticCorrection,
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
