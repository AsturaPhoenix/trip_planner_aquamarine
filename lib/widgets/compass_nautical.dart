import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../platform/orientation.dart' show Angle;
import 'compass.dart';

class NauticalCompass extends StatelessWidget {
  static const color = Colors.pinkAccent;
  static const fontSize = 10.0;
  static const textStyle = TextStyle(color: color, fontSize: fontSize);
  static const intraRingPadding = 4.0, innerRadius0 = 48.0;
  static const innerRadius = [innerRadius0, 24.0, 12.0];

  static const sizeTiers = [
    _OuterRing.width +
        intraRingPadding +
        _InnerRing.minWidth +
        _InnerRing.mid +
        innerRadius0,
    128.0
  ];

  static String formatMagneticCorrection(Angle correction) {
    final minutes = (correction.degrees.abs() * 60).round();
    return "VAR ${minutes ~/ 60}°${minutes % 60}'"
        '${correction.degrees >= 0 ? 'E' : 'W'}';
  }

  const NauticalCompass({
    super.key,
    required this.compass,
    this.background,
    this.child,
  });
  final CompassState compass;
  final Widget? background, child;

  @override
  Widget build(BuildContext context) => DividerTheme(
        data: const DividerThemeData(color: color, space: 0),
        child: DefaultTextStyle(
          style: textStyle,
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                if (background != null)
                  Padding(
                    padding: const EdgeInsets.all(_OuterRing.iconSize),
                    child: background!,
                  ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final radius =
                        min(constraints.maxWidth, constraints.maxHeight) / 2;

                    int compactness = sizeTiers
                            .indexWhere((threshold) => radius >= threshold) %
                        (sizeTiers.length + 1);

                    return StreamBuilder(
                      // Use the raw magnetic correction for the readout display
                      // since it's in degrees and not animated.
                      initialData: compass.magneticCorrection.value,
                      stream: compass.magneticCorrection.stream,
                      builder: (context, magneticCorrection) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            StreamBuilder(
                              initialData: compass.animatedOrientation.value,
                              stream: compass.animatedOrientation.stream,
                              builder: (context, magnetic) => Transform.rotate(
                                angle: -(magnetic.data?.radians ?? 0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(
                                        _OuterRing.width + intraRingPadding,
                                      ),
                                      child: _InnerRing(
                                        compactness: compactness,
                                      ),
                                    ),
                                    StreamBuilder(
                                      initialData: compass
                                          .animatedMagneticCorrection.value,
                                      stream: compass
                                          .animatedMagneticCorrection.stream,
                                      builder: (context, magneticCorrection) =>
                                          Transform.rotate(
                                        angle: -(magneticCorrection
                                                .data?.radians ??
                                            0),
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            _OuterRing(
                                              compactness: compactness,
                                            ),
                                            if (child != null)
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  _OuterRing.iconSize,
                                                ),
                                                child: DefaultTextStyle(
                                                  style: const TextStyle(),
                                                  child: child!,
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            if (compactness == 0) ...[
                              const ArcText(
                                radius: innerRadius0,
                                text: 'MAGNETIC',
                                textStyle: NauticalCompass.textStyle,
                                startAngleAlignment: StartAngleAlignment.center,
                                placement: Placement.inside,
                              ),
                              if (magneticCorrection.hasData)
                                ArcText(
                                  radius: innerRadius0,
                                  text: formatMagneticCorrection(
                                    magneticCorrection.data!,
                                  ),
                                  textStyle: NauticalCompass.textStyle,
                                  startAngle: pi,
                                  startAngleAlignment:
                                      StartAngleAlignment.center,
                                  direction: Direction.counterClockwise,
                                  placement: Placement.inside,
                                ),
                            ],
                            const Icon(Icons.add, color: color)
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}

class _OuterRing extends StatelessWidget {
  static const iconSize = 16.0, width = iconSize + _DecimalRing.width;

  const _OuterRing({this.compactness = 0});
  final int compactness;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.topCenter,
        children: [
          SvgPicture.asset(
            'assets/nautical_star.svg',
            height: iconSize,
            color: NauticalCompass.color,
          ),
          Padding(
            padding: const EdgeInsets.all(iconSize),
            child: _DecimalRing(
              labelInterval: const [10, 15, 30][min(compactness, 2)],
            ),
          ),
        ],
      );
}

class _InnerRing extends StatelessWidget {
  static const major = 16.0,
      mid = 8.0,
      minor = 4.0,
      space = 4.0,
      minWidth = _DecimalRing.width + space + major;

  const _InnerRing({this.compactness = 0});
  final int compactness;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.topCenter,
        children: [
          const Icon(
            Icons.arrow_upward,
            size: 8,
            color: NauticalCompass.color,
          ),
          _DecimalRing(
            labelInterval: 30,
            increment: compactness == 0 ? 1 : 5,
            quarterMarkOverrides: const [_Tick(dimension: 0, modulus: 4)],
          ),
          Padding(
            padding: const EdgeInsets.all(_DecimalRing.width + space),
            child: CustomPaint(
              size: Size.infinite,
              painter: _RingPainter(
                tickCount: 128,
                tickConfiguration: [
                  _Tick(
                    dimension: NauticalCompass.innerRadius[
                        min(compactness, NauticalCompass.innerRadius.length)],
                    reference: _RadiusReference.center,
                    modulus: 32,
                  ),
                  const _Tick(dimension: -major, modulus: 4),
                  const _Tick(dimension: -mid, modulus: 2),
                  const _Tick(dimension: -minor)
                ],
              ),
            ),
          ),
        ],
      );
}

class _DecimalRing extends StatelessWidget {
  static const quarter = 8.0,
      major = 10.0,
      mid = 7.0,
      minor = 4.0,
      width = quarter + NauticalCompass.fontSize + major;
  static const quarterMark = _Tick(dimension: quarter);

  const _DecimalRing({
    this.labelInterval = 10,
    this.increment = 1,
    this.quarterMarkOverrides = const [],
  });
  final int labelInterval, increment;
  final List<_Tick> quarterMarkOverrides;

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: Size.infinite,
        painter: _RingPainter(
          inset: quarter,
          tickCount: 4,
          tickConfiguration: [...quarterMarkOverrides, quarterMark],
        ),
        child: Padding(
          padding: const EdgeInsets.all(quarter),
          child: Stack(
            children: [
              RingStack(
                children: [
                  for (int degrees = 0; degrees < 360; degrees += labelInterval)
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text('$degrees'),
                    )
                ],
              ),
              CustomPaint(
                size: Size.infinite,
                painter: _RingPainter(
                  inset: NauticalCompass.fontSize + major,
                  tickCount: 360 ~/ increment,
                  tickConfiguration: [
                    _Tick(dimension: major, modulus: 10 ~/ increment),
                    if (increment == 1)
                      _Tick(dimension: mid, modulus: 5 ~/ increment),
                    const _Tick(dimension: minor)
                  ],
                ),
              )
            ],
          ),
        ),
      );
}

enum _RadiusReference { inset, center }

class _Tick extends Equatable {
  const _Tick({
    this.modulus = 1,
    required this.dimension,
    this.reference = _RadiusReference.inset,
  });
  final int modulus;
  final double dimension;
  final _RadiusReference reference;

  @override
  List<Object?> get props => [modulus, dimension, reference];
}

class _RingPainter extends CustomPainter {
  static final _paint = Paint()..color = NauticalCompass.color;

  const _RingPainter({
    this.inset = 0,
    required this.tickCount,
    required this.tickConfiguration,
  });
  final double inset;
  final int tickCount;
  final List<_Tick> tickConfiguration;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    canvas.translate(center.dx, center.dy);

    final radius = min(center.dx, center.dy);
    final insetRadius = radius - inset;

    final insetPoint = Offset(0, -insetRadius);
    final increment = 2 * pi / tickCount;

    for (int i = 0; i < tickCount; ++i) {
      for (final tick in tickConfiguration) {
        if (i % tick.modulus == 0) {
          final double endpoint;
          switch (tick.reference) {
            case _RadiusReference.inset:
              endpoint = insetRadius + tick.dimension;
              break;
            case _RadiusReference.center:
              endpoint = tick.dimension;
              break;
          }

          if (endpoint != insetRadius) {
            canvas.drawLine(insetPoint, Offset(0, -endpoint), _paint);
          }

          break;
        }
      }

      canvas.rotate(increment);
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      inset != oldDelegate.inset ||
      tickCount != oldDelegate.tickCount ||
      !const ListEquality()
          .equals(tickConfiguration, oldDelegate.tickConfiguration);
}
