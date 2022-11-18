import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';

import 'package:trip_planner_aquamarine/main.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';

@GenerateNiceMocks([MockSpec<TripPlannerClient>()])
import 'widget_test.mocks.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(TripPlanner(client: MockTripPlannerClient()));
    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
