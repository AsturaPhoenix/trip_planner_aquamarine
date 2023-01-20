import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

const Duration kFrame = Duration(microseconds: 100000 ~/ 6);

extension TestExtensions<T> on StreamController<T> {
  void seed(T value) => onListen = () => add(value);
}

extension TesterAsync on WidgetTester {
  Future<void> waitFor(
    Finder finder, {
    Duration interval = kFrame,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final end = binding.clock.fromNowBy(timeout);
    while (finder.evaluate().isEmpty) {
      if (!binding.clock.now().isBefore(end)) {
        throw TimeoutException('waitFor timed out');
      }
      await pump(interval);
    }
  }

  Future<void> pumpUntil(
    Future future, {
    Duration interval = kFrame,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final end = binding.clock.fromNowBy(timeout);
    var pending = true;
    future.then((_) => pending = false);
    while (pending) {
      if (!binding.clock.now().isBefore(end)) {
        throw TimeoutException('pumpUntil timed out');
      }
      await pump(interval);
    }
  }
}
