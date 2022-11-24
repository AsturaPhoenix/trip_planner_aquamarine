import 'dart:developer' as debug;
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:http/http.dart';
import 'package:joda/time.dart';
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:timezone/data/latest_10y.dart';

import 'package:trip_planner_aquamarine/main.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';
import 'package:trip_planner_aquamarine/persistence/cache_box.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';

@GenerateNiceMocks([MockSpec<TripPlannerHttpClient>()])
import 'widget_test.mocks.dart';

/// https://github.com/flutter/flutter/issues/43609
/// These must be opened before the widget test starts, or else use
/// [WidgetTester.runAsync]. [Box] is heavier than ideal to fake out.
class TestHive {
  static Future<TestHive> open() async => TestHive(
        stationCache: await Hive.openBox('TestStationCache'),
        tideGraphCache: await BlobCache.open('TestTideGraphCache'),
        tileCache: await BlobCache.open('TestTileCache'),
      );

  TestHive({
    required this.stationCache,
    required this.tideGraphCache,
    required this.tileCache,
  });

  final Box<Station> stationCache;
  final BlobCache tideGraphCache;
  final BlobCache tileCache;
}

void main() {
  initializeTimeZones();

  late TestHive caches;
  late MockTripPlannerHttpClient httpClient;

  setUp(() async {
    await setUpTestHive();
    caches = await TestHive.open();
    httpClient = MockTripPlannerHttpClient();
  });

  tearDown(tearDownTestHive);

  testWidgets('Smoke test', (WidgetTester tester) async {
    when(httpClient.getDatapoints())
        .thenAnswer((_) => Future.error(ClientException('Not implemented')));
    when(httpClient.getTideGraph(any, any, any, any, any))
        .thenAnswer((_) => Future.error(ClientException('Not implemented')));

    final client = TripPlannerClient(
      caches.stationCache,
      caches.tideGraphCache,
      () => Future.value(httpClient),
      TimeZone.forId('America/Los_Angeles'),
    );

    await tester.pumpWidget(
      TripPlanner(
        client: client,
        tileCache: caches.tileCache,
      ),
    );
    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
