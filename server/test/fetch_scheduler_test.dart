import 'package:aquamarine_server/aquamarine_server.dart';
import 'package:aquamarine_server/fetch_scheduler.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([
  MockSpec<AquamarineServer>(),
])
import 'fetch_scheduler_test.mocks.dart';

void main() {
  final t = HourUtc(2023, 03, 27, 03);

  test('fetches previous run when started', () {
    fakeAsync((async) {
      final server = MockAquamarineServer();

      FetchScheduler(server).start();
      async.elapse(Duration.zero);

      verify(server.fetchSimulationRun(t));
    }, initialTime: t.t.add(FetchScheduler.padding));
  });

  test('fetches earlier run when started too close to the run time', () {
    fakeAsync((async) {
      final server = MockAquamarineServer();

      FetchScheduler(server).start();
      async.elapse(Duration.zero);

      verify(server.fetchSimulationRun(t - 6));
    }, initialTime: t.t.add(FetchScheduler.padding * .5));
  });

  test('schedules periodic fetches', () {
    fakeAsync((async) {
      final server = MockAquamarineServer();

      FetchScheduler(server).start();
      async.elapse(const Duration(days: 1));

      verify(server.fetchSimulationRun(t));
      verify(server.fetchSimulationRun(t + 6));
      verify(server.fetchSimulationRun(t + 12));
      verify(server.fetchSimulationRun(t + 18));
      verifyNever(server.fetchSimulationRun(t + 24));
    }, initialTime: t.t);
  });

  test('retries transient failures', () {
    fakeAsync((async) {
      final server = MockAquamarineServer();

      when(server.fetchSimulationRun(t))
          .thenAnswer((_) async => FetchResult.transientFailure);

      FetchScheduler(server).start();
      async.elapse(const Duration(hours: 6));

      verify(server.fetchSimulationRun(t)).called(9);
      verify(server.fetchSimulationRun(t + 6));
      verifyNoMoreInteractions(server);

      async.elapse(const Duration(hours: 6));

      verify(server.fetchSimulationRun(t + 12));
      verifyNoMoreInteractions(server);
    }, initialTime: t.t.add(FetchScheduler.padding));
  });

  test('retries 404s', () {
    fakeAsync((async) {
      final server = MockAquamarineServer();

      when(server.fetchSimulationRun(t))
          .thenAnswer((_) async => FetchResult.unavailable);

      FetchScheduler(server).start();
      async.elapse(const Duration(hours: 6));

      verify(server.fetchSimulationRun(t)).called(9);
      verify(server.fetchSimulationRun(t + 6));
      verifyNoMoreInteractions(server);

      async.elapse(const Duration(hours: 6));

      verify(server.fetchSimulationRun(t + 12));
      verifyNoMoreInteractions(server);
    }, initialTime: t.t.add(FetchScheduler.padding));
  });

  test('resumes schedule after failure + success', () {
    fakeAsync((async) {
      final server = MockAquamarineServer();

      int failures = 4;
      when(server.fetchSimulationRun(t)).thenAnswer((_) async {
        if (failures > 0) {
          --failures;
          return FetchResult.unavailable;
        } else {
          return FetchResult.success;
        }
      });

      FetchScheduler(server).start();
      async.elapse(const Duration(hours: 6));

      verify(server.fetchSimulationRun(t)).called(5);
      verify(server.fetchSimulationRun(t + 6));
      verifyNoMoreInteractions(server);
    }, initialTime: t.t.add(FetchScheduler.padding));
  });
}
