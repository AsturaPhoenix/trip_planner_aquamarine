import 'dart:ui';

import 'package:geomag/geomag.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:trip_planner_aquamarine/platform/orientation.dart';
import 'package:trip_planner_aquamarine/widgets/map.dart';

@GenerateNiceMocks([MockSpec<GeoMag>()])
import 'orientation_test.mocks.dart';

class FakeGeoMagResult extends Fake implements GeoMagResult {
  FakeGeoMagResult();
}

void main() {
  test('caching geomag caches at an appropriate resolution', () {
    const maxAllowedVariation = 1 / 60;

    const earthCircumference = 4.0075e7;
    print('Current caching resolution: '
        '${CachingGeoMag.degreesTolerance / 360 * earthCircumference}m');

    final geomag = GeoMag();

    for (final testLocation in [
      Map.initialCameraPosition.target,
      const LatLng(90, 0),
      const LatLng(-90, 0)
    ]) {
      final reference =
          geomag.calculate(testLocation.latitude, testLocation.longitude).dec;
      for (final offset in const [
        Offset(0, 1),
        Offset(1, 0),
        Offset(0, -1),
        Offset(-1, 0)
      ]) {
        expect(
            geomag
                .calculate(
                    testLocation.latitude +
                        CachingGeoMag.degreesTolerance * offset.dx,
                    testLocation.longitude +
                        CachingGeoMag.degreesTolerance * offset.dy)
                .dec,
            closeTo(reference, maxAllowedVariation));
      }
    }
  });

  test('caching geomag outside tolerance', () {
    final mockGeomag = MockGeoMag();
    final cachingGeomag = CachingGeoMag(mockGeomag);

    var testLocation = Map.initialCameraPosition.target;
    var geomagResult = FakeGeoMagResult();
    when(mockGeomag.calculate(testLocation.latitude, testLocation.longitude))
        .thenReturn(geomagResult);
    expect(cachingGeomag.get(testLocation.latitude, testLocation.longitude),
        geomagResult);

    testLocation = LatLng(
        testLocation.latitude + CachingGeoMag.degreesTolerance * 1.1,
        testLocation.longitude);
    geomagResult = FakeGeoMagResult();
    when(mockGeomag.calculate(testLocation.latitude, testLocation.longitude))
        .thenReturn(geomagResult);
    expect(cachingGeomag.get(testLocation.latitude, testLocation.longitude),
        geomagResult);
  });

  test('caching geomag within tolerance', () {
    final mockGeomag = MockGeoMag();
    final cachingGeomag = CachingGeoMag(mockGeomag);

    var testLocation = Map.initialCameraPosition.target;
    var geomagResult = FakeGeoMagResult();
    when(mockGeomag.calculate(testLocation.latitude, testLocation.longitude))
        .thenReturn(geomagResult);
    expect(cachingGeomag.get(testLocation.latitude, testLocation.longitude),
        geomagResult);

    testLocation = LatLng(
        testLocation.latitude + CachingGeoMag.degreesTolerance * .9,
        testLocation.longitude);
    when(mockGeomag.calculate(testLocation.latitude, testLocation.longitude))
        .thenReturn(FakeGeoMagResult());
    expect(cachingGeomag.get(testLocation.latitude, testLocation.longitude),
        geomagResult);
  });
}
