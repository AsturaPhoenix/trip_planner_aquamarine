import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:joda/time.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_10y.dart';

import 'package:trip_planner_aquamarine/main.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';
import 'package:trip_planner_aquamarine/widgets/tide_panel.dart';

import 'util/test_cache.dart';
@GenerateNiceMocks([
  MockSpec<TripPlannerHttpClient>(),
  MockSpec<http.Client>(),
  MockSpec<PermissionHandlerPlatform>(mixingIn: [MockPlatformInterfaceMixin])
])
import 'widget_test.mocks.dart';

extension on WidgetTester {
  /// For some reason, nontrivial streams tend to require real asyncs. There are
  /// numerous possible related issues, e.g. dart-lang/sdk#40131
  Future<void> flushAsync() async => runAsync(() async {});
}

void main() {
  initializeLogger();

  final testStations =
      parseStations(File('test/data/datapoints.xml').readAsStringSync());
  final testImage = File('test/data/empty.png');

  initializeTimeZones();
  final timeZone = TimeZone.forId('America/Los_Angeles');

  late FakeBox<Station> stationCache;
  late FakeBlobCache tideGraphCache, tileCache;
  late MockTripPlannerHttpClient tripPlannerHttpClient;
  late TripPlannerClient tripPlannerClient;
  late MockClient wmsClient;

  setUp(() async {
    PermissionHandlerPlatform.instance = MockPermissionHandlerPlatform();

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

  group('With stations and tide graphs', () {
    setUp(() {
      when(tripPlannerHttpClient.getDatapoints())
          .thenAnswer((_) async => testStations);
      when(tripPlannerHttpClient.getTideGraph(any, any, any, any, any))
          .thenAnswer((_) async => testImage.readAsBytes());
    });

    testWidgets('Initializes without location permission', (tester) async {
      await tester.pumpWidget(buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();
      expect(find.byType(TidePanel), findsOneWidget);
      // We need to flush the scheduled _onPanelChanged or the test will complain.
      // There isn't a great way to dispose this timer. flutter/flutter PR 116422
      await tester.pump(Duration.zero);
    });

    testWidgets("Doesn't try to flip station z-indices after disposed",
        (tester) async {
      await tester.pumpWidget(buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();
      // dispose the TripPlanner
      await tester.pumpWidget(const SizedBox());
      // make sure the TripPlanner doesn't try to run the _onPanelChanged callback
      await tester.pump(Duration.zero);
    });

    testWidgets('Flips station z-indices when details panel is selected',
        (tester) async {
      await tester.pumpWidget(buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Details'));
      await tester.pumpAndSettle();
      await tester.pump(Duration.zero);

      final stationPriority =
          tester.widget<Map>(find.byType(Map)).stationPriority;
      expect(
        stationPriority(StationType.destination),
        greaterThan(stationPriority(StationType.current)),
      );
    });
  });
}
