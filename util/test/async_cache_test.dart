import 'dart:async';

import 'package:aquamarine_util/async.dart';
import 'package:test/test.dart';

void main() {
  group('can add sync futures', () {
    test('for single', () async {
      final cache = AsyncCache<int, int>.single();
      expect(await cache.computeIfAbsent(0, () => Future.value(0)), 0);
    });

    test('for ephemeral', () async {
      int calls = 0;
      final cache = AsyncCache<int, int>.ephemeral();
      Future<int> op() => Future.value(++calls);
      expect(await cache.computeIfAbsent(0, op), 1);
      expect(await cache.computeIfAbsent(0, op), 2);
    });
  });

  group('replaced operation does not remove replacement', () {
    test('for single', () async {
      final cache = AsyncCache<int, void>.single();
      final oldOperation = Completer<void>();

      final oldFuture = cache.computeIfAbsent(0, () => oldOperation.future);
      cache.computeIfAbsent(1, () => Completer().future);

      oldOperation.completeError(Exception('test exception'));
      await expectLater(oldFuture, throwsA(isA<Exception>()));

      expect(cache.containsKey(1), isTrue);
    });

    test('for ephemeral', () async {
      final cache = AsyncCache<int, void>.ephemeral();
      final oldOperation = Completer<void>(), newOperation = Completer<void>();

      final oldFuture = cache.computeIfAbsent(0, () => oldOperation.future);
      cache.clear();
      final newFuture = cache.computeIfAbsent(0, () => newOperation.future);

      oldOperation.completeError(Exception('test exception'));
      await expectLater(oldFuture, throwsA(isA<Exception>()));

      expect(cache.containsKey(0), isTrue);
      newOperation.complete();
      await newFuture;
      expect(cache.containsKey(0), isFalse);
    });
  });
}
