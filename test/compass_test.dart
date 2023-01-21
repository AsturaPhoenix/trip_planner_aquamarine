import 'dart:math';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/test.dart';
import 'package:trip_planner_aquamarine/platform/orientation.dart';
import 'package:trip_planner_aquamarine/widgets/compass.dart';
import 'package:vector_math/vector_math_64.dart';

import 'util/vector_matcher.dart';

Matcher quaternionCloseTo(Quaternion value, num delta) => VectorIsCloseTo(
      value,
      delta,
      distance: (a, b) => (b - a).length,
      distanceSquared: (a, b) => (b - a).length2,
    );

void main() {
  test('Mercator lerp should work east across the 180 meridian', () {
    const start = LatLng(0, 179), end = LatLng(0, -179);
    final delta = mercatorSpace.calculateDelta(end, start);
    expect(delta, const Offset(2, 0));
    final midpoint =
        mercatorSpace.applyDelta(start, mercatorSpace.scaleDelta(delta, .5));
    expect(midpoint, const LatLng(0, 180));
  });

  test('Mercator lerp should work west across the 180 meridian', () {
    const start = LatLng(0, -179), end = LatLng(0, 179);
    final delta = mercatorSpace.calculateDelta(end, start);
    expect(delta, const Offset(-2, 0));
    final midpoint =
        mercatorSpace.applyDelta(start, mercatorSpace.scaleDelta(delta, .5));
    expect(midpoint, const LatLng(0, 180));
  });

  group('Decomposition strategies', () {
    final strategies = {
      'byYaw': (Quaternion q) =>
          Quaternion.axisAngle(Vector3(0, 0, 1), yaw(q).radians),
      'byMatrix': (Quaternion q) {
        final tx = 1 - 2 * (q.y * q.y + q.z * q.z),
            ty = 2 * (q.w * q.z + q.x * q.y);
        final cos = tx / sqrt(tx * tx + ty * ty);
        return Quaternion(
          0,
          0,
          ty.sign * sqrt((1 - cos) / 2),
          sqrt((1 + cos) / 2),
        );
      }
    };

    test('correctness', () {
      final random = Random();
      for (int i = 0; i < 1000; ++i) {
        final q = Quaternion.random(random);
        final ref = strategies.values.first(q);
        for (final strategy in strategies.entries) {
          expect(
            strategy.value(q),
            quaternionCloseTo(ref, .0001),
            reason: strategy.key,
          );
        }
      }
    });

    test('performance', () {
      for (final strategy in [...strategies.entries]..shuffle()) {
        final random = Random(0);
        final stopwatch = Stopwatch()..start();
        const iterations = 2000000;
        for (int i = 0; i < iterations; ++i) {
          strategy.value(Quaternion.random(random));
        }
        stopwatch.stop();
        print('${strategy.key}: '
            '${stopwatch.elapsedMicroseconds / iterations * 1000} ns/op');
      }
    });
  });
}
