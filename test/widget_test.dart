import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_planner_aquamarine/main.dart';

import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';
import 'package:trip_planner_aquamarine/widgets/tide_panel.dart';

import 'data/datapoints.xml.dart';
import 'util/async.dart';
import 'util/geolocator.dart';
import 'util/harness.dart';

void main() {
  late TripPlannerHarness harness;

  setUpAll(TripPlannerHarness.setUpAll);
  setUp(() => harness = TripPlannerHarness());
  setUp(() => harness.setUp());

  testWidgets('smoke test', (tester) async {
    await tester.pumpWidget(harness.buildTripPlanner());
    expect(find.byType(FlutterMap), findsOneWidget);
  });

  group('with stations and tide graphs', () {
    setUp(() => harness
      ..withStations().complete(kDatapoints)
      ..withTideGraphs());

    testWidgets('initializes without location permission', (tester) async {
      await tester.pumpWidget(harness.buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();
      expect(find.byType(TidePanel), findsOneWidget);
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

      final current = kDatapoints.values.firstWhere((station) =>
              station.type == StationType.current && !station.isLegacy),
          destination = kDatapoints.values
              .firstWhere((station) => station.type == StationType.destination),
          nogo = kDatapoints.values
              .firstWhere((station) => station.type == StationType.nogo);

      final stationFilters =
          tester.widget<Map>(find.byType(Map)).stationFilters;
      int stationPriority(Station station) =>
          -stationFilters.indexWhere((p) => p(station));

      expect(
        stationPriority(current),
        greaterThan(stationPriority(destination)),
      );
      expect(
        stationPriority(destination),
        greaterThan(stationPriority(nogo)),
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

      final current = kDatapoints.values.firstWhere((station) =>
              station.type == StationType.current && !station.isLegacy),
          destination = kDatapoints.values
              .firstWhere((station) => station.type == StationType.destination),
          nogo = kDatapoints.values
              .firstWhere((station) => station.type == StationType.nogo);

      var stationFilters = tester.widget<Map>(find.byType(Map)).stationFilters;
      int stationPriority(Station station) =>
          -stationFilters.indexWhere((p) => p(station));

      expect(
        stationPriority(destination),
        greaterThan(stationPriority(current)),
      );
      expect(
        stationPriority(current),
        greaterThan(stationPriority(nogo)),
      );

      // Don't bother flipping when the Plot panel is selected.
      await tester.tap(find.text('Plot'));
      await tester.pumpAndSettle();
      await tester.pump(Duration.zero);

      expect(
          tester.widget<Map>(find.byType(Map)).stationFilters, stationFilters);

      await tester.tap(find.text('Tides'));
      await tester.pumpAndSettle();
      await tester.pump(Duration.zero);

      expect(tester.widget<Map>(find.byType(Map)).stationFilters,
          isNot(stationFilters));
      stationFilters = tester.widget<Map>(find.byType(Map)).stationFilters;

      expect(
        stationPriority(current),
        greaterThan(stationPriority(destination)),
      );
      expect(
        stationPriority(destination),
        greaterThan(stationPriority(nogo)),
      );

      // Again, don't bother flipping when the Plot panel is selected.
      await tester.tap(find.text('Plot'));
      await tester.pumpAndSettle();
      await tester.pump(Duration.zero);

      expect(
          tester.widget<Map>(find.byType(Map)).stationFilters, stationFilters);
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
    });

    testWidgets('starts with location tracking', (tester) async {
      final position = harness.withLocation();

      await tester.pumpWidget(harness.buildTripPlanner());
      position.add(TripPlannerHarness.horseshoeBayParkingLot);
      await tester.flushAsync();
      await tester.pumpAndSettle();

      expect(tester.state<MapState>(find.byType(Map)).trackingMode,
          TrackingMode.location);
    });

    testWidgets("doesn't initialze station to unselectable station",
        (tester) async {
      final unselectableStation = kDatapoints.values
          .firstWhere((station) => station.type == StationType.meeting);
      harness.withLocation().seed(testPosition(unselectableStation.marker));

      await tester.pumpWidget(harness.buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();

      final TripPlannerState state = tester.state(find.byType(TripPlanner));
      expect(
          state.selectedStation,
          predicate((Station station) =>
              state.stationFilters.any((p) => p(station))));

      await tester.pump(Duration.zero);
    });

    testWidgets(
        'can select a station without an associated tide/current station',
        (tester) async {
      await tester.pumpWidget(harness.buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();

      final TripPlannerState state = tester.state(find.byType(TripPlanner));
      state.mapController.selectStation(kDatapoints.values.firstWhere(
          (station) =>
              !station.type.isTideCurrent &&
              station.tideCurrentStationId == null));
      await tester.pump();

      expect(find.text('Tides'), findsNothing);
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
  });
}
