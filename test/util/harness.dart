import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:http/http.dart' as http;
import 'package:joda/time.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';
import 'package:test/test.dart';
import 'package:timezone/data/latest_10y.dart';
import 'package:trip_planner_aquamarine/main.dart';
import 'package:trip_planner_aquamarine/platform/location.dart';
import 'package:trip_planner_aquamarine/platform/orientation.dart'
    as orientation;
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';

import '../data/empty.png.dart';
import 'async.dart';
import 'cache.dart';
@GenerateNiceMocks([
  MockSpec<TripPlannerHttpClient>(),
  MockSpec<http.Client>(),
  MockSpec<PermissionHandlerPlatform>(mixingIn: [MockPlatformInterfaceMixin]),
  MockSpec<GeolocatorPlatform>(mixingIn: [MockPlatformInterfaceMixin]),
  MockSpec<FilePicker>(mixingIn: [MockPlatformInterfaceMixin]),
])
import 'harness.mocks.dart';
import 'mockito.dart';
import 'motion_sensors.dart';

class TripPlannerHarness {
  static const horseshoeBayParkingLot = Position(
    latitude: 37.833861,
    longitude: -122.476934,
    timestamp: null,
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );

  static final timeZone = TimeZone.forId('America/Los_Angeles');

  static void setUpAll() {
    initializeLogger();
    initializeTimeZones();
  }

  Future<void> setUp({
    Set<Type> useReal = const {},
    bool isAbsoluteOrientationAvailable = false,
  }) async {
    if (!useReal.contains(SharedPreferences)) {
      final old = SharedPreferencesStorePlatform.instance;
      SharedPreferences.setMockInitialValues({});
      addTearDown(() => SharedPreferencesStorePlatform.instance = old);
    }
    if (!useReal.contains(PermissionHandlerPlatform)) {
      final old = PermissionHandlerPlatform.instance;
      PermissionHandlerPlatform.instance = permissionHandler;
      addTearDown(() => PermissionHandlerPlatform.instance = old);
    }
    if (!useReal.contains(GeolocatorPlatform)) {
      final old = GeolocatorPlatform.instance;
      GeolocatorPlatform.instance = geolocator;
      PlatformLocation.reset();
      addTearDown(() {
        GeolocatorPlatform.instance = old;
        PlatformLocation.reset();
      });
    }
    if (!useReal.contains(MotionSensors)) {
      orientation.PlatformOrientation.reset(FakeMotionSensors(motionSensors));
      motionSensors.isAbsoluteOrientationAvailable
          .complete(isAbsoluteOrientationAvailable);
      addTearDown(orientation.PlatformOrientation.reset);
    }
    if (!useReal.contains(FilePicker)) {
      final old = FilePicker.platform;
      FilePicker.platform = filePicker;
      addTearDown(() => FilePicker.platform = old);
    }

    when(wmsClient.get(any))
        .thenAnswer((_) => Completer<http.Response>().future);

    await TripPlanner.initAsyncGlobals();
  }

  final permissionHandler = MockPermissionHandlerPlatform();
  final geolocator = MockGeolocatorPlatform();
  final motionSensors = FakeMotionSensorsDriver();
  final filePicker = MockFilePicker();

  final stationCache = FakeBox<Station>();
  final tideGraphCache = FakeBlobCache(), tileCache = FakeBlobCache();
  final tripPlannerHttpClient = MockTripPlannerHttpClient();
  final wmsClient = MockClient();

  late final TripPlannerClient tripPlannerClient = TripPlannerClient(
    stationCache,
    tideGraphCache,
    () async => tripPlannerHttpClient,
    timeZone,
  );

  TripPlanner buildTripPlanner() => TripPlanner(
        tripPlannerClient: tripPlannerClient,
        wmsClient: wmsClient,
        tileCache: tileCache,
      );

  StreamController<Position> withLocation() {
    when(
      permissionHandler
          .requestPermissions(const [Permission.locationWhenInUse]),
    ).thenAnswer(
      (_) async => {Permission.locationWhenInUse: PermissionStatus.granted},
    );

    final position = StreamController<Position>.broadcast();
    when(
      geolocator.getPositionStream(
        locationSettings: anyNamed('locationSettings'),
      ),
    ).thenAnswer((_) => position.stream);
    return position;
  }

  Completer<Map<StationId, Station>> withStations() =>
      when(tripPlannerHttpClient.getDatapoints()).thenComplete();

  void withTideGraphs() =>
      when(tripPlannerHttpClient.getTideGraph(any, any, any, any, any))
          .thenAnswer((_) async => kEmptyPng);

  StreamController<OrientationEvent> withOrientation() {
    motionSensors.screenOrientation.seed(ScreenOrientationEvent(0));
    return motionSensors.absoluteOrientation;
  }
}
