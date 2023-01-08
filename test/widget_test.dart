import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:http/http.dart' as http;
import 'package:joda/time.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_10y.dart';

import 'package:trip_planner_aquamarine/main.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'package:trip_planner_aquamarine/widgets/tide_panel.dart';

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
  final timeZone = TimeZone.forId('America/Los_Angeles');

  late TestHive caches;
  late MockTripPlannerHttpClient tripPlannerHttpClient;
  late TripPlannerClient tripPlannerClient;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await TripPlanner.initAsyncGlobals();

    await setUpTestHive();
    caches = await TestHive.open();
    tripPlannerHttpClient = MockTripPlannerHttpClient();

    tripPlannerClient = TripPlannerClient(
      caches.stationCache,
      caches.tideGraphCache,
      () => Future.value(tripPlannerHttpClient),
      timeZone,
    );
  });

  tearDown(tearDownTestHive);

  testWidgets('Smoke test', (WidgetTester tester) async {
    final MockClient wmsClient = MockClient();

    when(tripPlannerHttpClient.getDatapoints()).thenAnswer(
      (_) => Future.error(http.ClientException('Not implemented')),
    );
    when(tripPlannerHttpClient.getTideGraph(any, any, any, any, any))
        .thenAnswer(
      (_) => Future.error(http.ClientException('Not implemented')),
    );

    await tester.pumpWidget(
      TripPlanner(
        tripPlannerClient: tripPlannerClient,
        wmsClient: wmsClient,
        tileCache: caches.tileCache,
      ),
    );
    expect(find.byType(GoogleMap), findsOneWidget);
    await tester.pumpAndSettle();
  });

  group('TimeControls', () {
    GraphTimeWindow testWindow(Date t0, LocalDateTime t, int days) =>
        GraphTimeWindow(
          DateTime.atStartOfDay(t0, timeZone),
          DateTime.resolve(t, timeZone),
          days,
          TimeWindowCorrectionPolicy.strict,
        );

    GraphTimeWindow? result;

    Widget buildTestHarness(GraphTimeWindow timeWindow) => MaterialApp(
          home: Scaffold(
            body: TimeControls(
              timeWindow: timeWindow,
              onWindowChanged: (timeWindow) => result = timeWindow,
            ),
          ),
        );

    testWidgets('shifts window when date is picked',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestHarness(
          testWindow(
            const Date(2022, 12, 4),
            const Date(2022, 12, 5) & const Time(4, 30),
            4,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.calendar_month));
      await tester.pump();
      await tester.tap(find.text('6'));
      await tester.tap(find.text('OK'));

      expect(
        result,
        testWindow(
          const Date(2022, 12, 5),
          const Date(2022, 12, 6) & const Time(4, 30),
          4,
        ),
      );
    });

    testWidgets('preserves offset around fall back',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestHarness(
          testWindow(
            const Date(2022, 11, 5),
            const Date(2022, 11, 5) & const Time(0, 30),
            1,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.keyboard_arrow_right));

      expect(
        result,
        testWindow(
          const Date(2022, 11, 6),
          const Date(2022, 11, 6) & const Time(1, 30),
          1,
        ),
      );
    });

    testWidgets('preserves offset around spring forward',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestHarness(
          testWindow(
            const Date(2022, 3, 14),
            const Date(2022, 3, 14) & const Time(2, 30),
            1,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.keyboard_arrow_left));

      expect(
        result,
        testWindow(
          const Date(2022, 3, 13),
          const Date(2022, 3, 13) & const Time(3, 30),
          1,
        ),
      );
    });
  });
}
