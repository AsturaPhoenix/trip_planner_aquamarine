import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' hide Path;

class PolygonStyle extends Equatable {
  const PolygonStyle({
    required this.fillColor,
    required this.strokeColor,
    required this.strokeWidth,
  });

  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;

  @override
  get props => [fillColor, strokeColor, strokeWidth];
}

class Polygon extends StatelessWidget {
  const Polygon({
    super.key,
    required this.vertices,
    required this.style,
  });

  final List<LatLng> vertices;
  final PolygonStyle style;

  @override
  Widget build(BuildContext context) {
    final mapState = FlutterMapState.maybeOf(context)!;

    return CustomPaint(
      painter: _PolygonPainter(
        [for (final latlng in vertices) mapState.getOffsetFromOrigin(latlng)],
        style,
      ),
      size: Size.infinite,
    );
  }
}

class _PolygonPainter extends CustomPainter {
  static final _paint = Paint();

  _PolygonPainter(this.vertices, this.style);
  final List<Offset> vertices;
  final PolygonStyle style;

  late final _path = Path()..addPolygon(vertices, true);

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawPath(
        _path,
        _paint
          ..style = PaintingStyle.fill
          ..color = style.fillColor,
      )
      ..drawPath(
        _path,
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = style.strokeWidth
          ..color = style.strokeColor,
      );
  }

  @override
  bool? hitTest(Offset position) => _path.contains(position);

  @override
  bool shouldRepaint(covariant _PolygonPainter oldDelegate) =>
      // shallow equality
      vertices != oldDelegate.vertices || style != oldDelegate.style;
}
