import 'dart:math';

import 'package:aquamarine_server_interface/quadtree.dart';
import 'package:aquamarine_util/async.dart';
import 'package:aquamarine_util/memory_cache.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart' hide LatLngBounds;
import 'package:joda/time.dart';
import 'package:latlng/latlng.dart';
import 'package:vector_math/vector_math_64.dart';

import '../../providers/ofs_client.dart';
import '../../util/latlng.dart';
import '../tide_panel.dart';

extension on Vector2 {
  Offset toOffset() => Offset(x, y);
}

class CurrentLayer extends StatefulWidget {
  const CurrentLayer({
    super.key,
    required this.arrowhead,
    required this.ofsClient,
    required this.timeWindow,
  });

  final ImageProvider arrowhead;
  final OfsClient ofsClient;
  final GraphTimeWindow timeWindow;

  @override
  State<StatefulWidget> createState() => CurrentLayerState();
}

class _CurrentsWindow extends Equatable {
  const _CurrentsWindow(this.bounds, this.zoom);
  final LatLngBounds bounds;
  final double zoom;
  @override
  get props => [bounds, zoom];
}

class _CurrentsKey extends Equatable {
  const _CurrentsKey(this.t, this.window);
  final Instant t;
  final _CurrentsWindow window;
  @override
  get props => [t, window];
}

class CurrentLayerState extends State<CurrentLayer> {
  _CurrentsWindow? _window;
  late Future<Iterable<QuadtreeEntry<Vector2>>> _currents;
  final _cache =
      AsyncCache<_CurrentsKey, Iterable<QuadtreeEntry<Vector2>>>.ephemeral(
    MemoryCache.single(),
  );

  void _updateCurrents() {
    final mapState = FlutterMapState.maybeOf(context)!;
    final bounds = mapState.bounds.toSpherical()!;

    const boundsTolerance = .125, zoomTolerance = .1;
    if (_window == null ||
        !_window!.bounds.containsBounds(bounds) ||
        (_window!.zoom - mapState.zoom).abs() > zoomTolerance) {
      _window = _CurrentsWindow(bounds.pad(boundsTolerance), mapState.zoom);
    }

    // This query can be relatively expensive, so have at most one request in-
    // flight for any given arguments.
    setState(
      () {
        // block body to avoid warning about returning a future
        _currents = _cache.computeIfAbsent(
          _CurrentsKey(widget.timeWindow.t, _window!),
          () => widget.ofsClient.getCurrents(
            timeWindow: widget.timeWindow,
            bounds: _window!.bounds,
            zoom: _window!.zoom,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    widget.ofsClient.addListener(_updateCurrents);
    // _updateCurrents() call is handled by didChangeDependencies()
  }

  @override
  void didUpdateWidget(CurrentLayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.ofsClient != oldWidget.ofsClient) {
      oldWidget.ofsClient.removeListener(_updateCurrents);
      widget.ofsClient.addListener(_updateCurrents);
    }

    _updateCurrents();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateCurrents();
  }

  @override
  void dispose() {
    widget.ofsClient.removeListener(_updateCurrents);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _currents,
        builder: (context, currents) => VectorFieldLayer(
          vectors: currents.data ?? const [],
          arrowhead: widget.arrowhead,
        ),
      );
}

class VectorFieldLayer extends StatefulWidget {
  const VectorFieldLayer({
    super.key,
    required this.vectors,
    required this.arrowhead,
  });
  final Iterable<QuadtreeEntry<Vector2>> vectors;
  final ImageProvider arrowhead;

  @override
  State<VectorFieldLayer> createState() => VectorFieldLayerState();
}

class _Vector {
  const _Vector(this.origin, this.delta);
  final Offset origin, delta;
}

class VectorFieldLayerState extends State<VectorFieldLayer> {
  ImageStream? _arrowheadImageStream;
  ImageInfo? _arrowheadImageInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getArrowheadImage();
  }

  @override
  void didUpdateWidget(VectorFieldLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.arrowhead != oldWidget.arrowhead) {
      _getArrowheadImage();
    }
  }

  void _getArrowheadImage() {
    final newImageStream =
        widget.arrowhead.resolve(createLocalImageConfiguration(context));
    if (_arrowheadImageStream?.key != newImageStream.key) {
      final listener = ImageStreamListener(_updateArrowheadImage);
      _arrowheadImageStream?.removeListener(listener);
      _arrowheadImageStream = newImageStream;
      newImageStream.addListener(listener);
    }
  }

  void _updateArrowheadImage(ImageInfo imageInfo, bool synchronousCall) {
    setState(() {
      _arrowheadImageInfo?.dispose();
      _arrowheadImageInfo = imageInfo;
    });
  }

  // TODO(AsturaPhoenix): We should only have to query the quadtree and convert
  // coordinates when the map moves, which could allow us to animate a lot
  // faster.
  List<_Vector> _indexCurrents(BuildContext context) {
    final mapState = FlutterMapState.maybeOf(context)!;

    // pixels per m/s
    const scale = 24 / 2.5;

    return [
      for (final vector in widget.vectors)
        _Vector(
          mapState.getOffsetFromOrigin(vector.location.toFml()),
          vector.value.toOffset().scale(scale, -scale),
        ),
    ];
  }

  @override
  void dispose() {
    _arrowheadImageStream
        ?.removeListener(ImageStreamListener(_updateArrowheadImage));
    _arrowheadImageInfo?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _arrowheadImageInfo == null
      ? const SizedBox()
      : CustomPaint(
          painter:
              _CurrentsPainter(_indexCurrents(context), _arrowheadImageInfo!),
          size: Size.infinite,
        );
}

class _CurrentsPainter extends CustomPainter {
  static final _paint = Paint()..strokeWidth = 2.0;

  _CurrentsPainter(this.vectors, this.arrowhead);
  final List<_Vector> vectors;
  final ImageInfo arrowhead;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size, doAntiAlias: false);
    for (final vector in vectors) {
      final endpoint = vector.origin + vector.delta;
      canvas
        ..drawLine(vector.origin, endpoint, _paint)
        ..save()
        ..translate(endpoint.dx, endpoint.dy)
        // The arrowhead graphic is pointed upwards, at -y.
        ..rotate(atan2(vector.delta.dx, -vector.delta.dy))
        ..scale(1 / arrowhead.scale)
        ..drawImage(
          arrowhead.image,
          Offset(
            -arrowhead.image.width / 2,
            -arrowhead.image.height / 2,
          ),
          _paint,
        )
        ..restore();
    }
  }

  @override
  bool? hitTest(Offset position) => false;

  @override
  bool shouldRepaint(covariant _CurrentsPainter oldDelegate) =>
      // Don't bother with an expensive deep comparison.
      vectors != oldDelegate.vectors || arrowhead != oldDelegate.arrowhead;
}
