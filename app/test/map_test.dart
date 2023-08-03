import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' hide MapController;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:mockito/mockito.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:trip_planner_aquamarine/providers/ofs_client.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'package:trip_planner_aquamarine/util/latlng.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';
import 'package:trip_planner_aquamarine/widgets/tide_panel.dart';
import 'package:vector_math/vector_math_64.dart';

import 'util/async.dart';
import 'util/harness.dart';

class MapHarness extends StatelessWidget {
  const MapHarness({super.key, required this.harness, this.controller});
  final TripPlannerHarness harness;
  final MapController? controller;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
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

    testWidgets('handles tile retrieval errors', (tester) async {
      when(harness.client.get(any))
          .thenAnswer((_) async => http.Response('', 404));

      await tester.pumpWidget(MapHarness(harness: harness));
      await tester.pumpAndSettle();
    });

    testWidgets('handles empty tiles', (tester) async {
      when(harness.client.get(any)).thenAnswer(
          (_) async => http.Response.bytes(const [], HttpStatus.ok));

      await tester.pumpWidget(MapHarness(harness: harness));
      await tester.pumpAndSettle();
    });

    testWidgets('handles tile decoding errors', (tester) async {
      when(harness.client.get(any)).thenAnswer(
          (_) async => http.Response.bytes(const [0], HttpStatus.ok));

      await tester.pumpWidget(MapHarness(harness: harness));
      await tester.pumpAndSettle();
    });

    // AsturaPhoenix/trip_planner_aquamarine#83
    // When the map is moved after long-running tile fetches that eventually
    // fail, exceptions could be dropped in one of at least two ways:
    // * via the image provider (OneFrameImageStreamCompleter), if the map tile
    //   layer has unsubscribed from the image stream, as when the tile scrolls
    //   offscreen before the image loading fails, or
    // * via the async cache, if enough tiles are scrolled to cause eviction.
    //   The onEvict for images has to wait for them to load to dispose them.
    //   (There's an opportunity for improvement there.)
    //
    // The OneFrameImageStreamCompleter/FlutterError.reportError behavior is
    // acceptable and will be silent in release mode, but note that it can fail
    // tests.
    testWidgets('handles tile exceptions after map movement', (tester) async {
      final response = Completer<http.Response>();
      when(harness.client.get(any)).thenAnswer((_) => response.future);

      await tester.pumpWidget(MapHarness(harness: harness));

      // Scroll enough to cause both tile unsubscription and cache eviction.
      await tester.fling(find.byType(FlutterMap), const Offset(0, 1600), 1000);
      await tester.pumpAndSettle();

      // The OneFrameImageStreamCompleter behavior of using
      // FlutterError.reportError with silent = true is an acceptable way of
      // handling image errors that are dropped due to tiles scrolling
      // offscreen. To acknowledge this in the test, we need to do the
      // equivalent of tester.takeException on all such exceptions. We can do
      // something like this by overriding the error handler.
      addTearDown(() => FlutterError.onError = FlutterError.presentError);
      FlutterError.onError = (details) {
        if (!details.silent) {
          FlutterError.presentError(details);
        }
      };

      response.complete(http.Response.bytes(const [], HttpStatus.ok));
    });
  });
}
