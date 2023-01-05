import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/test.dart';
import 'package:trip_planner_aquamarine/util/latlngbounds.dart';

void main() {
  test('Empty expand inits', () {
    const pt = LatLng(0, 0);
    expect(null.expand(pt), LatLngBounds(southwest: pt, northeast: pt));
  });

  test('Expand northwest from origin', () {
    const start = LatLng(0, 0);
    expect(
      LatLngBounds(southwest: start, northeast: start)
          .expand(const LatLng(45, -90)),
      LatLngBounds(
        southwest: const LatLng(0, -90),
        northeast: const LatLng(45, 0),
      ),
    );
  });

  test('Expand southeast from antipode', () {
    const start = LatLng(0, 180);
    expect(
      LatLngBounds(southwest: start, northeast: start)
          .expand(const LatLng(-45, -90)),
      LatLngBounds(
        southwest: const LatLng(-45, 180),
        northeast: const LatLng(0, -90),
      ),
    );
  });

  test('Expand antipode', () {
    const start = LatLng(0, 0), pt = LatLng(0, 180);
    final expanded =
        LatLngBounds(southwest: start, northeast: start).expand(pt);
    expect(expanded.contains(start), isTrue);
    expect(expanded.contains(pt), isTrue);
    expect(
      (expanded.northeast.longitude - expanded.southwest.longitude) % 360,
      180,
    );
  });

  test('Contained noops', () {
    final bounds = LatLngBounds(
      southwest: const LatLng(-45, 90),
      northeast: const LatLng(45, -90),
    );
    final expanded = bounds.expand(const LatLng(0, 180));
    expect(expanded, bounds);
  });
}
