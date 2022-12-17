import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'compass.dart';

class ClassicCompass extends StatelessWidget {
  const ClassicCompass({
    super.key,
    required this.compass,
    this.background,
    this.child,
  });
  final CompassState compass;
  final Widget? background, child;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: Card(
          shape: const CircleBorder(),
          elevation: 1,
          child: Stack(
            children: [
              if (background != null) background!,
              StreamBuilder(
                initialData: compass.animatedOrientation.value,
                stream: compass.animatedOrientation.stream,
                builder: (context, magnetic) {
                  return Transform.rotate(
                    angle: -(magnetic.data ?? 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        StreamBuilder(
                          initialData: compass.animatedMagneticCorrection.value,
                          stream: compass.animatedMagneticCorrection.stream,
                          builder: (context, magneticCorrection) {
                            return Transform.rotate(
                              angle: -(magneticCorrection.data ?? 0),
                              child: CompassRose(child: child),
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: AspectRatio(
                            aspectRatio: 7 / 72,
                            child: CustomPaint(
                              painter: CompassArrow(elevation: 4),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}

class CompassRose extends StatelessWidget {
  const CompassRose({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        LayoutBuilder(
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
        if (child != null) child!
      ],
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

    const colors = [
      Color(0xffc84031),
      Color(0xffb73327),
      Color(0xffd1d3d7),
      Color(0xffbdc0c5)
    ];

    for (int i = 0; i < 4; ++i) {
      canvas.drawPath(
        Path()
          ..addPolygon(
            [
              center,
              outline[i],
              outline[(i + 1) % 4],
            ],
            true,
          ),
        Paint()..color = colors[i],
      );
    }
  }

  @override
  bool shouldRepaint(covariant CompassArrow oldDelegate) =>
      elevation != oldDelegate.elevation;
}
