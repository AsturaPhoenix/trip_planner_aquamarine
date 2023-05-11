import 'package:aquamarine_server/mutex.dart';
import 'package:test/test.dart';

void main() {
  test('acquireWrite on a fresh mutex completes true', () async {
    expect(await VersionedReadWriteMutex().acquireWrite(), true);
  });

  test('sequential acquireWrites complete true', () async {
    final mutex = VersionedReadWriteMutex();
    expect(await mutex.acquireWrite(), true);
    mutex.release();
    expect(await mutex.acquireWrite(), true);
    mutex.release();
  });

  test('parallel acquireWrites', () async {
    final mutex = VersionedReadWriteMutex();
    final waits = List.generate(3, (_) => mutex.acquireWrite());
    expect(await waits[0], true);
    mutex.release();
    expect(await waits[1], false);
    mutex.release();
    expect(await waits[2], false);
    mutex.release();
  });
}
