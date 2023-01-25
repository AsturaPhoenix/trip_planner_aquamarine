import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';
import 'package:vector_math/vector_math_64.dart';

import '../test/data/datapoints.xml.dart';
import '../test/util/async.dart';
import '../test/util/harness.dart';

class MapHarness extends StatelessWidget {
  const MapHarness({super.key, required this.harness, this.selectedStation});
  final TripPlannerHarness harness;
  final Station? selectedStation;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Map(
            client: harness.wmsClient,
            tileCache: harness.tileCache,
            stations: kDatapoints,
            selectedStation: selectedStation,
          ),
        ),
      );
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late TripPlannerHarness harness;

  setUpAll(TripPlannerHarness.setUpAll);
  setUp(() => harness = TripPlannerHarness());

  group('with orientation', () {
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

      // Even after the controller is ready, the map may not respond to touch
      // events. (Also, in some cases on emulator the map refuses to ever load.)
      // Wait until the map requests a tile to continue.
      await tester.pumpUntil(
        untilCalled(harness.wmsClient.get(any)).timeout(kDefaultTimeout),
      );

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

      await tester.drag(find.byType(GoogleMap), const Offset(64, 0));

      finder = find.widgetWithImage(TextButton, PrecachedAsset.compass.image);
      await tester.waitFor(finder);
      await tester.tap(finder);

      finder = find.widgetWithImage(
        TextButton,
        PrecachedAsset.locationReticle.image,
      );
      await tester.waitFor(finder);
      await tester.tap(finder);

      finder =
          find.widgetWithImage(TextButton, PrecachedAsset.locationNorth.image);
      await tester.waitFor(finder);
      expect(finder, findsOneWidget);
    });
  });

  group('without orientation', () {
    setUp(() => harness.setUp(isAbsoluteOrientationAvailable: false));

    testWidgets('fits nogo zone from free orientation', (tester) async {
      await tester.pumpWidget(MapHarness(harness: harness));

      // Even after the controller is ready, the map may not respond to touch
      // events. (Also, in some cases on emulator the map refuses to ever load.)
      // Wait until the map requests a tile to continue.
      await tester.pumpUntil(
        untilCalled(harness.wmsClient.get(any)).timeout(kDefaultTimeout),
      );

      // The controls show up once the map controller is ready.
      await tester.waitFor(
        find.widgetWithIcon(TextButton, Icons.location_searching),
      );
      await tester.pumpAndSettle();

      // Do the gesture twice in case the map isn't responseive yet to decrease
      // the likelihood of a flake.
      for (int i = 0; i < 2; ++i) {
        final center = tester.getCenter(find.byType(GoogleMap));
        final pointers = [
          await tester.startGesture(pointer: 0, center - const Offset(-64, 0)),
          await tester.startGesture(pointer: 1, center - const Offset(64, 0))
        ];
        for (int i = 0; i < 16; ++i) {
          await pointers[0].moveBy(const Offset(0, -4));
          await pointers[1].moveBy(const Offset(0, 4));
          await tester.pump(kFrame);
        }
        for (final pointer in pointers) {
          await pointer.up();
        }
      }

      expect(
        find.widgetWithImage(TextButton, PrecachedAsset.compass.image),
        findsOneWidget,
      );

      await tester.pumpWidget(
        MapHarness(
          harness: harness,
          selectedStation: kDatapoints.values
              .firstWhere((station) => station.type == StationType.nogo),
        ),
      );

      await tester.waitFor(
        find.widgetWithIcon(TextButton, Icons.location_searching),
      );
    });
  });
}
