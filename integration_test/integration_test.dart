import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';

import '../test/data/datapoints.xml.dart';
import '../test/data/sfo.gpx.dart';
import '../test/util/async.dart';
import '../test/util/harness.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late TripPlannerHarness harness;

  setUpAll(TripPlannerHarness.setUpAll);
  setUp(() => harness = TripPlannerHarness()
    ..setUp()
    ..withStations().complete(kDatapoints)
    ..withTideGraphs());

  testWidgets(
      'does not zoom map out to world when GPS track is selected while bottom '
      'sheet is expanded', (tester) async {
    // Sheet only expands in portrait orientation.
    await tester.binding.setSurfaceSize(const Size(432, 936));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(harness.buildTripPlanner());
    await tester.flushAsync();
    await tester.pumpAndSettle();
    await tester.fling(find.text('Plot'), const Offset(0, -100), 1000);
    await tester.pumpAndSettle();

    // An earlier version of the app used a Viewport to clip the map, which took
    // it offstage while occluded by the bottom sheet and may have been the root
    // cause for the map zooming in on web. Being offstage itself isn't
    // necessarily a bug though, so allow that.
    expect(tester.getTopLeft(find.byType(DraggableScrollableSheet)),
        tester.getTopLeft(find.byType(Map, skipOffstage: false)));

    await tester.tap(find.text('Plot'));
    await tester.pumpAndSettle();

    when(harness.filePicker.pickFiles(
      type: anyNamed('type'),
      allowedExtensions: anyNamed('allowedExtensions'),
      withData: true,
      allowMultiple: anyNamed('allowMultiple'),
    )).thenAnswer((_) async => FilePickerResult([kSfoGpxFile]));

    await tester.tap(find.text('Overlay GPX'));
    await tester.pumpAndSettle();

    expect(tester.widget<Map>(find.byType(Map, skipOffstage: false)).tracks,
        isNotEmpty);

    await tester.fling(find.text('Plot'), const Offset(0, 100), 1000);
    await tester.pumpAndSettle();

    expect(tester.state<MapState>(find.byType(Map)).cameraPosition.zoom,
        greaterThan(10));
  });
}
