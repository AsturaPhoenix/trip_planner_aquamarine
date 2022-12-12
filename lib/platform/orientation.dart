import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geomag/geomag.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vector_math/vector_math_64.dart';

Future<void> prefetchCapabilities() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    _isOrientationAvailable =
        await motionSensors.isAbsoluteOrientationAvailable();
  } on MissingPluginException {
    _isOrientationAvailable = false;
  }
}

bool get isOrientationAvailable => _isOrientationAvailable;
bool _isOrientationAvailable = false;

set updateInterval(Duration interval) =>
    motionSensors.absoluteOrientationUpdateInterval = interval.inMicroseconds;

double degrees(double radians) => radians * 180 / pi;
double radians(double degrees) => degrees * pi / 180;

double yaw(Quaternion q) =>
    atan2(2 * (q.w * q.z + q.x * q.y), 1 - 2 * (q.y * q.y + q.z * q.z));

final screenOrientationAxis = Vector3(0, 0, -1);

Quaternion calculateCanonicalOrientation(
  Quaternion q,
  double screenOrientation,
) =>
    q * Quaternion.axisAngle(screenOrientationAxis, radians(screenOrientation));

Stream<Quaternion> canonicalOrientation = Rx.combineLatest2(
  motionSensors.absoluteOrientation
      .map((orientation) => orientation.quaternion),
  motionSensors.screenOrientation
      .map((screenOrientation) => screenOrientation.angle),
  calculateCanonicalOrientation,
).asBroadcastStream();

double calculateBearing(Quaternion q) => -degrees(yaw(q));

Stream<double> bearing = canonicalOrientation.map(calculateBearing);

class CachingGeoMag {
  // These tolerances are semi arbitrary.
  static const latitudeTolerance = 1.0, longitudeTolerance = 1.0;
  static const feetPerMeter = 3.28084;

  CachingGeoMag([GeoMag? geomag]) : _geomag = geomag ?? GeoMag();
  final GeoMag _geomag;
  GeoMagResult? _geomagneticCorrection;
  double? _referenceLatitude, _referenceLongitude;

  GeoMagResult? get(
    double? latitude,
    double? longitude, [
    double altitude = 0,
    DateTime? time,
  ]) {
    if (latitude != null &&
        longitude != null &&
        (_geomagneticCorrection == null ||
            (latitude - _referenceLatitude!).abs() > latitudeTolerance ||
            (longitude - _referenceLongitude!).abs() > longitudeTolerance)) {
      _referenceLatitude = latitude;
      _referenceLongitude = longitude;
      _geomagneticCorrection =
          _geomag.calculate(latitude, longitude, altitude, time);
    }

    return _geomagneticCorrection;
  }

  GeoMagResult? getFromPosition(Position? position, [DateTime? time]) => get(
        position?.latitude,
        position?.longitude,
        (position?.altitude ?? 0) * feetPerMeter,
        time,
      );
}
