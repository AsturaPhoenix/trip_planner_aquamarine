import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geomag/geomag.dart';
import 'package:motion_sensors/motion_sensors.dart' as platform;
import 'package:vector_math/vector_math_64.dart';

import '../util/angle.dart';
import '../util/optional.dart';
import '../util/value_stream.dart';

platform.MotionSensors motionSensors = platform.motionSensors;

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

extension QuaternionTransform on Quaternion {
  Matrix4 asTransform() => Matrix4.identity()..setRotation(asRotationMatrix());
}

Angle yaw(Quaternion q) => Radians(
      atan2(2 * (q.w * q.z + q.x * q.y), 1 - 2 * (q.y * q.y + q.z * q.z)),
    );

final screenOrientationAxis = Vector3(0, 0, -1);

Quaternion calculateCanonicalOrientation(
  Quaternion q,
  Angle screenOrientation,
) =>
    q * Quaternion.axisAngle(screenOrientationAxis, screenOrientation.radians);

// Motion sensors don't re-emit their most recent value on resubscribe, so we
// need to cache the screen orientation ourselves so that we can unsubscribe
// from the orientation sensors when not in use. Otherwise, we won't be able to
// compute orientation until the next screen rotation. Don't cache the
// orientation itself as that will be quite stale, will refresh quickly, and
// we'll be caching the computed canonical orientation anyway.
final screenOrientation = ValueStream.fromStream(
  motionSensors.screenOrientation
      .map((screenOrientation) => Degrees(screenOrientation.angle)),
);

final canonicalOrientation = CombinedValueStream(
  ValueStream.fromStream(
    motionSensors.absoluteOrientation.map(
      (orientation) => orientation.quaternion,
    ),
  ),
  screenOrientation,
  calculateCanonicalOrientation,
);

final ValueStream<Angle> bearing = canonicalOrientation.map((q) => -yaw(q));

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

const _accuracyApproximations = [
  Degrees(90), // low
  Degrees(30), // medium
  Degrees(15), // high
];

final ValueStream<Angle?> accuracy = ValueStream.fromStream<Angle?>(
  motionSensors.absoluteOrientation
      .map((event) => event.accuracy)
      .distinct()
      .map(
        (accuracy) => (accuracy ?? 0) >= 0
            ? Optional(accuracy).map(Radians.new)
            : _accuracyApproximations[-accuracy!.toInt() - 1],
      ),
);
