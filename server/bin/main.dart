import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aquamarine_server/aquamarine_server.dart';
import 'package:aquamarine_server/ofs_client.dart';
import 'package:aquamarine_server/persistence.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:http/http.dart' as http;
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
    Router()
      ..get('/latlng/<hash>', (_, String hash) async {
        final latlng = await instance.latlng(Hex32.parse(hash));
        return latlng == null
            ? Response.notFound(null, headers: headers)
            : Response.ok(latlng, headers: headers);
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
                json['sw'][0] as double,
                json['sw'][1] as double,
              ),
              northeast: LatLng(
                json['ne'][0] as double,
                json['ne'][1] as double,
              ),
            );
          }

          {
            final value = parameters['resolution'];
            resolution = value == null ? 0 : double.parse(value);
          }

          print('uv: begin: $begin, end: $end, '
              'bounds: $bounds, resolution: $resolution');
        } on Object {
          return Response.badRequest(headers: headers);
        }

        return Response.ok(() async* {
          await for (final entry
              in instance.uv(begin, end, bounds, resolution)) {
            yield Uint8List.sublistView((ByteData(8)
              ..setUint32(0, entry.t.hoursSinceEpoch)
              ..setUint32(4, entry.latLngHash.value)));
            yield* entry.uv;
          }
        }(), headers: headers);
      }),
    InternetAddress.anyIPv6,
    1080,
  );
  print('Serving at http://${server.address.host}:${server.port}');
}