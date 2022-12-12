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

class AnimationCoordinator<State, Delta> {
  static const defaultAnimationDuration = Duration(milliseconds: 600);

  AnimationCoordinator({
    required TickerProvider tickerProvider,
    required State initialState,
    required this.applyDelta,
    required this.calculateDelta,
    required this.lerp,
    this.setState,
    this.clock,
  })  : _basis = initialState,
        _target = initialState {
    ticker = tickerProvider.createTicker(_onTick);
  }
  late final Ticker ticker;
  State Function(State, Delta) applyDelta;
  Delta Function(State after, State before) calculateDelta;
  Delta Function(Delta, double t) lerp;
  void Function(State)? setState;

  /// A real-time mapping supports use cases like upsampling, which require
  /// continuous timestamps between frames. If this is not provided, frame-time
  /// is used and animations added between frames are treated as having started
  /// at the most recent available frame time.
  Duration Function()? clock;

  State get target => _target;
  State _basis, _target;
  Duration? get t => clock?.call() ?? _tickerTime;
  Duration? _tickerTime, _tickerTimeOffset;

  bool get isActive => ticker.isActive;
  final animations = Queue<_Animation<Delta>>();

  void _start() {
    ticker.start();
    _tickerTime = Duration.zero;
    _tickerTimeOffset = null;
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

    _target = applyDelta(_target, delta);
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
      delta: calculateDelta(target, _target),
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
      delta: calculateDelta(target, _target),
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
    // To honor vsync, if there's a real-time mapping, use a uniform offset from
    // real time based on frame time.
    _tickerTimeOffset ??= this.t! - tickerTime;
    final t = tickerTime + _tickerTimeOffset!;

    while (animations.isNotEmpty && t >= animations.first.end) {
      final animation = animations.removeFirst();
      _basis = applyDelta(_basis, animation.delta);
      if (!animation.completer.isCompleted) {
        animation.completer.complete(true);
      }
    }
    var state = _basis;
    for (final animation in animations) {
      // We need to apply all animations, including completed animations, in
      // order to handle the case of animations with non-commutative effects
      // like 3-space rotations.
      state =
          applyDelta(state, lerp(animation.delta, animation.parameterize(t)));
      if (t >= animation.end && !animation.completer.isCompleted) {
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
