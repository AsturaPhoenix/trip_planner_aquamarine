import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:motion_sensors/motion_sensors.dart';

class FakeMotionSensorsDriver {
  final isAbsoluteOrientationAvailable = Completer<bool>();
  final absoluteOrientation = StreamController<OrientationEvent>.broadcast();
  final screenOrientation =
      StreamController<ScreenOrientationEvent>.broadcast();
}

class FakeMotionSensors extends Fake implements MotionSensors {
  FakeMotionSensors([FakeMotionSensorsDriver? driver])
      : driver = driver ?? FakeMotionSensorsDriver();
  final FakeMotionSensorsDriver driver;

  @override
  isAbsoluteOrientationAvailable() =>
      driver.isAbsoluteOrientationAvailable.future;
  @override
  set absoluteOrientationUpdateInterval(_) {}
  @override
  get absoluteOrientation => driver.absoluteOrientation.stream;

  @override
  get screenOrientation => driver.screenOrientation.stream;
}
