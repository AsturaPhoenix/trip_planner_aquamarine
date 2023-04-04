import 'dart:math';

import 'package:flutter/material.dart';

class InfoWindow extends StatelessWidget {
  const InfoWindow({
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.nip = const Size(25, 12),
    this.fillColor = Colors.white,
    this.strokeColor = Colors.black,
    this.shadowColor,
    this.elevation,
    this.child,
  });

  final BorderRadius borderRadius;
  final Size nip;
  final Color fillColor, strokeColor;
  final Color? shadowColor;
  final double? elevation;
  final Widget? child;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: CalloutPainter(
          borderRadius: borderRadius,
          nip: nip,
          fillColor: fillColor,
          strokeColor: strokeColor,
          shadowColor:
              shadowColor ?? CardTheme.of(context).shadowColor ?? Colors.black,
          elevation: elevation ?? CardTheme.of(context).elevation ?? 1.0,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: nip.height),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              max(borderRadius.bottomLeft.x, borderRadius.topLeft.x),
              max(borderRadius.topLeft.y, borderRadius.topRight.y),
              max(borderRadius.topRight.x, borderRadius.bottomRight.x),
              max(borderRadius.bottomRight.y, borderRadius.bottomLeft.y),
            ),
            child: child,
          ),
        ),
      );
}

class CalloutPainter extends CustomPainter {
  static final _paint = Paint();

  CalloutPainter({
    required this.borderRadius,
    required this.nip,
    required this.fillColor,
    required this.strokeColor,
    required this.shadowColor,
    required this.elevation,
  });
  final BorderRadius borderRadius;
  final Size nip;
  final Color fillColor, strokeColor, shadowColor;
  final double elevation;

  Path? _path;

  @override
  void paint(Canvas canvas, Size size) {
    _path = Path.combine(
      PathOperation.union,
      Path()
        ..addRRect(
          borderRadius.toRRect(
            Offset.zero & Size(size.width, size.height - nip.height),
          ),
        ),
      Path()
        ..addPolygon(
          [
            size.center(Offset(-nip.width / 2, 0)),
            size.bottomCenter(Offset.zero),
            size.center(Offset(nip.width / 2, 0)),
          ],
          true,
        ),
    );

    canvas
      ..drawShadow(_path!, shadowColor, elevation, false)
      ..drawPath(
        _path!,
        _paint
          ..style = PaintingStyle.fill
          ..color = fillColor,
      )
      ..drawPath(
        _path!,
        _paint
          ..style = PaintingStyle.stroke
          ..color = strokeColor,
      );
  }

  // TODO(AsturaPhoenix): SingleChildRenderObjectWidget
  // flutter/flutter#28206
  @override
  bool? hitTest(Offset position) => _path?.contains(position) ?? false;

  @override
  bool shouldRepaint(covariant CalloutPainter oldDelegate) =>
      borderRadius != oldDelegate.borderRadius ||
      nip != oldDelegate.nip ||
      fillColor != oldDelegate.fillColor ||
      strokeColor != oldDelegate.strokeColor ||
      shadowColor != oldDelegate.shadowColor ||
      elevation != oldDelegate.elevation;
}
