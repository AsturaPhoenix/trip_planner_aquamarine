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

class TestTickerProvider implements TickerProvider {
  late Ticker ticker;
  late TickerCallback onTick;

  @override
  Ticker createTicker(TickerCallback onTick) {
    this.onTick = onTick;
    return ticker;
  }
}

Matcher vectorCloseTo(Vector3 value, num delta) =>
    _VectorIsCloseTo(value, delta);

class _VectorIsCloseTo extends TypeMatcher<Vector3> {
  const _VectorIsCloseTo(this._value, this._delta);
  final Vector3 _value;
  final num _delta;

  @override
  bool matches(dynamic item, Map matchState) =>
      super.matches(item, matchState) &&
      _value.distanceToSquared(item as Vector3) <= _delta * _delta;

  @override
  Description describe(Description description) => description
      .add('a vector within ')
      .addDescriptionOf(_delta)
      .add(' of ')
      .addDescriptionOf(_value);

  @override
  Description describeMismatch(
    Object? item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    if (item is Vector3) {
      return mismatchDescription
          .add(' differs by ')
          .addDescriptionOf(_value.distanceTo(item));
    }

    return super.describe(mismatchDescription.add('not an '));
  }
}

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
}
