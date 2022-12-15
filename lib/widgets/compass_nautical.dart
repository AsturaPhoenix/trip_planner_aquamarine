import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../platform/orientation.dart' as orientation;
import '../util/value_stream.dart';
import 'compass.dart';

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
                                child: _InnerRing(
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

class _InnerRing extends StatelessWidget {
  const _InnerRing({this.compact = false});
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
