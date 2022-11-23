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

class RetryOnDemand<T> {
  static final log = Logger('RetryOnDemand');

  RetryOnDemand(this._factory) {
    _cached = _guardedFactory();
  }

  final Future<T> Function() _factory;
  Future<T>? _cached;

  Future<T> _guardedFactory() => _factory().onError((Object e, s) {
        _cached = null;
        throw e;
      });

  Future<T> get() => _cached ??= _guardedFactory();
}

class TripPlannerClient {
  static final log = Logger('TripPlannerClient');

  static void registerAdapters() {
    Hive.registerAdapter(StationAdapter());
    Hive.registerAdapter(LatLngAdapter());
  }

  TripPlannerClient(
    this.stationCache,
    this.tideGraphCache,
    this.httpClient,
    this.timeZone,
  );
  final Box<Station> stationCache;
  final BlobCache tideGraphCache;
  Future<TripPlannerHttpClient> Function()? httpClient;

  /// The server uses local time zone, and all the stations are on the West
  /// Coast.
  final TimeZone timeZone;

  void close() => httpClient?.call().then((client) => client.close()).ignore;

  Stream<Set<Station>> getDatapoints() {
    final results = StreamController<Set<Station>>();
    final bool needResults;
    if (stationCache.isNotEmpty) {
      log.info('Stations: cache hit.');
      results.add({...stationCache.values});
      needResults = false;
    } else {
      log.info('Stations: cache miss.');
      needResults = true;
    }

    if (httpClient != null) {
      () async {
        try {
          final stations = await (await httpClient!()).getDatapoints();
          log.info('Stations: fetched/refreshed.');
          results.add(stations);
          stationCache
            ..clear()
            ..addAll(stations);
        } catch (e, s) {
          if (needResults) {
            results.addError(e, s);
          } else {
            log.warning('Failed to refresh stations.', e, s);
          }
        } finally {
          results.close();
        }
      }();
    } else {
      results.close();
    }

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
    final bool needResults;

    final key = TideGraphKey(station.id, begin, days).toString();
    final cached = tideGraphCache[key];
    if (cached != null) {
      results.add(cached);
      needResults = false;
    } else {
      needResults = true;
    }

    if (httpClient != null) {
      () async {
        try {
          // TODO: Deduplicate current requests, or cancel on unsubscribe.
          final data = await (await httpClient!())
              .getTideGraph(station, days, width, height, begin);
          results.add(data);
          tideGraphCache[key] = data;
        } catch (e, s) {
          if (needResults) {
            results.addError(e, s);
          } else {
            log.warning('Failed to fetch/refresh tide graph.', e, s);
          }
        } finally {
          results.close();
        }
      }();
    } else {
      results.close();
    }

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
        'type': station.type.name,
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

enum StationType {
  launch('Launch Site'),
  meeting('Meeting Place'),
  destination('Destination'),
  tide('Tide Station'),
  current('Current Station'),
  legacy('Legacy Tide and Current Stations'),
  subordinate('Subordinate Tide and Current Stations'),
  yourcoast('YourCoast'),
  nogo('Restricted Area');

  static final _byName = {for (final e in values) e.name: e};

  const StationType(this.description);
  factory StationType.forName(String name) => _byName[name]!;
  final String description;
}

// tp.js: marker_from_xml
class Station {
  static const idPrefixes = ['t', 'c', 'x'];

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
        type = StationType.forName(node.getAttribute('station_type')!),
        marker = latLngFromXml(node.findElements('marker').first),
        noaaId = node.getAttribute('noaa_id') ?? '',
        title = node.getAttribute('title')!,
        source = node.getAttribute('source'),
        isSubordinate = node.getAttribute('subtype') == 'Subordinate';
  Station.read(BinaryReader reader)
      : id = reader.readString(),
        type = StationType.forName(reader.readString()),
        marker = reader.read() as LatLng,
        noaaId = reader.readString(),
        title = reader.readString(),
        source = reader.read() as String?,
        isSubordinate = reader.readBool();

  final String id;
  final StationType type;
  final LatLng marker;
  final String noaaId;
  bool get isLegacy => noaaId == '';
  final String title;
  String get shortTitle =>
      title.replaceAll(RegExp(r', California( Current)?'), '');
  String get typedShortTitle => '${type.description}: $shortTitle';
  final String? source;
  final bool isSubordinate;

  void write(BinaryWriter writer) => writer
    ..writeString(id)
    ..writeString(type.name)
    ..write(marker)
    ..writeString(noaaId)
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
