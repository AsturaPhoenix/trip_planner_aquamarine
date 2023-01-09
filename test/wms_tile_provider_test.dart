import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:trip_planner_aquamarine/platform/compositor.dart';
import 'package:trip_planner_aquamarine/providers/wms_tile_provider.dart';

import 'util/test_cache.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import 'wms_tile_provider_test.mocks.dart';

void main() {
  late FakeBlobCache tileCache;
  late MockClient mockHttpClient;
  late WmsTileProvider testTileProvider;

  setUp(() async {
    tileCache = FakeBlobCache();
    mockHttpClient = MockClient();

    testTileProvider = WmsTileProvider(
      client: mockHttpClient,
      cache: tileCache,
      tileType: 'test tile',
      url: Uri.base,
      params: WmsParams(),
    );
  });

  test('deduplicates concurrent calls to remote', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) => Completer<http.Response>().future);

    const locator = TileLocator(0, Point(0, 0), 0);
    testTileProvider.getImage(locator);
    testTileProvider.getImage(locator);

    verify(mockHttpClient.get(any));
    verifyNoMoreInteractions(mockHttpClient);
  });

  test('does not deduplicate failed calls to remote', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) => Future.error('Mock failure'));

    const locator = TileLocator(0, Point(0, 0), 0);
    try {
      await testTileProvider.getImage(locator);
    } on String {
      // expected
    }
    verify(mockHttpClient.get(any));

    try {
      await testTileProvider.getImage(locator);
    } on String {
      // expected
    }
    verify(mockHttpClient.get(any));
  });

  // decode can flake under load, so don't cache failed decodes.
  test('does not deduplicate failed decode attempts', () async {
    when(mockHttpClient.get(any)).thenAnswer(
      (_) async => http.Response.bytes(
        File('test/empty.png').readAsBytesSync(),
        HttpStatus.ok,
      ),
    );

    final actualDecode = CompositorImage.decode;
    CompositorImage.decode = (_) => Future.error('Mock flake');

    const locator = TileLocator(0, Point(0, 0), 0);
    try {
      await testTileProvider.getImage(locator);
    } on String {
      // expected
    }
    verify(mockHttpClient.get(any));

    CompositorImage.decode = actualDecode;

    await testTileProvider.getImage(locator);
    // The http call should still be cached.
    verifyNoMoreInteractions(mockHttpClient);
  });
}
