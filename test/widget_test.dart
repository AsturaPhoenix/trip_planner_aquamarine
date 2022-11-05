import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:trip_planner_aquamarine/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TripPlanner());
    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
