import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';
import 'package:vector_math/vector_math_64.dart';

import '../test/util/async.dart';
import '../test/util/harness.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late TripPlannerHarness harness;

  setUpAll(TripPlannerHarness.setUpAll);
  setUp(() => harness = TripPlannerHarness());
  setUp(() => harness.setUp(isAbsoluteOrientationAvailable: true));

  testWidgets('cycle map lock modes', (tester) async {
    harness
      ..withLocation().seed(TripPlannerHarness.horseshoeBayParkingLot)
      ..withOrientation()
          .seed(OrientationEvent(Quaternion.euler(pi / 4, 0, 0)));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Map(client: harness.wmsClient, tileCache: harness.tileCache),
        ),
      ),
    );
    await tester.pumpAndSettle();

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
    await tester.pumpAndSettle();
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
