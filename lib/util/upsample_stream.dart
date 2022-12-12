import 'dart:async';

import 'package:flutter/material.dart';
import 'package:joda/time.dart' show min;

import 'animation_coordinator.dart';

extension Upsample<T> on Stream<T> {
  Stream<T> upsample<Delta>({
    required TickerProvider tickerProvider,
    required T initialState,
    required T Function(T, Delta) applyDelta,
    required Delta Function(T after, T before) calculateDelta,
    required Delta Function(Delta, double t) lerp,
    Duration maxPeriod = AnimationCoordinator.defaultAnimationDuration,
    Curve blendAnimationCurve = Curves.easeInOut,
    DateTime Function() clock = DateTime.now,
  }) {
    late final StreamSubscription subscription;
    late final StreamController<T> controller;
    late final AnimationCoordinator<T, Delta> blender;
    DateTime? lastEventTime;

    controller = StreamController(
      onListen: () {
        final DateTime start = clock();
        blender = AnimationCoordinator<T, Delta>(
          tickerProvider: tickerProvider,
          initialState: initialState,
          applyDelta: applyDelta,
          calculateDelta: calculateDelta,
          lerp: lerp,
          setState: (state) => controller.add(state),
          clock: () => clock().difference(start),
        );

        subscription = listen((event) {
          final t = clock();
          final period = lastEventTime == null
              ? maxPeriod
              : min(t.difference(lastEventTime!), maxPeriod);
          blender.add(event, period, blendAnimationCurve);
          lastEventTime = t;
        });
      },
      onPause: () => subscription.pause(),
      onResume: () => subscription.resume(),
      onCancel: () {
        subscription.cancel();
        blender.ticker.stop(canceled: true);
      },
    );

    return controller.stream;
  }
}