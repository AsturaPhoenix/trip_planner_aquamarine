import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
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

  static void registerAdapters() {
    Hive.registerAdapter(StationAdapter());
    Hive.registerAdapter(LatLngAdapter());
  }

  TripPlannerClient(
      this.stationCache, this.tideGraphCache, this.httpClient, this.timeZone);
  final Box<Station> stationCache;
  final BlobCache tideGraphCache;
  final TripPlannerHttpClient httpClient;

  /// The server uses local time zone, and all the stations are on the West
  /// Coast.
  final TimeZone timeZone;

  void close() => httpClient.close();

  Stream<Set<Station>> getDatapoints() {
    final results = StreamController<Set<Station>>();
    if (stationCache.isNotEmpty) {
      log.info('Stations: cache hit.');
      results.add({...stationCache.values});
    } else {
      log.info('Stations: cache miss.');
    }

    httpClient.getDatapoints().then(
      (stations) {
        log.info('Stations: refreshed.');
        results.add(stations);
        stationCache.clear();
        stationCache.addAll(stations);
      },
      onError: (e, StackTrace s) =>
          log.warning('Failed to fetch/refresh stations.', e, s),
    ).whenComplete(results.close);

    return results.stream;
  }

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

    httpClient.getTideGraph(station, days, width, height, begin).then(
      (data) {
        results.add(data);
        tideGraphCache[key] = data;
      },
      onError: (e, StackTrace s) =>
          log.warning('Failed to fetch/refresh tide graph.', e, s),
    ).whenComplete(results.close);

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
    if (response.statusCode != HttpStatus.ok) {
      throw response;
    }

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

  Future<Uint8List> getTideGraph(
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

    final response = await client.get(url);

    if (response.statusCode == HttpStatus.ok) {
      return response.bodyBytes;
    } else {
      throw response;
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
  Station.read(BinaryReader reader)
      : id = reader.readString(),
        type = reader.readString(),
        marker = reader.read() as LatLng,
        title = reader.readString(),
        source = reader.read() as String?,
        isSubordinate = reader.readBool();

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

  void write(BinaryWriter writer) => writer
    ..writeString(id)
    ..writeString(type)
    ..write(marker)
    ..writeString(title)
    ..write(source)
    ..writeBool(isSubordinate);
}

class StationAdapter extends TypeAdapter<Station> {
  @override
  final int typeId = 1;

  @override
  Station read(BinaryReader reader) => Station.read(reader);

  @override
  void write(BinaryWriter writer, Station obj) => obj.write(writer);
}

class LatLngAdapter extends TypeAdapter<LatLng> {
  @override
  final int typeId = 2;

  @override
  LatLng read(BinaryReader reader) =>
      LatLng(reader.readDouble(), reader.readDouble());

  @override
  void write(BinaryWriter writer, LatLng obj) => writer
    ..writeDouble(obj.latitude)
    ..writeDouble(obj.longitude);
}
