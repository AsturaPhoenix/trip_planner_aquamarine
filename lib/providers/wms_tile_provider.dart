import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:aquamarine_util/async.dart';
import 'package:aquamarine_util/memory_cache.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

import '../persistence/blob_cache.dart';

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

extension on Point<int> {
  Offset toOffset() => Offset(x.toDouble(), y.toDouble());
  Point<int> operator <<(int z) => Point(x << z, y << z);
  // On web, >> is limited to int32.
  // https://github.com/dart-lang/sdk/issues/15361
  // This is fine since the max zoom level for maps is 22.
  Point<int> operator >>(int z) =>
      Point((x >> z).toSigned(32), (y >> z).toSigned(32));
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

Future<Image> _decode(Uint8List data) async {
  final buffer = await ImmutableBuffer.fromUint8List(data);
  final ImageDescriptor imageDescriptor;
  try {
    imageDescriptor = await ImageDescriptor.encoded(buffer);
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

// Derived from js-ogc
class WmsTileProvider extends TileProvider {
  static final log = Logger('WmsTileProvider');

  /// This has to remain stable for persistence, and it being an integer lets us
  /// do a few micro-optimizations (bitshifts instead of floating-point
  /// multiplication). Although we could extract this from [TileLayer], let's
  /// keep this constant for now.
  static const logicalTileSize = 256;

  static const _defaultWmsParams = {
    'request': 'GetMap',
    'service': 'WMS',
    'srs': 'EPSG:3857',
  };

  static const _epsg3857Extent = 20037508.34789244;
  static const _origin = Offset(
    -_epsg3857Extent, // x starts from left
    _epsg3857Extent,
  ); // y starts from top

  /// Convert xyz tile coordinates to mercator bounds.
  static Rect _xyzToBounds(AreaLocator xyz) {
    final wmsTileSize = _epsg3857Extent * 2 / (1 << xyz.zoom);
    return _origin + xyz.coordinate.toOffset().scale(1, -1) * wmsTileSize &
        Size(wmsTileSize, -wmsTileSize);
  }

  static final Paint _paint = Paint();

  WmsTileProvider({
    required this.client,
    required this.cache,
    required this.tileType,
    required this.url,
    this.levelOfDetail = 0,
    this.maxOversample = 2,
    this.fetchLod = 0,
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

  WmsParams params;

  @override
  void dispose() {
    cache.close();
    client.close();
    super.dispose();
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

  final _memoryCache = AsyncCache<TileLocator, Image>.persistent(
    MemoryCache(
      capacity: 32,
      onEvict: (image) async => (await image).dispose(),
    ),
  );

  Future<Uint8List> getImageData(TileLocator locator) async =>
      cache[TileKey.forLocator(locator, tileType).toString()] ??=
          await fetchImageData(locator);

  Future<Image> getComponentImage(TileLocator locator) async =>
      (await (_memoryCache.computeIfAbsent(locator, () async {
        final data = await getImageData(locator);
        return _decode(data);
      })))
          .clone();

  /// Windows a tile from a larger tile at a higher LOD.
  Future<void> _tileFromLarger(
    Canvas canvas,
    TileLocator locator,
  ) async {
    final levelsAbove = min(fetchLod - locator.lod, locator.zoom);
    final ancestor = locator << levelsAbove;

    final srcSize = logicalTileSize << locator.lod;
    final offset =
        ((locator.coordinate - (ancestor.coordinate << levelsAbove)) * srcSize)
            .toOffset();
    final image = await getComponentImage(ancestor);
    canvas.drawImageRect(
      image,
      offset & Size.square(srcSize.toDouble()),
      Offset.zero & const Size.square(1),
      _paint,
    );
    image.dispose();
  }

  /// Assembles a tile from smaller tiles at a lower LOD.
  Future<void> _tileFromSmaller(
    Canvas canvas,
    TileLocator locator,
  ) async {
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

        final image = await getComponentImage(descendantLocator);
        canvas.drawImageRect(
          image,
          Offset.zero &
              Size.square(
                (logicalTileSize << descendantLocator.lod).toDouble(),
              ),
          offset.toOffset() & const Size.square(1),
          _paint,
        );
        image.dispose();
      }
    }

    canvas.restore();
  }

  /// Gets a tile image, composited from cached or fetched resources.
  ///
  /// The caller is responsible for calling `dispose` on the image.
  Future<Image> getTileContent(
    TileLocator locator, {
    int preferredTileSize = logicalTileSize,
  }) async {
    // Keep the natural resolution afforded by the LOD if we want to display at
    // a higher resolution, but don't waste bytes beyond the preferred size to
    // minimize encoding time.
    //
    // Also go ahead and normalize the tile size to 1.
    final tileSize = min(logicalTileSize << locator.lod, preferredTileSize);
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
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

  @override
  ImageProvider<Object> getImage(Coords<num> coords, TileLayer options) {
    assert(options.tileSize == logicalTileSize);

    return _ImageProvider(
      this,
      TileLocator(
        coords.z.toInt(),
        Point(coords.x.toInt(), coords.y.toInt()),
        max(min(levelOfDetail - coords.z.toInt(), maxOversample), 0),
      ),
    );
  }
}

class _ImageKey extends Equatable {
  const _ImageKey(this.tileProvider, this.tileLocator, this.devicePixelRatio);
  final WmsTileProvider tileProvider;
  final TileLocator tileLocator;
  final double devicePixelRatio;
  @override
  get props => [tileProvider, tileLocator, devicePixelRatio];
}

class _ImageProvider extends ImageProvider<_ImageKey> {
  _ImageProvider(this.tileProvider, this.tileLocator);
  final WmsTileProvider tileProvider;
  final TileLocator tileLocator;

  @override
  Future<_ImageKey> obtainKey(ImageConfiguration configuration) async =>
      _ImageKey(tileProvider, tileLocator, configuration.devicePixelRatio ?? 1);

  @override
  ImageStreamCompleter loadImage(_ImageKey key, ImageDecoderCallback decode) =>
      OneFrameImageStreamCompleter(
        (() async {
          final image = await tileProvider.getTileContent(
            tileLocator,
            preferredTileSize:
                (WmsTileProvider.logicalTileSize * key.devicePixelRatio)
                    .toInt(),
          );
          assert(image.width == image.height);
          return ImageInfo(
            image: image,
            scale: WmsTileProvider.logicalTileSize / image.height,
          );
        })(),
      );
}
