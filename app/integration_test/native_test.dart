import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:patrol/patrol.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:test_data/datapoints.xml.dart';
import 'package:trip_planner_aquamarine/widgets/compass.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';
import 'package:trip_planner_aquamarine/widgets/tide_panel.dart';
import 'package:vector_math/vector_math_64.dart';

import '../test/util/async.dart';
import '../test/util/harness.dart';

@isTest
void test(String description, Future<void> Function(PatrolTester) callback) =>
    patrolTest(
      description,
      config: const PatrolTesterConfig(
        existsTimeout: kDefaultTimeout,
        visibleTimeout: kDefaultTimeout,
        settleTimeout: kDefaultTimeout,
      ),
      nativeAutomation: true,
      callback,
    );

// There are a couple cases where we need to wait for a map to settle, but since
// camera events are processed by native Maps, pumpAndSettle doesn't catch
// pending updates.
Future<void> pumpUntilMapSettled(WidgetTester tester,
    {int settleForFrames = 15}) async {
  final MapState mapState = tester.state(find.byType(Map));
  CameraPosition cameraPosition = mapState.cameraPosition;

  await tester.pump(kFrame);

  int settledCount = 0;
  try {
    await tester.pumpWhile(() {
      if (cameraPosition == mapState.cameraPosition) {
        ++settledCount;
      } else {
        settledCount = 0;
      }
      cameraPosition = mapState.cameraPosition;
      return settledCount < settleForFrames;
    });
  } on TimeoutException catch (e) {
    print('Warning: $e');
  }
}

void main() {
  PatrolBinding.ensureInitialized();

  late TripPlannerHarness harness;

  setUpAll(TripPlannerHarness.setUpAll);
  setUp(() => harness = TripPlannerHarness());

  group('with real permissions', () {
    setUp(
      () => harness.setUp(
        useReal: const {CameraPlatform, PermissionHandlerPlatform},
        isAbsoluteOrientationAvailable: true,
      ),
    );

    /// Permissions request dialogs can interrupt the app lifecycle. This has
    /// previously caused bugs with camera management. We need to do this test
    /// natively because the camera permission request happens natively in the
    /// camera library rather than through PermissionHandlerPlatform, and anyway
    /// we need the camera actually serving data (which it needs real permission
    /// to do) to test against its idiosyncrasies.
    test('permissions requests and app lifecycles', ($) async {
      harness.withStations().complete(kDatapoints);
      harness.withTideGraphs();
      final position = harness.withLocation();
      final orientation = harness.withOrientation();

      await $.pumpWidget(harness.buildTripPlanner());
      await $.tester.pumpUntil($.native.isPermissionDialogVisible());
      await $.native.grantPermissionWhenInUse();
      position.add(TripPlannerHarness.horseshoeBayParkingLot);
      await $.waitUntilVisible(find.byType(TidePanel));

      await $.tap(find.byIcon(Icons.explore), andSettle: false);
      await $.tester.waitFor(find.byType(Compass));
      position.add(TripPlannerHarness.horseshoeBayParkingLot);
      orientation.add(
        OrientationEvent(Quaternion.euler(-pi / 4, -pi / 2, 0)..conjugate()),
      );
      await $.tester.pumpUntil($.native.isPermissionDialogVisible());
      await $.native.grantPermissionWhenInUse();
      await $.pumpAndSettle();

      expect(find.byType(CameraPreview), findsOneWidget);
    });
  });
}
