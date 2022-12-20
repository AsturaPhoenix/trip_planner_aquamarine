import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/test.dart';
import 'package:trip_planner_aquamarine/widgets/compass.dart';

void main() {
  test('Mercator lerp should work east across the 180 meridian', () {
    const start = LatLng(0, 179), end = LatLng(0, -179);
    final delta = mercatorSpace.calculateDelta(end, start);
    expect(delta, const Offset(2, 0));
    final midpoint =
        mercatorSpace.applyDelta(start, mercatorSpace.lerp(delta, .5));
    expect(midpoint, const LatLng(0, 180));
  });

  test('Mercator lerp should work west across the 180 meridian', () {
    const start = LatLng(0, -179), end = LatLng(0, 179);
    final delta = mercatorSpace.calculateDelta(end, start);
    expect(delta, const Offset(-2, 0));
    final midpoint =
        mercatorSpace.applyDelta(start, mercatorSpace.lerp(delta, .5));
    expect(midpoint, const LatLng(0, 180));
  });
}
