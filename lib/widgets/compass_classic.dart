import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../util/value_stream.dart';
import 'compass.dart';

class ClassicCompass extends StatelessWidget {
  const ClassicCompass({
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
