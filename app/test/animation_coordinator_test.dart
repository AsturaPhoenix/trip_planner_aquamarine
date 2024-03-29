import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:trip_planner_aquamarine/util/animation_coordinator.dart';
import 'package:trip_planner_aquamarine/widgets/compass.dart';
import 'package:vector_math/vector_math_64.dart';

@GenerateNiceMocks([MockSpec<Ticker>()])
import 'animation_coordinator_test.mocks.dart';
import 'util/vector_matcher.dart';

class TestTickerProvider implements TickerProvider {
  late Ticker ticker;
  late TickerCallback onTick;

  @override
  Ticker createTicker(TickerCallback onTick) {
    this.onTick = onTick;
    return ticker;
  }
}

Matcher vectorCloseTo(Vector3 value, num delta) => VectorIsCloseTo(
      value,
      delta,
      distance: (a, b) => a.distanceTo(b),
      distanceSquared: (a, b) => a.distanceToSquared(b),
    );

void main() {
  const frameTime = Duration(seconds: 1);
  late Duration t;

  late TestTickerProvider tickerProvider;
  late MockTicker ticker;

  setUp(() {
    tickerProvider = TestTickerProvider();

    ticker = MockTicker();
    tickerProvider.ticker = ticker;
    when(ticker.start()).thenAnswer((realInvocation) {
      t = Duration.zero;
      return TickerFuture.complete();
    });
  });

  void tick([double frames = 1]) {
    t += frameTime * frames;
    tickerProvider.onTick(t);
  }

  test(
      'can use a quaternion space that interpolates over the shortest '
      'equivalent distance', () {
    late Quaternion state;
    final animator = AnimationCoordinator(
      tickerProvider: tickerProvider,
      initialState: Quaternion.identity(),
      stateSpace: quaternionNlerp,
      setState: (value) => state = value,
      clock: () => t,
    );
    addTearDown(() => animator.dispose());

    const epsilon = .0001;

    animator.add(
      Quaternion.axisAngle(Vector3(0, 0, -1), 7 * pi / 4),
      frameTime * 2,
      Curves.linear,
    );
    tick();
    expect(state.axis, vectorCloseTo(Vector3(0, 0, 1), epsilon));
    expect(state.radians, closeTo(pi / 8, epsilon));

    animator.add(
      Quaternion.axisAngle(Vector3(0, 0, 1), pi / 2),
      frameTime * 2,
      Curves.linear,
    );
    tick();
    expect(state.axis, vectorCloseTo(Vector3(0, 0, 1), epsilon));
    expect(state.radians, closeTo(3 * pi / 8, epsilon));

    tick();
    expect(state.axis, vectorCloseTo(Vector3(0, 0, 1), epsilon));
    expect(state.radians, closeTo(pi / 2, epsilon));
  });

  test('set interrupts ongoing animations', () {
    late double state;
    final animator = AnimationCoordinator(
      tickerProvider: tickerProvider,
      initialState: 0.0,
      setState: (value) => state = value,
      clock: () => t,
    );
    addTearDown(() => animator.dispose());

    animator.add(1.0, frameTime * 2, Curves.linear);
    tick();
    expect(state, .5);

    animator.set(0.0, frameTime * 2, Curves.linear);
    tick();
    expect(state, .25);
    tick();
    expect(state, 0.0);
    expect(animator.isActive, false);
  });
}
