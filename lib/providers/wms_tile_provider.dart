import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';

part 'wms_tile_provider.g.dart';

@JsonSerializable()
class WmsParams {
  String layers = '';
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
  // On web, >> is limited to int32.
  // https://github.com/dart-lang/sdk/issues/15361
  // This is fine since the max zoom level for maps is 22.
  Point<int> operator >>(int z) =>
      Point((x >> z).toSigned(32), (y >> z).toSigned(32));
}

extension on ui.Image {
  ui.Size get size => ui.Size(width.toDouble(), height.toDouble());
}

class AreaLocator extends Equatable {
  const AreaLocator(this.zoom, this.coordinate);

  final int zoom;
  final Point<int> coordinate;

  @override
  get props => [zoom, coordinate];

  /// Derives a descendant [AreaLocator] in the quadtree. Descendants have
  /// coordinates in the top left.
  ///
  /// The `>>` symbol is chosen to represent shifting rightwards towards
  /// children in a left-to-right hierarchy representation.
  AreaLocator operator >>(int z) => AreaLocator(zoom + z, coordinate << z);

  /// Derives an ancestor of [AreaLocator] in the quadtree.
  ///
  /// The `<<` symbol is chosen to represent shifting leftwards towards
  /// ancestors in a left-to-right hierarchy representation.
  AreaLocator operator <<(int z) => AreaLocator(zoom - z, coordinate >> z);

  AreaLocator operator +(Point<int> offset) =>
      AreaLocator(zoom, coordinate + offset);

  TileLocator withLod(int lod) => TileLocator(zoom, coordinate, lod);
}

class TileLocator extends AreaLocator {
  /// The LOD delta from [zoom]. The effective zoom level of the referenced
  /// tiles is `zoom + lod`.
  final int lod;

  @override
  get props => [...super.props, lod];

  const TileLocator(super.zoom, super.coordinate, this.lod);
  @override
  String toString() => 'zoom: $zoom / coordinate: $coordinate / lod: $lod';

  @override
  TileLocator operator >>(int z) => (super >> z).withLod(lod - z);

  @override
  TileLocator operator <<(int z) => (super << z).withLod(lod + z);

  @override
  TileLocator operator +(Point<int> offset) => (super + offset).withLod(lod);
}

class TileKey extends TileLocator {
  const TileKey(this.type, super.zoom, super.coordinate, super.lod);
  TileKey.forLocator(TileLocator locator, String type)
      : this(type, locator.zoom, locator.coordinate, locator.lod);
  final String type;

  @override
  get props => [type, ...super.props];

  @override
  String toString() => '$type@$zoom:(${coordinate.x},${coordinate.y})+$lod';
}

// Derived from js-ogc
class WmsTileProvider implements TileProvider {
  static final log = Logger('WmsTileProvider');

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

  static Future<ui.Image> decodeImage(Uint8List data) async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(data);
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

  /// Convert xyz tile coordinates to mercator bounds.
  static ui.Rect _xyzToBounds(AreaLocator xyz) {
    final wmsTileSize = _epsg3857Extent * 2 / (1 << xyz.zoom);
    return _origin + xyz.coordinate.toOffset().scale(1, -1) * wmsTileSize &
        ui.Size(wmsTileSize, -wmsTileSize);
  }

  WmsTileProvider({
    required this.client,
    required this.cache,
    required this.tileType,
    required this.url,
    this.levelOfDetail = 0,
    this.maxOversample = 2,
    this.fetchLod = 0,
    this.preferredTileSize = 256,
    required this.params,
  });

  http.Client client;
  BlobCache cache;
  String tileType;

  /// The base URL supplying tile data. For simplicity, any query paremeters
  /// also specified in [WmsParams] or [DEFAULT_WMS_PARAMS] are overwritten.
  Uri url;

  int levelOfDetail;
  int maxOversample;

  /// The level of detail above natural at which to fetch and cache. Higher
  /// values will fetch larger tiles from the server, by powers of 2, and window
  /// them into the expected logical tile size of 256 x 256. The web API allows
  /// for custom logical tile sizes, but mobile does not.
  final int fetchLod;

  /// The tile standard tile size multiplied by the device pixel ratio.
  int preferredTileSize;
  WmsParams params;

  void dispose() {
    cache.close();
    client.close();
  }

  Uri _getTileUrl(TileLocator locator) {
    final bbox = _xyzToBounds(locator);
    final tileSizeParam = (logicalTileSize << locator.lod).toString();

    return url.replace(
      queryParameters: {
        ..._defaultWmsParams,
        ...url.queryParametersAll,
        ...params.toJson().map((key, value) => MapEntry(key, value.toString())),
        'bbox': '${bbox.left},${bbox.bottom},${bbox.right},${bbox.top}',
        'width': tileSizeParam,
        'height': tileSizeParam,
      },
    );
  }

  Future<Uint8List> fetchImageData(TileLocator locator) async {
    final url = _getTileUrl(locator);
    log.fine('fetchImage($locator) => get $url');

    final response = await client.get(url);
    if (response.statusCode == HttpStatus.ok) {
      return response.bodyBytes;
    } else {
      throw response;
    }
  }

  final _activeDecodes = <TileLocator, Future<ui.Image>>{};

  Future<Uint8List> getImageData(TileLocator locator) async =>
      cache[TileKey.forLocator(locator, tileType).toString()] ??=
          await fetchImageData(locator);

  Future<ui.Image> getImage(TileLocator locator) => _activeDecodes[locator] ??=
          getImageData(locator).then(decodeImage).whenComplete(() {
        // Caution: This can't be a => because we must discard the return value
        // or else the async becomes circular and never completes.
        _activeDecodes.remove(locator);
      });

  /// Windows a tile from a larger tile at a higher LOD.
  Future<void> _tileFromLarger(ui.Canvas canvas, TileLocator locator) async {
    final levelsAbove = min(fetchLod - locator.lod, locator.zoom);
    final ancestor = locator << levelsAbove;
    final image = await getImage(ancestor);

    final size = image.size / (1 << levelsAbove).toDouble();
    final offset = (locator.coordinate - (ancestor.coordinate << levelsAbove))
        .toOffset()
        .scale(size.width, size.height);

    canvas.drawImageRect(
      image,
      offset & size,
      ui.Offset.zero & const ui.Size.square(1),
      _imagePaint,
    );
  }

  /// Assembles a tile from smaller tiles at a lower LOD.
  Future<void> _tileFromSmaller(ui.Canvas canvas, TileLocator locator) async {
    final levelsBelow = locator.lod - fetchLod;
    final descendantBasis = locator >> levelsBelow;
    final sideLength = 1 << levelsBelow;

    canvas
      ..save()
      ..scale(1 / sideLength);

    for (int j = 0; j < sideLength; ++j) {
      for (int i = 0; i < sideLength; ++i) {
        final offset = Point(i, j);
        final descendantLocator = descendantBasis + offset;

        final image = await getImage(descendantLocator);
        canvas.drawImageRect(
          image,
          ui.Offset.zero & image.size,
          offset.toOffset() & const ui.Size.square(1),
          _imagePaint,
        );
      }
    }

    canvas.restore();
  }

  /// Gets a tile image. This may be cached, composited, or fetched.
  ///
  /// The caller is responsible for calling `dispose` on the image.
  Future<ui.Image> getTileContent(TileLocator locator) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = ui.Canvas(pictureRecorder);

    // Keep the natural resolution afforded by the LOD if we want to display at
    // a higher resolution, but don't waste bytes beyond the preferred size to
    // minimize encoding time.
    //
    // Also go ahead and normalize the tile size to 1.
    final tileSize = min(logicalTileSize << locator.lod, preferredTileSize);
    canvas.scale(tileSize.toDouble());

    if (locator.lod <= fetchLod) {
      await _tileFromLarger(canvas, locator);
    } else {
      await _tileFromSmaller(canvas, locator);
    }

    final picture = pictureRecorder.endRecording();
    try {
      return picture.toImage(tileSize, tileSize);
    } finally {
      picture.dispose();
    }
  }

  final _encoder = img.BmpEncoder();

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    try {
      final locator = TileLocator(
        zoom!,
        Point(x, y),
        max(min(levelOfDetail - zoom, maxOversample), 0),
      );
      final content = await getTileContent(locator);
      try {
        final data = await content.toByteData(
          format: ui.ImageByteFormat.rawStraightRgba,
        );
        final image = img.Image.fromBytes(
          content.width,
          content.height,
          data!.buffer.asUint8List(),
        );
        return Tile(
          image.width,
          image.height,
          Uint8List.fromList(_encoder.encodeImage(image)),
        );
      } finally {
        content.dispose();
      }
    } catch (e, s) {
      // The Java maps impl caller likes to eat exceptions, so log them.
      log.warning('getTile($x, $y, $zoom)', e, s);
      rethrow;
    }
  }
}
