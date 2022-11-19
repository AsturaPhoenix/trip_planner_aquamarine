import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:joda/time.dart';
import 'package:logging/logging.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';
import 'package:trip_planner_aquamarine/persistence/tide_graph_cache.dart';
import 'package:xml/xml.dart';

class TripPlannerEndpoints {
  TripPlannerEndpoints({required this.datapoints, required this.tides});

  final Uri datapoints, tides;

  TripPlannerEndpoints resolve(Uri base) => TripPlannerEndpoints(
        datapoints: base.resolveUri(datapoints),
        tides: base.resolveUri(tides),
      );
}

class _RedirectInfo implements RedirectInfo {
  _RedirectInfo({
    required this.location,
    required this.method,
    required this.statusCode,
  });

  @override
  final Uri location;
  @override
  final String method;
  @override
  final int statusCode;
}

Future<Uri> resolveRedirects(
  Client client,
  Uri url, {
  required int maxRedirects,
}) async {
  final redirects = <RedirectInfo>[];
  while (redirects.length <= maxRedirects) {
    final response =
        await client.send(Request('HEAD', url)..followRedirects = false);
    if (response.isRedirect) {
      url = Uri.parse(response.headers['location']!);
      redirects.add(
        _RedirectInfo(
          location: url,
          method: 'HEAD',
          statusCode: response.statusCode,
        ),
      );
    } else {
      return url;
    }
  }
  throw RedirectException('Too many redirects', redirects);
}

class TripPlannerClient {
  static final log = Logger('TripPlannerClient');

  TripPlannerClient(this.tideGraphCache, this.httpClient, this.timeZone);
  final BlobCache tideGraphCache;
  final TripPlannerHttpClient httpClient;

  /// The server uses local time zone, and all the stations are on the West
  /// Coast.
  final TimeZone timeZone;

  void close() => httpClient.close();

  Future<Set<Station>> getDatapoints() async => httpClient.getDatapoints();

  Stream<Uint8List> getTideGraph(
    Station station,
    int days,
    int width,
    int height,
    Date begin,
  ) {
    final results = StreamController<Uint8List>();

    final key = TideGraphKey(station.id, begin, days).toString();
    final cached = tideGraphCache[key];
    if (cached != null) {
      results.add(cached);
    }

    httpClient.getTideGraph(station, days, width, height, begin).then((data) {
      if (data != null) {
        results.add(data);
        tideGraphCache[key] = data;
      }
    }).whenComplete(results.close);

    return results.stream;
  }
}

class TripPlannerHttpClient {
  static final log = Logger('TripPlannerHttpClient');

  static Future<TripPlannerHttpClient> resolveFromRedirect(
    Uri base,
    TripPlannerEndpoints relative, {
    int maxRedirects = 5,
  }) async {
    final client = Client();
    try {
      base = await resolveRedirects(client, base, maxRedirects: maxRedirects);
    } on ClientException {
      // For web during development, we may run into CORS denials, so use a local instance.
      if (kIsWeb) {
        base = Uri.parse('http://localhost/trip_planner/');
      } else {
        rethrow;
      }
    }
    log.info('base URL: $base');
    return TripPlannerHttpClient._(client, relative.resolve(base));
  }

  TripPlannerHttpClient._(this.client, this.endpoints);
  final Client client;
  final TripPlannerEndpoints endpoints;

  void close() => client.close();

  Future<Set<Station>> getDatapoints() async {
    final response = await client.get(endpoints.datapoints);
    final stations = {
      for (final stationNode
          in XmlDocument.parse(response.body).findAllElements('station'))
        Station.fromXml(stationNode)
    };
    assert(
      {for (var s in stations) s.id}.length == stations.length,
      'Duplicate station ID present.',
    );
    return stations;
  }

  Future<Uint8List?> getTideGraph(
    Station station,
    int days,
    int width,
    int height,
    Date begin,
  ) async {
    final url = endpoints.tides.replace(
      queryParameters: {
        'days': days.toString(),
        'mode': 'graph',
        'tcd': station.source,
        'station': station.title,
        'type': station.type,
        'width': width.toString(),
        'height': height.toString(),
        'begin': '${begin.year}-${begin.month}-${begin.day}',
        'subord': station.isSubordinate ? '1' : '',
      },
    );

    log.info('get $url');

    try {
      final response = await client.get(url);

      if (response.statusCode == HttpStatus.ok) {
        return response.bodyBytes;
      } else {
        log.warning(response);
        return null;
      }
    } catch (e, s) {
      log.warning(e, e, s);
      return null;
    }
  }
}

LatLng latLngFromXml(XmlElement node) => LatLng(
      double.parse(node.getAttribute('lat')!),
      double.parse(node.getAttribute('lng')!),
    );

// tp.js: marker_from_xml
class Station {
  static const idPrefixes = ['t', 'c', 'x'];
  static const typeDescriptions = {
    'launch': 'Launch Site',
    'meeting': 'Meeting Place',
    'destination': 'Destination',
    'tide': 'Tide Station',
    'current': 'Current Station',
    'legacy': 'Legacy Tide and Current Stations',
    'subordinate': 'Subordinate Tide and Current Stations',
    'yourcoast': 'YourCoast',
    'nogo': 'Restricted Area',
  };

  static String _getId(XmlElement node) {
    for (final prefix in idPrefixes) {
      final idByType = node.getAttribute('${prefix}id');
      if (idByType != null) {
        return prefix + idByType;
      }
    }
    throw FormatException('Missing required .id attribute', node);
  }

  Station.fromXml(XmlElement node)
      : id = _getId(node),
        type = node.getAttribute('station_type')!,
        marker = latLngFromXml(node.findElements('marker').first),
        title = node.getAttribute('title')!,
        source = node.getAttribute('source'),
        isSubordinate = node.getAttribute('subtype') == 'Subordinate';
  final String id;
  final String type;
  String get typeDescription => typeDescriptions[type]!;
  final LatLng marker;
  final String title;
  String get shortTitle =>
      title.replaceAll(RegExp(r', California( Current)?'), '');
  String get typedShortTitle => '$typeDescription: $shortTitle';
  final String? source;
  final bool isSubordinate;
}
