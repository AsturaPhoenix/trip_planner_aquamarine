import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_planner_aquamarine/main.dart';

import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';
import 'package:trip_planner_aquamarine/widgets/tide_panel.dart';

import 'data/datapoints.xml.dart';
import 'util/async.dart';
import 'util/geolocator.dart';
import 'util/harness.dart';

extension on WidgetTester {
  /// For some reason, nontrivial streams tend to require real asyncs. There are
  /// numerous possible related issues, e.g. dart-lang/sdk#40131
  Future<void> flushAsync() async => runAsync(() async {});
}

void main() {
  late TripPlannerHarness harness;

  setUpAll(TripPlannerHarness.setUpAll);
  setUp(() => harness = TripPlannerHarness());
  setUp(() => harness.setUp());

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(harness.buildTripPlanner());
    expect(find.byType(GoogleMap), findsOneWidget);
  });

  group('with stations and tide graphs', () {
    setUp(() {
      harness.withStations().complete(kDatapoints);
      harness.withTideGraphs();
    });

    testWidgets('initializes without location permission', (tester) async {
      await tester.pumpWidget(harness.buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();
      expect(find.byType(TidePanel), findsOneWidget);
      // We need to flush the scheduled _onPanelChanged or the test will
      // complain. There isn't a great way to dispose this timer.
      // flutter/flutter PR 116422
      await tester.pump(Duration.zero);
    });

    testWidgets("doesn't try to flip station z-indices after disposed",
        (tester) async {
      await tester.pumpWidget(harness.buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();
      // dispose the TripPlanner
      await tester.pumpWidget(const SizedBox());
      // make sure the TripPlanner doesn't try to run the _onPanelChanged callback
      await tester.pump(Duration.zero);
    });

    testWidgets('default station priority', (tester) async {
      await tester.pumpWidget(harness.buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();
      await tester.pump(Duration.zero);

      final stationPriority =
          tester.widget<Map>(find.byType(Map)).stationPriority;
      expect(
        stationPriority(StationType.current),
        greaterThan(stationPriority(StationType.destination)),
      );
      expect(
        stationPriority(StationType.destination),
        greaterThan(stationPriority(StationType.nogo)),
      );
    });

    testWidgets('flips station z-indices when certain panels are selected',
        (tester) async {
      await tester.pumpWidget(harness.buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Details'));
      await tester.pumpAndSettle();
      await tester.pump(Duration.zero);

      var stationPriority =
          tester.widget<Map>(find.byType(Map)).stationPriority;

      expect(
        stationPriority(StationType.destination),
        greaterThan(stationPriority(StationType.current)),
      );
      expect(
        stationPriority(StationType.current),
        greaterThan(stationPriority(StationType.nogo)),
      );

      // Don't bother flipping when the Plot panel is selected.
      await tester.tap(find.text('Plot'));
      await tester.pumpAndSettle();
      await tester.pump(Duration.zero);

      expect(tester.widget<Map>(find.byType(Map)).stationPriority,
          stationPriority);

      await tester.tap(find.text('Tides'));
      await tester.pumpAndSettle();
      await tester.pump(Duration.zero);

      expect(tester.widget<Map>(find.byType(Map)).stationPriority,
          isNot(stationPriority));
      stationPriority = tester.widget<Map>(find.byType(Map)).stationPriority;

      expect(
        stationPriority(StationType.current),
        greaterThan(stationPriority(StationType.destination)),
      );
      expect(
        stationPriority(StationType.destination),
        greaterThan(stationPriority(StationType.nogo)),
      );

      // Again, don't bother flipping when the Plot panel is selected.
      await tester.tap(find.text('Plot'));
      await tester.pumpAndSettle();
      await tester.pump(Duration.zero);

      expect(tester.widget<Map>(find.byType(Map)).stationPriority,
          stationPriority);
    });

    testWidgets('waits for location fix to initialize', (tester) async {
      final position = harness.withLocation();

      await tester.pumpWidget(harness.buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();
      expect(find.byType(TidePanel), findsNothing);

      position.add(TripPlannerHarness.horseshoeBayParkingLot);
      await tester.flushAsync();
      await tester.pumpAndSettle();
      expect(find.byType(TidePanel), findsOneWidget);

      // We need to flush the scheduled _onPanelChanged or the test will complain.
      // There isn't a great way to dispose this timer. flutter/flutter PR 116422
      await tester.pump(Duration.zero);
    });

    testWidgets("doesn't initialze station to unselectable station",
        (tester) async {
      final unselectableStation = kDatapoints.values
          .firstWhere((station) => !Map.showMarkerTypes.contains(station.type));
      harness.withLocation().seed(testPosition(unselectableStation.marker));

      await tester.pumpWidget(harness.buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();

      final TripPlannerState state = tester.state(find.byType(TripPlanner));
      expect(
          state.selectedStation?.type, predicate(Map.showMarkerTypes.contains));

      await tester.pump(Duration.zero);
    });

    group('in portrait layout', () {
      setUp(() {
        final window = TestWidgetsFlutterBinding.instance.window;
        window.physicalSizeTestValue =
            const Size(600, 800) * window.devicePixelRatio;
      });

      group('can collapse the bottom sheet', () {
        testWidgets('by dragging a tab', (tester) async {
          await tester.pumpWidget(harness.buildTripPlanner());
          await tester.flushAsync();
          await tester.pumpAndSettle();

          await tester.fling(
              find.byType(Tab).at(1), const Offset(0, 128), 1000);
          await tester.pumpAndSettle();

          expect(find.byType(TidePanel).hitTestable(), findsNothing);
        });

        testWidgets('by dragging the content panel', (tester) async {
          await tester.pumpWidget(harness.buildTripPlanner());
          await tester.flushAsync();
          await tester.pumpAndSettle();

          await tester.fling(
              find.byType(TidePanel), const Offset(0, 128), 1000);
          await tester.pumpAndSettle();

          expect(find.byType(TidePanel).hitTestable(), findsNothing);
        });

        // The content panel is kept no smaller than a minimum size and clipped
        // to achieve a graceful collapse effect while allowing for responsive
        // sizing when there's not enough vertical space, but this means we need
        // to take special care that the whole panel (including tabs) doesn't
        // become scrollable since it's in a DraggableScrollableSheet.
        testWidgets("but doesn't scroll the bottom sheet content",
            (tester) async {
          await tester.pumpWidget(harness.buildTripPlanner());
          await tester.flushAsync();
          await tester.pumpAndSettle();

          final tab = find.byType(Tab).at(1);

          await tester.fling(tab, const Offset(0, 128), 1000);
          await tester.pumpAndSettle();

          final pointer = TestPointer(1, PointerDeviceKind.mouse);
          await tester.sendEventToBinding(pointer.hover(tester.getCenter(tab)));
          await tester.sendEventToBinding(pointer.scroll(const Offset(0, 128)));
          await tester.pumpAndSettle();

          expect(tab.hitTestable(), findsOneWidget);
        });
      });
    });
  });

  testWidgets('initializes after location then stations', (tester) async {
    final position = harness.withLocation();
    final stations = harness.withStations();
    harness.withTideGraphs();

    await tester.pumpWidget(harness.buildTripPlanner());
    position.add(TripPlannerHarness.horseshoeBayParkingLot);
    await tester.flushAsync();
    await tester.pumpAndSettle();

    stations.complete(kDatapoints);
    await tester.pumpAndSettle();
    expect(find.byType(TidePanel), findsOneWidget);

    await tester.pump(Duration.zero);
  });
}
