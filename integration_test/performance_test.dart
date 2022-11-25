// ignore_for_file: avoid_print

import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';
import 'package:http/http.dart' as http;
import 'package:trip_planner_aquamarine/providers/wms_tile_provider.dart';

class FakeWmsClient extends Fake implements http.Client {
  final random = Random();

  int tilesGenerated = 0;

  Future<ui.Image> generateTile(Uri url) async {
    ++tilesGenerated;

    final width = int.parse(url.queryParameters['width']!);
    final height = int.parse(url.queryParameters['height']!);
    final buffer = await ui.ImmutableBuffer.fromUint8List(
      Uint8List.fromList([
        for (int y = 0; y < height; ++y)
          for (int x = 0; x < width; ++x) ...[
            random.nextInt(0x100),
            random.nextInt(0x100),
            random.nextInt(0x100),
            0xFF
          ]
      ]),
    );
    final imageDescriptor = ui.ImageDescriptor.raw(
      buffer,
      width: width,
      height: height,
      pixelFormat: ui.PixelFormat.rgba8888,
    );

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

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) =>
      generateTile(url)
          .then((image) => image.toByteData(format: ui.ImageByteFormat.png))
          .then(
            (data) =>
                http.Response.bytes(data!.buffer.asUint8List(), HttpStatus.ok),
          );

  @override
  void close() {}
}

class FakeBlobCache extends Fake implements BlobCache {
  final data = <String, Uint8List>{};

  @override
  Uint8List? operator [](String key) => data[key];
  @override
  void operator []=(String key, Uint8List value) => data[key] = value;
  @override
  void close() {}
}

Future<void> watchTiles(int minCount) {
  final completer = Completer<void>();
  final watched = <ImageElement>{}, loading = <ImageElement>{};

  void awaitLoad(ImageElement img) {
    loading.add(img);
    img.decode().whenComplete(() {
      loading.remove(img);

      if (watched.length >= minCount && loading.isEmpty) {
        completer.complete();
      }
    });
  }

  void scan() {
    watched.removeWhere((img) => !img.isConnected!);
    loading.removeWhere((img) => !img.isConnected!);

    for (final ImageElement img
        in document.querySelectorAll('img[src^="blob:"]')) {
      if (watched.add(img)) {
        awaitLoad(img);
      }
    }
  }

  final observer = MutationObserver((_, __) => scan())
    ..observe(
      document,
      childList: true,
      subtree: true,
      attributes: true,
      attributeFilter: const ['src'],
    );

  scan();

  return completer.future.whenComplete(() => observer.disconnect());
}

/// Uses timeouts to probe whether web animations are happening smoothly.
/// (Integration test timelines don't work on web because they need isolate
/// support.)
class WebPerformanceMonitor {
  WebPerformanceMonitor({required this.fps}) : t0 = DateTime.now() {
    timer = Timer.periodic(
      const Duration(seconds: 1) * (1 / fps),
      (_) => ++_frames,
    );
  }
  final DateTime t0;
  final num fps;
  late final Timer timer;
  int _frames = 0;
  // The ratio of frames recorded : frames expected.
  double get frameRatio =>
      _frames * 1000 / (fps * DateTime.now().difference(t0).inMilliseconds);

  void close() => timer.cancel();
}

///  ```
/// chromedriver --port=4444 &
/// flutter drive -d chrome --driver test_driver/integration_test.dart --target integration_test/tile_overlay_performance_test.dart --profile
/// ```
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Tile overlay performance test', (tester) async {
    final mapControllerCompleter = Completer<GoogleMapController>();
    final onCameraIdleController = StreamController<void>.broadcast();

    final wmsClient = FakeWmsClient();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox.fromSize(
              size: const Size.square(0x300),
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.8331, -122.4165),
                  zoom: 12,
                ),
                tileOverlays: {
                  TileOverlay(
                    tileOverlayId: const TileOverlayId('test'),
                    tileProvider: WmsTileProvider(
                      client: wmsClient,
                      cache: FakeBlobCache(),
                      tileType: 'test',
                      url: Uri(path: 'test'),
                      fetchLod: 2,
                      levelOfDetail: 14,
                      params: WmsParams(),
                    ),
                  )
                },
                onCameraIdle: () => onCameraIdleController.add(null),
                onMapCreated: mapControllerCompleter.complete,
              ),
            ),
          ),
        ),
      ),
    );

    // This is needed to kick-off the rendering of the JS Map flutter widget
    await tester.pump();
    final controller = await mapControllerCompleter.future;
    final onCameraIdle = onCameraIdleController.stream;

    await watchTiles(9);
    // Zoom in from 12 with target LOD 14 and max oversample 2 should not
    // require new tiles
    final tilesGenerated = wmsClient.tilesGenerated;

    final perf = WebPerformanceMonitor(fps: 60);
    const iterations = 16;
    for (int i = 0; i < iterations; ++i) {
      controller.animateCamera(CameraUpdate.zoomIn());
      await onCameraIdle.first;
      await watchTiles(9);

      controller.animateCamera(CameraUpdate.zoomOut());
      await onCameraIdle.first;
      await watchTiles(9);
    }

    tester.printToConsole('Frame ratio: ${perf.frameRatio}');
    expect(perf.frameRatio, greaterThan(.12));
    assert(wmsClient.tilesGenerated == tilesGenerated);
  });
}
