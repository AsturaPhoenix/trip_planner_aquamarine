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
    while (finder.evaluate().isEmpty && binding.clock.now().isBefore(end)) {
      await pump(interval);
    }
  }

  Future<void> pumpUntil(
    Future future, {
    Duration interval = kFrame,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    var end = binding.clock.fromNowBy(timeout);
    future.then((_) => end = binding.clock.now());
    while (binding.clock.now().isBefore(end)) {
      await pump(interval);
    }
  }
}
