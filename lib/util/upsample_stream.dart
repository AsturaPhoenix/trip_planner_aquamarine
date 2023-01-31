import 'dart:async';

import 'package:flutter/material.dart';
import 'package:joda/time.dart' show min;

import 'animation_coordinator.dart';

extension Upsample<T> on Stream<T> {
  Stream<T> upsample<Delta>({
    required TickerProvider tickerProvider,
    required T initialState,
    StateSpace<T, Delta>? stateSpace,
    Duration maxPeriod = AnimationCoordinator.defaultAnimationDuration,
    Curve blendAnimationCurve = Curves.easeInOut,
    DateTime Function() clock = DateTime.now,
  }) {
    late final StreamSubscription subscription;
    late final StreamController<T> controller;
    late final AnimationCoordinator<T, Delta> blender;
    DateTime? lastEventTime;

    // Although it'd be conceivable to make this a broadcast controller from
    // here, let's avoid that since the animation controller initial state is
    // seeded only once at initialization by the caller.
    controller = StreamController(
      onListen: () {
        final DateTime start = clock();
        blender = AnimationCoordinator<T, Delta>(
          tickerProvider: tickerProvider,
          initialState: initialState,
          stateSpace: stateSpace,
          setState: controller.add,
          clock: () => clock().difference(start),
        );

        subscription = listen(
          (event) {
            final t = clock();
            final period = lastEventTime == null
                ? maxPeriod
                : min(t.difference(lastEventTime!), maxPeriod);
            blender.add(event, period, blendAnimationCurve);
            lastEventTime = t;
          },
          onDone: () async {
            await blender.flush();
            await controller.close();
          },
        );
      },
      onPause: () => subscription.pause(),
      onResume: () => subscription.resume(),
      onCancel: () {
        subscription.cancel();
        blender.dispose();
      },
    );

    return controller.stream;
  }

  Stream<T> skipBuffered() => Stream.multi((controller) {
        var skip = true;
        final skipTimer = Timer(Duration.zero, () => skip = false);
        controller.addStream(skipWhile((_) => skip));
        controller.onCancel = skipTimer.cancel;
      });
}
