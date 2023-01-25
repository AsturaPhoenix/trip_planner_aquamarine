import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';

import 'data/datapoints.xml.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import 'datapoints_test.mocks.dart';

void main() {
  test('datapoints parsing unicode', () {
    final swedesBeach = kDatapoints.values
        .firstWhere((station) => station.title.startsWith('Swede'));
    expect(swedesBeach.shortTitle, 'Swede’s Beach');

    final anoNuevo = kDatapoints.values.firstWhere(
        (station) => station.title.endsWith('o Nuevo State Marine Reserve'));
    expect(anoNuevo.shortTitle, 'Año Nuevo State Marine Reserve');
  });

  /// Verify proper encoding when the server omits the charset.
  test('datapoints http unicode', () async {
    final client = MockClient();
    when(client.get(Uri.parse('datapoints.xml'))).thenAnswer((_) async =>
        http.Response.bytes(
            const Utf8Encoder().convert(kDatapointsXml), HttpStatus.ok));

    final datapoints =
        await TripPlannerHttpClient(client, Uri()).getDatapoints();

    final swedesBeach = datapoints.values
        .firstWhere((station) => station.title.startsWith('Swede'));
    expect(swedesBeach.shortTitle, 'Swede’s Beach');

    final anoNuevo = datapoints.values.firstWhere(
        (station) => station.title.endsWith('o Nuevo State Marine Reserve'));
    expect(anoNuevo.shortTitle, 'Año Nuevo State Marine Reserve');
  });
}
