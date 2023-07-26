import 'dart:async';

import 'package:aquamarine_server_interface/types.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';

import 'aquamarine_server.dart';
import 'types.dart';

class FetchScheduler {
  static final log = Logger('FetchScheduler');

  // Observed empirically from catalog timestamps.
  // TODO(AsturaPhoenix): adaptive scheduling
  static const padding = Duration(minutes: 45);
  // Exponential backoff. For now, handle both 404s and transient errors with
  // this.
  static const initialDelay = Duration(minutes: 5);
  static const backoff = 1.5;

  FetchScheduler(this.server);
  final AquamarineServer server;

  late HourUtc _t;
  late Duration _delay;
  Timer? _timer;

  void start() {
    _t = HourUtc.truncate(clock.now().toUtc().subtract(padding));
    // Align to last simulation run before now.
    _t -= (_t.hour - SimulationSchedule.firstHour) %
        SimulationSchedule.intervalHours;
    _delay = initialDelay;
    _tick();
  }

  Future<void> _tick() async {
    log.info('Fetching simulation run $_t');

    FetchResult result;
    try {
      result = await server.fetchSimulationRun(_t);
    } catch (e, s) {
      log.warning('Fetch of simulation run $_t failed with an exception', e, s);
      result = FetchResult.transientFailure;
    }

    final next = _t + SimulationSchedule.intervalHours;
    final nextInterval = next.t.add(padding).difference(clock.now());

    void scheduleNext() {
      log.info('Next fetch scheduled in $nextInterval: $next.');
      _t = next;
      _delay = initialDelay;
      _timer = Timer(nextInterval, _tick);
    }

    void scheduleRetry() {
      log.info('Waiting $_delay before retry.');
      _timer = Timer(_delay, _tick);
      _delay *= backoff;
    }

    if (result == FetchResult.success) {
      scheduleNext();
    } else if (_delay >= nextInterval) {
      log.warning('Giving up on fetch of simulation run $_t in favor of '
          'approaching horizon $next.');
      scheduleNext();
    } else {
      scheduleRetry();
    }
  }

  void cancel() => _timer?.cancel();
}
