import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' hide MapController;
import 'package:flutter_test/flutter_test.dart';
import 'package:latlng/latlng.dart';
import 'package:motion_sensors/motion_sensors.dart';

import 'package:trip_planner_aquamarine/providers/ofs_client.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'package:trip_planner_aquamarine/util/latlng.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';
import 'package:trip_planner_aquamarine/widgets/tide_panel.dart';
import 'package:vector_math/vector_math_64.dart';

import 'data/datapoints.xml.dart';
import 'util/async.dart';
import 'util/harness.dart';

class MapHarness extends StatelessWidget {
  const MapHarness({super.key, required this.harness, this.controller});
  final TripPlannerHarness harness;
  final MapController? controller;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: Map(
            client: harness.client,
            tileCache: harness.tileCache,
            ofsClient: OfsClient(harness.client, Uri()),
            stations: kDatapoints,
            timeWindow: GraphTimeWindow.now(TripPlannerHarness.timeZone),
            controller: controller,
          ),
        ),
      );
}

void main() {
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

      await tester.pumpWidget(MapHarness(harness: harness));

      await tester.tap(
          find.widgetWithImage(TextButton, PrecachedAsset.locationNorth.image));
      await tester.pumpAndSettle();

      expect(
        find.widgetWithImage(
          TextButton,
          PrecachedAsset.compassDirections.image,
        ),
        findsOneWidget,
      );

      await tester.drag(find.byType(FlutterMap), const Offset(64, 0));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithImage(
        TextButton,
        PrecachedAsset.compass.image,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithImage(
        TextButton,
        PrecachedAsset.locationReticle.image,
      ));
      await tester.pumpAndSettle();

      expect(
        find.widgetWithImage(TextButton, PrecachedAsset.locationNorth.image),
        findsOneWidget,
      );
    });
  });

  group('without orientation', () {
    setUp(() => harness.setUp(isAbsoluteOrientationAvailable: false));

    testWidgets('fits nogo zone from free orientation', (tester) async {
      final controller = MapController();
      await tester.pumpWidget(MapHarness(
        harness: harness,
        controller: controller,
      ));
      await tester.pumpAndSettle();

      final MapState mapState = tester.state(find.byType(Map));

      final center = tester.getCenter(find.byType(FlutterMap));
      final pointers = [
        await tester.startGesture(pointer: 0, center - const Offset(-64, 0)),
        await tester.startGesture(pointer: 1, center - const Offset(64, 0)),
      ];
      for (int i = 0; i < 16; ++i) {
        await pointers[0].moveBy(const Offset(0, -4));
        await pointers[1].moveBy(const Offset(0, 4));
        await tester.pump(kFrame);
      }
      for (final pointer in pointers) {
        await pointer.up();
      }

      await tester.pumpAndSettle();

      expect(
        find.widgetWithImage(TextButton, PrecachedAsset.compass.image),
        findsOneWidget,
      );

      final station = kDatapoints.values
          .firstWhere((station) => station.type == StationType.nogo);
      controller.selectStation(station);
      await tester.pumpAndSettle();

      final bounds = mapState.mapController.bounds!;
      expect(
        station.outlines,
        everyElement(
          everyElement(
            predicate(
              (LatLng latlng) => bounds.contains(latlng.toFml()),
            ),
          ),
        ),
      );
    });
  });
}
