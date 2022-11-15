import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
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

  static Future<TripPlannerClient> resolveFromRedirect(
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
    return TripPlannerClient._(client, relative.resolve(base));
  }

  static Uri tideGraphUrl(
    TripPlannerEndpoints endpoints,
    Station station,
    int days,
    int width,
    int height,
    DateTime t,
  ) {
    // The server uses local time zone, and all the stations are on the West
    // Coast. Since this is noncritical, let's keep using local time for now.
    assert(!t.isUtc);
    return endpoints.tides.replace(
      queryParameters: {
        'days': days.toString(),
        'mode': 'graph',
        'tcd': station.source,
        'station': station.title,
        'type': station.type,
        'width': width.toString(),
        'height': height.toString(),
        // We could pass the full time, but let's be kind to the cache.
        'begin': '${t.year}-${t.month}-${t.day}',
        'subord': station.isSubordinate ? '1' : '',
      },
    );
  }

  TripPlannerClient._(this._client, this.endpoints);
  final Client _client;
  final TripPlannerEndpoints endpoints;

  void close() => _client.close();

  Future<Set<Station>> getDatapoints() async {
    final response = await _client.get(endpoints.datapoints);
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
