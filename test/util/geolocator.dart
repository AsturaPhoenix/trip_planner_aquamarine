import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const kHorseshoeBayParkingLot = Position(
  latitude: 37.833861,
  longitude: -122.476934,
  timestamp: null,
  accuracy: 0.0,
  altitude: 0.0,
  heading: 0.0,
  speed: 0.0,
  speedAccuracy: 0.0,
);

Position testPosition(LatLng latLng) => Position(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      timestamp: null,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );

class FakeGeolocator extends Fake
    with MockPlatformInterfaceMixin
    implements GeolocatorPlatform {
  final position = StreamController<Position>.broadcast();

  @override
  getPositionStream({LocationSettings? locationSettings}) => position.stream;
}
