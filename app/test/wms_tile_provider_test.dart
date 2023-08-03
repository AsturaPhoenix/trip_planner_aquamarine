import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:test_data/empty.png.dart';
import 'package:trip_planner_aquamarine/providers/wms_tile_provider.dart';

import 'util/cache.dart';
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
    testTileProvider
      ..getTileContent(locator)
      ..getTileContent(locator);

    verify(mockHttpClient.get(any));
    verifyNoMoreInteractions(mockHttpClient);
  });

  test('does not deduplicate failed calls to remote', () async {
    when(mockHttpClient.get(any))
        .thenAnswer((_) => Future.error('Mock failure'));

    const locator = TileLocator(0, Point(0, 0), 0);
    try {
      await testTileProvider.getTileContent(locator);
    } on String {
      // expected
    }
    verify(mockHttpClient.get(any));

    try {
      await testTileProvider.getTileContent(locator);
    } on String {
      // expected
    }
    verify(mockHttpClient.get(any));
  });

  // decode can flake under load, so don't cache failed decodes.
  test('does not deduplicate failed decode attempts', () async {
    when(mockHttpClient.get(any)).thenAnswer(
      (_) async => http.Response.bytes(kEmptyPng, HttpStatus.ok),
    );

    testTileProvider.imageDecoder = (_) => Future.error('Mock flake');

    const locator = TileLocator(0, Point(0, 0), 0);
    await expectLater(
        () => testTileProvider.getTileContent(locator), throwsA(isA<String>()));
    verify(mockHttpClient.get(any));

    testTileProvider.imageDecoder = decodeImage;

    await testTileProvider.getTileContent(locator);
    // The http call should still be cached.
    verifyNoMoreInteractions(mockHttpClient);
  });

  // The server can sometimes return empty 200 responses, which we don't want to
  // cache.
  test('does not cache empty data', () async {
    when(mockHttpClient.get(any)).thenAnswer(
      (_) async => http.Response.bytes(const [], HttpStatus.ok),
    );

    const locator = TileLocator(0, Point(0, 0), 0);
    await expectLater(() => testTileProvider.getTileContent(locator),
        throwsA(isA<Exception>()));
    verify(mockHttpClient.get(any));

    when(mockHttpClient.get(any)).thenAnswer(
      (_) async => http.Response.bytes(kEmptyPng, HttpStatus.ok),
    );

    await testTileProvider.getTileContent(locator);
    verify(mockHttpClient.get(any));
  });
}
