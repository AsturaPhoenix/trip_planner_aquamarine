import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aquamarine_server/aquamarine_server.dart';
import 'package:aquamarine_server/fetch_scheduler.dart';
import 'package:aquamarine_server/ofs_client.dart';
import 'package:aquamarine_server/persistence/caching.dart';
import 'package:aquamarine_server/persistence/v2.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void initializeLogger() {
  Logger.root.onRecord.listen((record) {
    final message = '[${record.time.toUtc()}] ${record.level} '
        '${record.loggerName}: ${record.message}';

    if (record.level >= Level.WARNING ||
        record.error != null ||
        record.stackTrace != null) {
      stderr.writeln(message);
    }

    if (record.level >= Level.CONFIG) {
      stdout.writeln(message);
    }

    if (record.error != null) {
      stderr.writeln('\t${record.error}');
    }
    if (record.stackTrace != null) {
      stderr.writeln(record.stackTrace);
    }
  });
}

Future<void> main() async {
  initializeLogger();

  final log = Logger('main'), requestLog = Logger('request');

  const headers = {'Access-Control-Allow-Origin': '*'};

  final instance = AquamarineServer(
    ofsClient: OfsClient(client: http.Client()),
    persistence: CachingPersistence(await Persistence.load(), uvCacheSize: 64),
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

              requestLog.info('uv: begin: $begin, end: $end, '
                  'bounds: $bounds, resolution: $resolution');
            } on Object catch (e, s) {
              log.warning(e, e, s);
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
            }(), context: const {'shelf.io.buffer_output': false});
          })),
    InternetAddress.anyIPv6,
    1080,
  );
  log.info('Serving at http://${server.address.host}:${server.port}');

  FetchScheduler(instance).start();
}
