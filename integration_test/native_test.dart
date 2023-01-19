import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:patrol/patrol.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

import 'package:trip_planner_aquamarine/widgets/tide_panel.dart';
import 'package:vector_math/vector_math_64.dart';

import '../test/util/async.dart';
import '../test/util/harness.dart';

void main() {
  late TripPlannerHarness harness;

  setUpAll(TripPlannerHarness.setUpAll);
  setUp(() => harness = TripPlannerHarness());
  setUp(
    () => harness.setUp(
      useReal: const {PermissionHandlerPlatform},
      isAbsoluteOrientationAvailable: true,
    ),
  );

  /// Permissions request dialogs can interrupt the app lifecycle. This has
  /// previously caused bugs with camera management. We need to do this test
  /// natively because the camera permission request happens natively in the
  /// camera library rather than through PermissionHandlerPlatform, and anyway
  /// we need the camera actually serving data (which it needs real permission
  /// to do) to test against its idiosyncrasies.
  patrolTest('permissions requests and app lifecycles', nativeAutomation: true,
      ($) async {
    harness.withStations().complete(TripPlannerHarness.testStations);
    harness.withTideGraphs();
    final position = harness.withLocation();
    final orientation = harness.withOrientation();

    await $.pumpWidgetAndSettle(harness.buildTripPlanner());
    await $.native.grantPermissionOnlyThisTime();
    position.add(TripPlannerHarness.horseshoeBayParkingLot);
    await $.waitUntilVisible(find.byType(TidePanel));

    await $.tap(find.byIcon(Icons.explore), andSettle: false);
    await $.pump();
    position.add(TripPlannerHarness.horseshoeBayParkingLot);
    orientation.add(
      OrientationEvent(Quaternion.euler(-pi / 4, -pi / 2, 0)..conjugate()),
    );
    await $.tester.pumpUntil($.native.isPermissionDialogVisible());
    await $.native.grantPermissionOnlyThisTime();
    await $.pumpAndSettle();

    expect(find.byType(CameraPreview), findsOneWidget);
  });
}
