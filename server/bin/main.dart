import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aquamarine_server/aquamarine_server.dart';
import 'package:aquamarine_server/ofs_client.dart';
import 'package:aquamarine_server/persistence/v2.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  const headers = {'Access-Control-Allow-Origin': '*'};

  final instance = AquamarineServer(
    ofsClient: OfsClient(client: http.Client()),
    persistence: await Persistence.load(),
  );
  final server = await io.serve(
    Pipeline()
        .addMiddleware((handler) => (request) async =>
            (await handler(request)).change(headers: headers))
        .addHandler(Router()
          ..get('/latlng/<hash>', (_, String hash) async {
            final latlng = await instance.latlng(Hex32.parse(hash));
            return latlng == null
                ? Response.notFound(null)
                : Response.ok(latlng);
          })
          ..get('/uv', (Request request) {
            final HourUtc begin, end;
            final LatLngBounds bounds;
            final double resolution;
            try {
              final parameters = request.url.queryParameters;

              begin = HourUtc.truncate(
                DateTime.parse(parameters['begin']!).toUtc(),
              );
              end = HourUtc.truncate(
                DateTime.parse(parameters['end']!).toUtc(),
              );

              {
                final json = jsonDecode(parameters['bounds']!);
                bounds = LatLngBounds(
                  southwest: LatLng(
                    (json['sw'][0] as num).toDouble(),
                    (json['sw'][1] as num).toDouble(),
                  ),
                  northeast: LatLng(
                    (json['ne'][0] as num).toDouble(),
                    (json['ne'][1] as num).toDouble(),
                  ),
                );
              }

              {
                final value = parameters['resolution'];
                resolution = value == null ? 0 : double.parse(value);
              }

              print('uv: begin: $begin, end: $end, '
                  'bounds: $bounds, resolution: $resolution');
            } on Object catch (e) {
              print(e);
              return Response.badRequest();
            }

            return Response.ok(() async* {
              await for (final entry
                  in instance.uv(begin, end, bounds, resolution)) {
                try {
                  yield Uint8List.sublistView((ByteData(8)
                    ..setUint32(0, entry.t.hoursSinceEpoch)
                    ..setUint32(4, entry.latLngHash.value)));
                  yield* entry.uv;
                } finally {
                  unawaited(entry.close());
                }
              }
            }());
          })),
    InternetAddress.anyIPv6,
    1080,
  );
  print('Serving at http://${server.address.host}:${server.port}');

  // TODO(AsturaPhoenix): common SimulationSchedule for nowcasts and forecast
  // runs
  const firstHour = 3, intervalHours = 6;
  // Observed empirically from catalog timestamps.
  // TODO(AsturaPhoenix): adaptive scheduling
  const padding = Duration(hours: 1);

  void tick(HourUtc t) async {
    final next = t + intervalHours;
    final nextInterval = next.t.add(padding).difference(DateTime.now());
    Timer(nextInterval, () => tick(next));
    print('Next fetch scheduled in $nextInterval');

    print('Fetching simulation run $t');
    try {
      if (await instance.fetchSimulationRun(t)) {
        print('Fetch of simulation run $t succeeded');
      } else {
        print('Fetch of simulation run $t failed');
      }
    } catch (e) {
      print(e);
    }
  }

  HourUtc initial = HourUtc.truncate(DateTime.now().toUtc());
  // Align to last simulation run before now.
  initial -= (initial.hour - firstHour) % intervalHours;

  tick(initial);
}
