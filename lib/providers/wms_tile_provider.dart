import 'dart:async';
import 'dart:collection';
import 'dart:developer' as debug;
import 'dart:math';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'wms_tile_provider.g.dart';

@JsonSerializable()
class WmsParams {
  late String layers;
  String styles = '';
  String version = '1.1.1';
  bool transparent = true;
  String bgcolor = '0xFFFFFF';
  String format = 'image/png';
  bool outline = false;

  Map<String, dynamic> toJson() => _$WmsParamsToJson(this);
}

typedef SparseArray<T> = SplayTreeMap<int, T>;

extension on Point<int> {
  ui.Offset toOffset() => ui.Offset(x.toDouble(), y.toDouble());
  Point<int> operator <<(int z) => Point(x << z, y << z);
  Point<int> operator >>(int z) => Point(x >> z, y >> z);
}

extension on ui.Image {
  ui.Size get size => ui.Size(width.toDouble(), height.toDouble());
}

class _AreaLocator {
  final int zoom;
  final Point<int> coordinate;

  _AreaLocator(this.zoom, this.coordinate);
}

class _TileLocator extends _AreaLocator {
  /// The LOD delta from [zoom]. The effective zoom level of the referenced
  /// tiles is `zoom + lod`.
  final int lod;

  _TileLocator(super.zoom, super.coordinate, this.lod);
  @override
  String toString() => 'zoom: $zoom / coordinate: $coordinate / lod: $lod';

  /// Derives a descendant [_TileLocator] in the quadtree. Descendants have
  /// coordinates in the top left.
  ///
  /// The `>>` symbol is chosen to represent shifting rightwards towards
  /// children in a left-to-right hierarchy representation.
  _TileLocator operator >>(int z) =>
      _TileLocator(zoom + z, coordinate << z, lod - z);

  /// Derives an ancestor of [_TileLocator] in the quadtree.
  ///
  /// The `<<` symbol is chosen to represent shifting leftwards towards
  /// ancestors in a left-to-right hierarchy representation.
  _TileLocator operator <<(int z) =>
      _TileLocator(zoom - z, coordinate >> z, lod + z);

  _TileLocator operator +(Point<int> offset) =>
      _TileLocator(zoom, coordinate + offset, lod);
}

/// Tile cache by zoom level, y, x, and LOD boost.
/// Only the images are cached. Composited and windowed tiles are canvases
/// rendered on the fly.
///
/// Another possible way of keeping this cache is a quadtree, but it would
/// likely make most operations slower and probably use more memory.
class _ImageCache {
  final _cache =
      SparseArray<SparseArray<SparseArray<SparseArray<Future<ui.Image>?>>>>();

  int? get minZoom => _cache.firstKey();

  Future<ui.Image>? operator [](_TileLocator key) =>
      _cache[key.zoom]?[key.coordinate.y]?[key.coordinate.x]?[key.lod];

  void operator []=(_TileLocator key, Future<ui.Image>? image) => _cache
      .putIfAbsent(key.zoom, SplayTreeMap.new)
      .putIfAbsent(key.coordinate.y, SplayTreeMap.new)
      .putIfAbsent(key.coordinate.x, SplayTreeMap.new)[key.lod] = image;

  void dispose() {
    for (final imageFuture in _cache.values
        .expand((y) => y.values)
        .expand((x) => x.values)
        .expand((lod) => lod.values)) {
      imageFuture?.then((image) => image.dispose());
    }
  }
}

typedef _RenderTask = FutureOr<void> Function(ui.Canvas);

// Derived from js-ogc
class WmsTileProvider implements TileProvider {
  /// This is determined by the Maps API, but doesn't seem to be a constant
  /// provided there.
  static const logicalTileSize = 256;

  static const _defaultWmsParams = {
    'request': 'GetMap',
    'service': 'WMS',
    'srs': 'EPSG:3857',
  };

  static const _epsg3857Extent = 20037508.34789244;
  static const _origin = ui.Offset(
    -_epsg3857Extent, // x starts from left
    _epsg3857Extent,
  ); // y starts from top

  static final _imagePaint = ui.Paint();

  /// Convert xyz tile coordinates to mercator bounds.
  static ui.Rect _xyzToBounds(_AreaLocator xyz) {
    final wmsTileSize = _epsg3857Extent * 2 / (1 << xyz.zoom);
    return _origin +
            ui.Offset(
                  xyz.coordinate.x.toDouble(),
                  -xyz.coordinate.y.toDouble(),
                ) *
                wmsTileSize &
        ui.Size(wmsTileSize, -wmsTileSize);
  }

  /// The level of detail above native at which to perform fetches. Higher
  /// values will fetch larger tiles from the server, by powers of 2, and window
  /// them into the expected logical tile size of 256 x 256. The web API allows
  /// for custom logical tile sizes, but mobile does not.
  final int fetchLod;

  /// The tile standard tile size multiplied by the device pixel ratio.
  int preferredTileSize;

  /// The base URL supplying tile data. For simplicity, any query paremeters
  /// also specified in [WmsParams] or [DEFAULT_WMS_PARAMS] are overwritten.
  final Uri url;

  int levelOfDetail;
  int maxOversample;
  final WmsParams params;

  final _imageCache = _ImageCache();

  WmsTileProvider({
    required this.url,
    this.levelOfDetail = 0,
    this.maxOversample = 2,
    this.fetchLod = 0,
    this.preferredTileSize = 256,
    required this.params,
  });

  void dispose() => _imageCache.dispose();

  static const _clientKeepAlive = Duration(minutes: 1);

  http.Client get _client {
    _clientTimer?.cancel();
    _clientTimer = Timer(_clientKeepAlive, () {
      _clientInstance!.close();
      _clientInstance = null;
    });

    return _clientInstance ??= http.Client();
  }

  http.Client? _clientInstance;
  Timer? _clientTimer;

  Uri _getTileUrl(_TileLocator locator) {
    final tileSizeParam = logicalTileSize << locator.lod;
    final bbox = _xyzToBounds(locator);

    return url.replace(
      queryParameters: {
        ..._defaultWmsParams,
        ...url.queryParametersAll,
        ...params.toJson().map((key, value) => MapEntry(key, value.toString())),
        'bbox': '${bbox.left},${bbox.bottom},${bbox.right},${bbox.top}',
        'width': tileSizeParam.toString(),
        'height': tileSizeParam.toString(),
      },
    );
  }

  /// Windows a tile from a larger tile.
  ///
  /// Synchronously determines whether a composite can be made in the near
  /// future. If a composite can be made, returns a function that can be
  /// executed to render the composite.
  _RenderTask? _tileFromLarger(_TileLocator locator) {
    for (int levelsAbove = 1;
        locator.zoom - levelsAbove >= (_imageCache.minZoom ?? locator.zoom);
        ++levelsAbove) {
      final ancestor = locator << levelsAbove;

      final cacheHit = _imageCache[ancestor];
      if (cacheHit != null) {
        return (canvas) async {
          final image = await cacheHit;

          final size = image.size / (1 << levelsAbove).toDouble();
          final offset =
              (locator.coordinate - (ancestor.coordinate << levelsAbove))
                  .toOffset()
                  .scale(size.width, size.height);

          canvas.drawImageRect(
            image,
            offset & size,
            ui.Offset.zero & const ui.Size.square(1),
            _imagePaint,
          );
        };
      }
    }

    return null;
  }

  /// Recursively assembles a tile from smaller tiles at a lower LOD.
  ///
  /// Synchronously determines whether a composite can be made in the near
  /// future. If a composite can be made, returns a function that can be
  /// executed to render the composite. While the function executes, it should
  /// own the canvas transform stack.
  _RenderTask? _tileFromSmaller(_TileLocator locator) {
    if (locator.lod <= 0) return null;

    final childBasis = locator >> 1;
    final taskList = <_RenderTask>[
      (canvas) => canvas
        ..save()
        ..scale(.5)
    ];

    for (int j = 0; j <= 1; ++j) {
      for (int i = 0; i <= 1; ++i) {
        final offset = Point(i, j);
        final childLocator = childBasis + offset;

        taskList.add(
          (canvas) => canvas
            ..save()
            ..translate(offset.x.toDouble(), offset.y.toDouble()),
        );

        final cacheHit = _imageCache[childLocator];
        if (cacheHit != null) {
          taskList.add((canvas) async {
            final image = await cacheHit;
            canvas.drawImageRect(
              image,
              ui.Offset.zero & image.size,
              ui.Offset.zero & const ui.Size.square(1),
              _imagePaint,
            );
          });
        } else {
          final childTasks = _tileFromSmaller(childLocator);
          if (childTasks == null) {
            return null;
          } else {
            taskList.add(childTasks);
          }
        }

        taskList.add((canvas) => canvas.restore());
      }
    }

    taskList.add((canvas) => canvas.restore());
    return (canvas) async {
      for (final task in taskList) {
        await task(canvas);
      }
    };
  }

  Future<ui.Image> _fetchTile(_TileLocator locator) async {
    final url = _getTileUrl(locator);
    debug.log('_fetchTile($locator) => get $url', name: 'WmsTileProvider');

    final buffer = await _client
        .get(url)
        .then((r) => ui.ImmutableBuffer.fromUint8List(r.bodyBytes));

    final ui.ImageDescriptor imageDescriptor;
    try {
      imageDescriptor = await ui.ImageDescriptor.encoded(buffer);
    } finally {
      buffer.dispose();
    }

    try {
      final codec = await imageDescriptor.instantiateCodec();
      try {
        return (await codec.getNextFrame()).image;
      } finally {
        codec.dispose();
      }
    } finally {
      imageDescriptor.dispose();
    }
  }

  Future<ui.Image> _render(_RenderTask task, int lod) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = ui.Canvas(pictureRecorder);

    // Keep the natural resolution afforded by the LOD if we want to display at
    // a higher resolution, but don't waste bytes beyond the preferred size to
    // minimize encoding time.
    //
    // Also go ahead and normalize the tile size to 1.
    final tileSize = min(logicalTileSize << lod, preferredTileSize);
    canvas.scale(tileSize.toDouble());

    await task(canvas);

    final picture = pictureRecorder.endRecording();
    try {
      return picture.toImage(tileSize, tileSize);
    } finally {
      picture.dispose();
    }
  }

  /// Gets a tile image. This may be cached, composited, or fetched.
  ///
  /// The caller is responsible for calling `dispose` on the image.
  Future<ui.Image> _getTileContent(_TileLocator locator) {
    final cached = _imageCache[locator];
    if (cached != null) {
      return cached.then((image) => image.clone());
    }

    final composite = _tileFromLarger(locator) ?? _tileFromSmaller(locator);
    if (composite != null) {
      return _render(composite, locator.lod);
    }

    // We can get away with not testing for existence because (and only because)
    // we're synchronous with the cache checks up to this point.
    final fetchLocator = locator << fetchLod;
    final fetch = _fetchTile(fetchLocator);
    _imageCache[fetchLocator] = fetch;
    fetch.catchError((Object e) {
      _imageCache[fetchLocator] = null;
      throw e;
    });

    if (fetchLod == 0) {
      // Leave the cached handle open, but return a clone so we can close it
      // like the PictureRecorder handles.
      return fetch.then((image) => image.clone());
    } else {
      return _render(_tileFromLarger(locator)!, locator.lod);
    }
  }

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    try {
      final locator = _TileLocator(
        zoom!,
        Point(x, y),
        max(min(levelOfDetail - zoom, maxOversample), 0),
      );
      final image = await _getTileContent(locator);
      try {
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        return Tile(image.width, image.height, data!.buffer.asUint8List());
      } finally {
        image.dispose();
      }
    } catch (e, s) {
      // The Java maps impl likes to eat exceptions, so log them.
      debug.log(
        'getTile($x, $y, $zoom)',
        name: 'WmsTileProvider',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
