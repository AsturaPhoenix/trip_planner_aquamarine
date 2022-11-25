import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:http/http.dart' as http;
import 'package:joda/time.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:timezone/data/latest_10y.dart';

import 'package:trip_planner_aquamarine/main.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';

@GenerateNiceMocks([MockSpec<TripPlannerHttpClient>(), MockSpec<http.Client>()])
import 'widget_test.mocks.dart';

/// https://github.com/flutter/flutter/issues/43609
/// These must be opened before the widget test starts, or else use
/// [WidgetTester.runAsync].
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
  late MockTripPlannerHttpClient tripPlannerHttpClient;
  late MockClient wmsClient;

  setUp(() async {
    await setUpTestHive();
    caches = await TestHive.open();
    tripPlannerHttpClient = MockTripPlannerHttpClient();
    wmsClient = MockClient();
  });

  tearDown(tearDownTestHive);

  testWidgets('Smoke test', (WidgetTester tester) async {
    when(tripPlannerHttpClient.getDatapoints()).thenAnswer(
      (_) => Future.error(http.ClientException('Not implemented')),
    );
    when(tripPlannerHttpClient.getTideGraph(any, any, any, any, any))
        .thenAnswer(
      (_) => Future.error(http.ClientException('Not implemented')),
    );

    final tripPlannerClient = TripPlannerClient(
      caches.stationCache,
      caches.tideGraphCache,
      () => Future.value(tripPlannerHttpClient),
      TimeZone.forId('America/Los_Angeles'),
    );

    await tester.pumpWidget(
      TripPlanner(
        tripPlannerClient: tripPlannerClient,
        wmsClient: wmsClient,
        tileCache: caches.tileCache,
      ),
    );
    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
