import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

const Duration kFrame = Duration(microseconds: 100000 ~/ 6);

/// The emulator in CI can be extremely slow, even with hardware acceleration.
/// It can take upwards of 10s just for Maps to load. Maybe a minute for the
/// permissions dialog to show up.
const kDefaultTimeout = Duration(minutes: 2);

extension TestExtensions<T> on StreamController<T> {
  void seed(T value) => onListen = () => add(value);
}

extension TesterAsync on WidgetTester {
  /// For some reason, nontrivial streams tend to require real asyncs. There are
  /// numerous possible related issues, e.g. dart-lang/sdk#40131
  Future<void> flushAsync() async => runAsync(() async {});

  Future<void> pumpWhile(
    bool Function() predicate, {
    Duration interval = kFrame,
    Duration timeout = kDefaultTimeout,
    String diagnostic = 'pumpWhile',
  }) async {
    final end = binding.clock.fromNowBy(timeout);
    while (predicate()) {
      if (!binding.clock.now().isBefore(end)) {
        throw TimeoutException('$diagnostic timed out after $timeout');
      }
      await pump(interval);
    }
  }

  Future<void> waitFor(
    Finder finder, {
    Duration interval = kFrame,
    Duration timeout = kDefaultTimeout,
  }) =>
      pumpWhile(
        () => finder.evaluate().isEmpty,
        interval: interval,
        timeout: timeout,
        diagnostic: 'waitFor $finder',
      );

  Future<void> pumpUntil(
    Future future, {
    Duration interval = kFrame,
    Duration timeout = kDefaultTimeout,
  }) async {
    var pending = true;
    future.then((_) => pending = false);
    await pumpWhile(
      () => pending,
      interval: interval,
      timeout: timeout,
      diagnostic: 'pumpUntil',
    );
  }

  Future<void> pumpFor(
    Duration duration, {
    Duration interval = kFrame,
  }) async {
    final end = binding.clock.fromNowBy(duration);
    while (binding.clock.now().isBefore(end)) {
      await pump(interval);
    }
  }
}
