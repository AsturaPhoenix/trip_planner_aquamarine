import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class _Animation<T> {
  _Animation({
    required this.delta,
    required this.start,
    required this.length,
    required this.curve,
  });
  final T delta;
  final Duration start, length;
  Duration get end => start + length;
  final Curve curve;
  final completer = Completer<bool>();

  double normalize(Duration t) => t < start
      ? 0
      : t >= end
          ? 1
          : (t - start).inMicroseconds / length.inMicroseconds;

  double parameterize(Duration t) => curve.transform(normalize(t));
}

class StateSpace<State, Delta> {
  const StateSpace({
    required this.applyDelta,
    required this.calculateDelta,
    required this.lerp,
  });
  final State Function(State state, Delta delta) applyDelta;
  final Delta Function(State after, State before) calculateDelta;
  final Delta Function(Delta delta, double t) lerp;
}

class AnimationCoordinator<State, Delta> {
  static const defaultAnimationDuration = Duration(milliseconds: 600);

  AnimationCoordinator({
    required TickerProvider tickerProvider,
    required State initialState,
    required this.stateSpace,
    this.setState,
    this.clock,
  })  : _basis = initialState,
        _target = initialState {
    ticker = tickerProvider.createTicker(_onTick);
  }
  late final Ticker ticker;
  final StateSpace<State, Delta> stateSpace;
  void Function(State)? setState;

  /// A real-time mapping supports use cases like upsampling, which require
  /// continuous timestamps between frames. If this is not provided, frame-time
  /// is used and animations added between frames are treated as having started
  /// at the most recent available frame time.
  //
  // Exact animation timings with respect to frame and real time may vary from
  // frame to frame, so motion may not be smooth. However, this is probably the
  // best we can do without much more complicated logic. If we attempt to map
  // using a uniform offset calculated at the first frame, we can run into cases
  // where frame time is suspended for a while, such as when the screen is off,
  // and end with an incorrect offset that suspends animation.
  Duration Function()? clock;

  State get target => _target;
  State _basis, _target;
  Duration? get t => clock?.call() ?? _tickerTime;
  Duration? _tickerTime;

  bool get isActive => ticker.isActive;
  final animations = Queue<_Animation<Delta>>();

  void _start() {
    ticker.start();
    _tickerTime = Duration.zero;
  }

  Future<bool> addDelta(
    Delta delta, [
    Duration length = defaultAnimationDuration,
    Curve curve = Curves.easeInOut,
  ]) {
    if (animations.isEmpty) {
      _start();
    }

    final animation = _Animation(
      delta: delta,
      start: t!,
      length: length,
      curve: curve,
    );
    animations.add(animation);

    _target = stateSpace.applyDelta(_target, delta);
    return animation.completer.future;
  }

  Future<bool> add(
    State target, [
    Duration length = defaultAnimationDuration,
    Curve curve = Curves.easeInOut,
  ]) {
    if (animations.isEmpty) {
      _start();
    }

    final animation = _Animation(
      delta: stateSpace.calculateDelta(target, _target),
      start: t!,
      length: length,
      curve: curve,
    );
    animations.add(animation);

    _target = target;
    return animation.completer.future;
  }

  Future<bool> set(
    State target, [
    Duration length = defaultAnimationDuration,
    Curve curve = Curves.easeInOut,
  ]) {
    if (animations.isEmpty) {
      _start();
    }

    final animation = _Animation(
      delta: stateSpace.calculateDelta(target, _target),
      start: t!,
      length: length,
      curve: curve,
    );
    animations
      ..clear()
      ..add(animation);

    _target = target;
    return animation.completer.future;
  }

  void _onTick(Duration tickerTime) {
    _tickerTime = tickerTime;

    while (animations.isNotEmpty && t! >= animations.first.end) {
      final animation = animations.removeFirst();
      _basis = stateSpace.applyDelta(_basis, animation.delta);
      if (!animation.completer.isCompleted) {
        animation.completer.complete(true);
      }
    }
    var state = _basis;
    for (final animation in animations) {
      // We need to apply all animations, including completed animations, in
      // order to handle the case of animations with non-commutative effects
      // like 3-space rotations.
      state = stateSpace.applyDelta(
        state,
        stateSpace.lerp(animation.delta, animation.parameterize(t!)),
      );
      if (t! >= animation.end && !animation.completer.isCompleted) {
        animation.completer.complete(true);
      }
    }
    setState?.call(state);
    if (animations.isEmpty) {
      ticker.stop();
    }
  }

  void override(State override) {
    ticker.stop(canceled: true);
    _basis = _target = override;
    for (final animation in animations) {
      if (!animation.completer.isCompleted) {
        animation.completer.complete(false);
      }
    }
    animations.clear();
  }
}
