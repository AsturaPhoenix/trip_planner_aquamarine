import 'dart:async';
import 'dart:core';
import 'dart:core' as core;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';
import 'package:joda/time.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_10y.dart';
import 'package:trip_planner_aquamarine/main.dart';
import 'package:trip_planner_aquamarine/platform/orientation.dart'
    as orientation;
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';
import 'package:vector_math/vector_math_64.dart';

import '../test/util/test_cache.dart';
import '../test/util/test_motion_sensors.dart';
@GenerateNiceMocks([
  MockSpec<TripPlannerHttpClient>(),
  MockSpec<http.Client>(),
  MockSpec<PermissionHandlerPlatform>(mixingIn: [MockPlatformInterfaceMixin]),
  MockSpec<GeolocatorPlatform>(mixingIn: [MockPlatformInterfaceMixin]),
])
import 'integration_test.mocks.dart';

Position testPosition(LatLng coordinate) => Position(
      longitude: coordinate.longitude,
      latitude: coordinate.latitude,
      timestamp: core.DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );

extension<T> on StreamController<T> {
  void seed(T value) => onListen = () => add(value);
}

extension on WidgetTester {
  Future<void> waitFor(
    Finder finder, {
    Duration interval = const Duration(milliseconds: 16, microseconds: 683),
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final end = binding.clock.fromNowBy(timeout);
    while (finder.evaluate().isEmpty && binding.clock.now().isBefore(end)) {
      await pump(interval);
    }
  }
}

void main() {
  const horseshoeBayParkingLot = LatLng(37.833861, -122.476934);

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  initializeTimeZones();
  final timeZone = TimeZone.forId('America/Los_Angeles');

  late MockPermissionHandlerPlatform permissionHandler;
  late MockGeolocatorPlatform geolocator;
  late FakeMotionSensorsDriver motionSensors;

  late FakeBox<Station> stationCache;
  late FakeBlobCache tideGraphCache, tileCache;
  late MockTripPlannerHttpClient tripPlannerHttpClient;
  late TripPlannerClient tripPlannerClient;
  late MockClient wmsClient;

  setUp(() {
    PermissionHandlerPlatform.instance =
        permissionHandler = MockPermissionHandlerPlatform();
    GeolocatorPlatform.instance = geolocator = MockGeolocatorPlatform();
    motionSensors = (orientation.motionSensors = FakeMotionSensors()).driver
      ..isAbsoluteOrientationAvailable.complete(true);

    SharedPreferences.setMockInitialValues({});

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
    when(wmsClient.get(any))
        .thenAnswer((_) => Completer<http.Response>().future);
  });

  setUp(TripPlanner.initAsyncGlobals);

  TripPlanner buildTripPlanner() => TripPlanner(
        tripPlannerClient: tripPlannerClient,
        wmsClient: wmsClient,
        tileCache: tileCache,
      );

  StreamController<Position> withLocation() {
    final position = StreamController<Position>.broadcast();

    when(
      permissionHandler.requestPermissions([Permission.locationWhenInUse]),
    ).thenAnswer(
      (_) async => {Permission.locationWhenInUse: PermissionStatus.granted},
    );
    when(
      geolocator.getPositionStream(
        locationSettings: anyNamed('locationSettings'),
      ),
    ).thenAnswer((_) => position.stream);

    return position;
  }

  testWidgets('cycle map lock modes', (tester) async {
    withLocation().seed(testPosition(horseshoeBayParkingLot));
    motionSensors.screenOrientation.seed(ScreenOrientationEvent(0));
    motionSensors.absoluteOrientation
        .seed(OrientationEvent(Quaternion.euler(pi / 4, 0, 0)));

    await tester.pumpWidget(buildTripPlanner());

    var finder =
        find.widgetWithImage(TextButton, PrecachedAsset.locationNorth.image);
    await tester.waitFor(finder);
    await tester.tap(finder);

    finder = find.widgetWithImage(
      TextButton,
      PrecachedAsset.compassDirections.image,
    );
    await tester.pumpAndSettle(); // Allow rotation animation to complete.
    expect(finder, findsOneWidget);

    await tester.drag(find.byType(GoogleMap), const Offset(128, 0));

    finder = find.widgetWithImage(TextButton, PrecachedAsset.compass.image);

    await tester.waitFor(finder);
    await tester.tap(finder);

    finder =
        find.widgetWithImage(TextButton, PrecachedAsset.locationReticle.image);
    await tester.waitFor(finder);
    await tester.tap(finder);

    finder =
        find.widgetWithImage(TextButton, PrecachedAsset.locationNorth.image);
    await tester.waitFor(finder);
    expect(finder, findsOneWidget);
  });
}
