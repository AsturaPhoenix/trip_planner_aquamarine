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
  static StateSpace<State, Delta> defaultOperators<State, Delta>() =>
      StateSpace(
        applyDelta: (dynamic state, delta) => state + delta as State,
        calculateDelta: (dynamic after, before) => after - before as Delta,
        scaleDelta: (dynamic delta, t) => delta * t as Delta,
      );

  const StateSpace({
    required this.applyDelta,
    required this.calculateDelta,
    required this.scaleDelta,
  });
  final State Function(State state, Delta delta) applyDelta;
  final Delta Function(State after, State before) calculateDelta;
  final Delta Function(Delta delta, double t) scaleDelta;

  State lerp(State a, State b, double t) =>
      applyDelta(a, scaleDelta(calculateDelta(b, a), t));
}

class SkippableDelta<State, Delta> {
  SkippableDelta.skip(State state)
      : skip = true,
        _deltaOrState = state;
  SkippableDelta.delta(Delta delta)
      : skip = false,
        _deltaOrState = delta;
  bool skip;
  final dynamic _deltaOrState;
  State get state => _deltaOrState as State;
  Delta get delta => _deltaOrState as Delta;
}

extension NullableStateSpace<State extends Object, Delta extends Object>
    on StateSpace<State, Delta> {
  /// Handles nulls as immediate transitions.
  StateSpace<State?, SkippableDelta<State?, Delta>> sharpNulls() => StateSpace(
        applyDelta: (state, delta) =>
            delta.skip ? delta.state : applyDelta(state!, delta.delta),
        calculateDelta: (after, before) => after == null || before == null
            ? SkippableDelta.skip(after)
            : SkippableDelta.delta(calculateDelta(after, before)),
        scaleDelta: (delta, t) => delta.skip
            ? delta
            : SkippableDelta.delta(scaleDelta(delta.delta, t)),
      );
}

class AnimationCoordinator<State, Delta> {
  static const defaultAnimationDuration = Duration(milliseconds: 600);

  AnimationCoordinator({
    required TickerProvider tickerProvider,
    required State initialState,
    StateSpace<State, Delta>? stateSpace,
    this.setState,
    this.clock,
  })  : _basis = initialState,
        _target = initialState,
        stateSpace = stateSpace ?? StateSpace.defaultOperators() {
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

  TickerFuture? _tickerFuture;
  State get target => _target;
  State _basis, _target;
  Duration? get t => clock?.call() ?? _tickerTime;
  Duration? _tickerTime;

  bool get isActive => ticker.isActive;
  final animations = Queue<_Animation<Delta>>();

  void dispose() => ticker.dispose();

  void _start() {
    _tickerFuture = ticker.start();
    _tickerTime = Duration.zero;
  }

  /// Returns a future that completes when pending animations are complete, or
  /// if the coordinator is disposed.
  Future<void> flush() async => await _tickerFuture?.orCancel;

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

  /// Adds an animation to any in-progress animations so that once the
  /// animations have completed, the state is the [target] state.
  Future<bool> add(
    State target, [
    Duration length = defaultAnimationDuration,
    Curve curve = Curves.easeInOut,
  ]) =>
      // Although it's tempting to set _target = target instead of applying the
      // delta, doing so risks setting a target outside the domain of the state
      // space, which can for example result in backwards deltas for things like
      // quaternion nlerp if _target ends up on the opposite side of the
      // hypersphere from _basis.
      addDelta(stateSpace.calculateDelta(target, _target), length, curve);

  /// Replaces any ongoing animations with an animation to the [target] state.
  Future<bool> set(
    State target, [
    Duration length = defaultAnimationDuration,
    Curve curve = Curves.easeInOut,
  ]) {
    if (animations.isEmpty) {
      _start();
    } else {
      _basis = _target = _evaluate();
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

    // See comment re: _target in [add].
    _target = stateSpace.applyDelta(_target, animation.delta);
    return animation.completer.future;
  }

  /// Pops any completed animations and evaluates all in-progress animations.
  State _evaluate() {
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
        stateSpace.scaleDelta(animation.delta, animation.parameterize(t!)),
      );
      if (t! >= animation.end && !animation.completer.isCompleted) {
        animation.completer.complete(true);
      }
    }

    return state;
  }

  void _onTick(Duration tickerTime) {
    _tickerTime = tickerTime;

    setState?.call(_evaluate());

    if (animations.isEmpty) {
      ticker.stop();
      _basis = _target;
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
