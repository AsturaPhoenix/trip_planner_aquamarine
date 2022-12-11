import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geomag/geomag.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vector_math/vector_math_64.dart';

import '../util/optional.dart';

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

class WithSpaceTime<T> {
  static const feetPerMeter = 3.28084;
  WithSpaceTime(
    this.value, {
    this.latitude,
    this.longitude,
    this.altitude,
    this.time,
  });
  WithSpaceTime.fromPosition(this.value, Position? position, {this.time})
      : latitude = position?.latitude,
        longitude = position?.longitude,
        altitude = Optional(position)
            .map((position) => position.altitude * feetPerMeter);
  final T value;
  final double? latitude, longitude;

  /// Altitude in feet.
  final double? altitude;
  final DateTime? time;
}

Stream<WithSpaceTime<T>> wrapWithPositionFunction<T>(
  Stream<T> stream,
  Position? Function() getPosition,
) =>
    stream.map((e) => WithSpaceTime.fromPosition(e, getPosition()));

class WithGeomagneticCorrection<T> {
  WithGeomagneticCorrection(this.value, this.geomagneticCorrection);
  final T value;
  final GeoMagResult? geomagneticCorrection;
}

final geomag = GeoMag();

Stream<WithGeomagneticCorrection<T>> withGeomagneticCorrection<T>(
  Stream<WithSpaceTime<T>> stream,
) {
  // These tolerances are semi arbitrary.
  const latitudeTolerance = 1.0, longitudeTolerance = 1.0;

  GeoMagResult? geomagneticCorrection;
  double? referenceLatitude, referenceLongitude;
  return stream.map((e) {
    if (e.latitude != null &&
        e.longitude != null &&
        (geomagneticCorrection == null ||
            (e.latitude! - referenceLatitude!).abs() > latitudeTolerance ||
            (e.longitude! - referenceLongitude!).abs() > longitudeTolerance)) {
      referenceLatitude = e.latitude;
      referenceLongitude = e.longitude;
      geomagneticCorrection =
          geomag.calculate(e.latitude!, e.longitude!, e.altitude ?? 0, e.time);
    }

    return WithGeomagneticCorrection(e.value, geomagneticCorrection);
  });
}
