import 'dart:async';

import 'package:aquamarine_util/async.dart';
import 'package:test/test.dart';

void main() {
  test('does not cancel if value is taken', () async {
    var closed = false;
    final protector = ClosableProtector(0, (_) => closed = true);
    expect(await protector.stream.first, 0);
    await protector.close();
    expect(closed, false);
  });

  test('cancels if stream is never listened to', () async {
    final closed = Completer<void>();
    late final StreamSubscription<int> subscription;
    subscription = () async* {
      final protector = ClosableProtector(0, (_) => closed.complete());
      try {
        unawaited(subscription.cancel());
        yield* protector.stream;
      } finally {
        await protector.close();
      }
    }()
        .listen((_) => fail('unexpected event'));
    expect(closed.future, completes);
  });

  test('does not cancel if stream is taken', () async {
    await (() async* {
      final protector = ClosableProtector(0);
      try {
        yield* protector.stream;
      } finally {
        await protector.close();
      }
    }())
        .drain();
  });

  test('adheres to stream contract', () async {
    final protector = ClosableProtector(0);
    var done = false, received = false;
    protector.stream.listen((_) => received = true, onDone: () => done = true);
    expect(received, false);
    await null;
    expect(received, true);
    await null;
    expect(done, true);
  });

  test('cancels if the value is not taken', () async {
    for (int delays = 0;; ++delays) {
      var closed = false, received = false;
      final s = ClosableProtector(0, (_) => closed = true)
          .stream
          .listen((_) => received = true);
      for (int i = 0; i < delays; ++i) {
        await null;
        if (received) return;
      }
      await s.cancel();
      expect(closed, true);
    }
  });
}
