import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:joda/time.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_10y.dart';

import 'package:trip_planner_aquamarine/main.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';

import 'util/test_cache.dart';
@GenerateNiceMocks([MockSpec<TripPlannerHttpClient>(), MockSpec<http.Client>()])
import 'widget_test.mocks.dart';

void main() {
  initializeLogger();

  initializeTimeZones();
  final timeZone = TimeZone.forId('America/Los_Angeles');

  late FakeBox<Station> stationCache;
  late FakeBlobCache tideGraphCache, tileCache;
  late MockTripPlannerHttpClient tripPlannerHttpClient;
  late TripPlannerClient tripPlannerClient;
  late MockClient wmsClient;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await TripPlanner.initAsyncGlobals();

    tripPlannerHttpClient = MockTripPlannerHttpClient();
    stationCache = FakeBox();
    tideGraphCache = FakeBlobCache();
    tileCache = FakeBlobCache();

    tripPlannerClient = TripPlannerClient(
      stationCache,
      tideGraphCache,
      () => Future.value(tripPlannerHttpClient),
      timeZone,
    );

    wmsClient = MockClient();
  });

  TripPlanner buildTripPlanner() => TripPlanner(
        tripPlannerClient: tripPlannerClient,
        wmsClient: wmsClient,
        tileCache: tileCache,
      );

  testWidgets('Smoke test', (tester) async {
    await tester.pumpWidget(buildTripPlanner());
    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
