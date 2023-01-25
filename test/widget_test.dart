import 'package:flutter/widgets.dart';
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
      harness.withStations().complete(kDatapointsXml);
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

    testWidgets('flips station z-indices when details panel is selected',
        (tester) async {
      await tester.pumpWidget(harness.buildTripPlanner());
      await tester.flushAsync();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Details'));
      await tester.pumpAndSettle();
      await tester.pump(Duration.zero);

      final stationPriority =
          tester.widget<Map>(find.byType(Map)).stationPriority;
      expect(
        stationPriority(StationType.destination),
        greaterThan(stationPriority(StationType.current)),
      );
      expect(
        stationPriority(StationType.current),
        greaterThan(stationPriority(StationType.nogo)),
      );
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
      final unselectableStation = kDatapointsXml.values
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
  });

  testWidgets('initializes after location then stations', (tester) async {
    final position = harness.withLocation();
    final stations = harness.withStations();
    harness.withTideGraphs();

    await tester.pumpWidget(harness.buildTripPlanner());
    position.add(TripPlannerHarness.horseshoeBayParkingLot);
    await tester.flushAsync();
    await tester.pumpAndSettle();

    stations.complete(kDatapointsXml);
    await tester.pumpAndSettle();
    expect(find.byType(TidePanel), findsOneWidget);

    await tester.pump(Duration.zero);
  });
}
