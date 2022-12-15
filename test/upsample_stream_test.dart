import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:trip_planner_aquamarine/util/upsample_stream.dart';

@GenerateNiceMocks([MockSpec<Ticker>()])
import 'upsample_stream_test.mocks.dart';

class TestTickerProvider implements TickerProvider {
  late Ticker ticker;
  late TickerCallback onTick;

  @override
  Ticker createTicker(TickerCallback onTick) {
    this.onTick = onTick;
    return ticker;
  }
}

void main() {
  const frameTime = Duration(seconds: 1);
  var t = DateTime.now();
  DateTime? tickerStart;

  late TestTickerProvider tickerProvider;
  late MockTicker ticker;
  late StreamController<double> input;
  late Stream<double> output;

  late double? sample;
  late StreamSubscription subscription;

  setUp(() {
    tickerProvider = TestTickerProvider();
    input = StreamController<double>();
    output = input.stream.upsample<double>(
      tickerProvider: tickerProvider,
      initialState: 0,
      applyDelta: (state, delta) => state + delta,
      calculateDelta: (after, before) => after - before,
      lerp: (state, t) => state * t,
      blendAnimationCurve: Curves.linear,
      maxPeriod: const Duration(seconds: 5),
      clock: () => t,
    );

    ticker = MockTicker();
    tickerProvider.ticker = ticker;
    when(ticker.start()).thenAnswer((realInvocation) {
      tickerStart = t;
      return TickerFuture.complete();
    });
    when(ticker.stop()).thenAnswer((realInvocation) => tickerStart = null);
    subscription = output.listen((event) {
      expect(sample, null);
      sample = event;
    });
  });

  tearDown(() => subscription.cancel());

  Future<void> runMicrotasks() async {}

  Future<void> advanceTime(double frames) async {
    await runMicrotasks();
    t = t.add(frameTime * frames);
  }

  Future<double?> tick([double frames = 1]) async {
    await advanceTime(frames);
    sample = null;
    if (tickerStart != null) {
      tickerProvider.onTick(t.difference(tickerStart!));
      await runMicrotasks();
    }
    return sample;
  }

  test('Upsample with no updates is a no-op', () async {
    for (int i = 1; i <= 3; ++i) {
      expect(await tick(), null);
    }
  });

  test('Upsamples 1:2', () async {
    input.add(0);
    await tick(2);

    for (double i = 1; i <= 3; ++i) {
      input.add(i);
      expect(await tick(), i - .5);
      expect(await tick(), i);
    }
  });

  test('Upsamples 2:3', () async {
    input.add(0);
    await tick(1);
    await advanceTime(.5);

    input.add(1);
    expect(await tick(.5), 1 / 3);
    expect(await tick(1), 1);

    input.add(2);
    expect(await tick(1), 1 + 2 / 3);
    await advanceTime(.5);

    input.add(3);
    expect(await tick(.5), 2 + 1 / 3);
    expect(await tick(1), 3);
  });

  test('Passes through 1:1', () async {
    input.add(0);
    await tick();

    for (double i = 1; i <= 3; ++i) {
      input.add(i);
      expect(await tick(), i);
    }
  });

  test('Cleans up animations in progress', () async {
    input.add(1);
    await tick();
    subscription.cancel();
    verify(ticker.dispose());
  });
}
