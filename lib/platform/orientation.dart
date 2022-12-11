import 'dart:async';
import 'dart:math';

import 'package:motion_sensors/motion_sensors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vector_math/vector_math_64.dart';

set updateInterval(Duration interval) =>
    motionSensors.absoluteOrientationUpdateInterval = interval.inMicroseconds;

double degrees(double radians) => radians * 180 / pi;
double radians(double degrees) => degrees * pi / 180;

double yaw(Quaternion q) =>
    atan2(2 * (q.w * q.z + q.x * q.y), 1 - 2 * (q.y * q.y + q.z * q.z));

final screenOrientationAxis = Vector3(0, 0, -1);

double canonicalBearing(Quaternion q, double screenOrientation) => -degrees(
      yaw(
        q *
            Quaternion.axisAngle(
              screenOrientationAxis,
              radians(screenOrientation),
            ),
      ),
    );

Stream<double> bearing = Rx.combineLatest2(
  motionSensors.absoluteOrientation
      .map((orientation) => orientation.quaternion),
  motionSensors.screenOrientation
      .map((screenOrientation) => screenOrientation.angle),
  canonicalBearing,
).asBroadcastStream();
