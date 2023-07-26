import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlng/latlng.dart';
import 'package:mockito/mockito.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:trip_planner_aquamarine/platform/orientation.dart';
import 'package:trip_planner_aquamarine/util/distance.dart';
import 'package:trip_planner_aquamarine/widgets/compass.dart';
import 'package:vector_math/vector_math_64.dart';

import 'util/async.dart';
import 'util/harness.dart';
import 'util/vector_matcher.dart';

Matcher quaternionCloseTo(Quaternion value, num delta) => VectorIsCloseTo(
      value,
      delta,
      distance: (a, b) => (b - a).length,
      distanceSquared: (a, b) => (b - a).length2,
    );

class CompassHarness extends StatelessWidget {
  CompassHarness({
    super.key,
    required this.harness,
    DistanceSystem distanceSystem = DistanceSystem.nauticalMiles,
  }) : distanceSystem = ValueNotifier(distanceSystem);
  final TripPlannerHarness harness;
  final ValueNotifier<DistanceSystem> distanceSystem;

  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: Compass(distanceSystem: distanceSystem));
}

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

  group('decomposition strategies', () {
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

  group('widget tests', () {
    late TripPlannerHarness harness;

    setUpAll(TripPlannerHarness.setUpAll);
    setUp(() {
      harness = TripPlannerHarness();
      harness.setUp(isAbsoluteOrientationAvailable: true);

      WidgetsBinding.instance
          .handleAppLifecycleStateChanged(AppLifecycleState.resumed);

      // TODO(AsturaPhoenix): Make the compass widget more robust at smaller
      // sizes.
      final window = TestWidgetsFlutterBinding.instance.window;
      window.physicalSizeTestValue =
          const Size(1080, 2340) * window.devicePixelRatio;
    });

    testWidgets('smoke test', (tester) async {
      await tester.pumpWidget(CompassHarness(harness: harness));
      // flutter/flutter#125849
      await tester.pumpWidget(const SizedBox());
      await tester.flushAsync();
    });

    testWidgets('smoke test with camera query that does not complete',
        (tester) async {
      when(harness.camera.availableCameras())
          .thenAnswer((_) => Completer<List<CameraDescription>>().future);
      await tester.pumpWidget(CompassHarness(harness: harness));
      await tester.pump(Duration.zero);
    });

    group('with location and vertical orientation', () {
      const cameraDescription = CameraDescription(
          name: 'foo',
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 0);

      // The compass animates to a tilted position, and it won't start the
      // camera until the animation crosses a threshold.
      const animationDelay = Duration(seconds: 1);
      final orientationEvent = OrientationEvent(Quaternion.euler(0, pi / 2, 0));

      setUp(() => harness
          .withLocation()
          .seed(TripPlannerHarness.horseshoeBayParkingLot));

      testWidgets('shows spinner while waiting for camera', (tester) async {
        when(harness.camera.availableCameras())
            .thenAnswer((_) async => const [cameraDescription]);
        when(harness.camera
                .createCamera(cameraDescription, any, enableAudio: false))
            .thenAnswer((_) => Completer<int>().future);
        final orientation = harness.withOrientation();

        await tester.pumpWidget(CompassHarness(harness: harness));
        await tester.pump(Duration.zero); // get past skipBuffered
        orientation.add(orientationEvent);
        await tester.pump(animationDelay);
        // Pump another frame to settle camera initialization.
        await tester.pump();
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('does not show spinner when there is no camera',
          (tester) async {
        final orientation = harness.withOrientation();

        await tester.pumpWidget(CompassHarness(harness: harness));
        await tester.pump(Duration.zero); // get past skipBuffered
        orientation.add(orientationEvent);
        await tester.pump(animationDelay);
        // Pump another frame to settle camera initialization.
        await tester.pump();
        expect(find.byType(CircularProgressIndicator), findsNothing);
      });

      testWidgets('does not show spinner when camera permissions were denied',
          (tester) async {
        when(harness.camera.availableCameras())
            .thenAnswer((_) async => const [cameraDescription]);
        when(harness.camera
                .createCamera(cameraDescription, any, enableAudio: false))
            .thenAnswer((_) => Future.error(CameraException('', null)));
        final orientation = harness.withOrientation();

        await tester.pumpWidget(CompassHarness(harness: harness));
        await tester.pump(Duration.zero); // get past skipBuffered
        orientation.add(orientationEvent);
        await tester.pump(animationDelay);
        // Pump another frame to settle camera initialization.
        await tester.pump();
        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
    });
  });
}
