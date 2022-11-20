import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';

import 'package:trip_planner_aquamarine/main.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';

@GenerateNiceMocks([MockSpec<TripPlannerClient>()])
import 'widget_test.mocks.dart';

void main() {
  setUp(setUpTestHive);
  tearDown(tearDownTestHive);

  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      TripPlanner(
        client: MockTripPlannerClient(),
        tileCache: await BlobCache.open('TileCache'),
      ),
    );
    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
