import 'dart:async';
import 'dart:developer' as debug;

import 'package:flutter/material.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'widgets/map.dart';

void main() {
  runApp(const TripPlanner());
}

class TripPlanner extends StatefulWidget {
  const TripPlanner({super.key});

  @override
  TripPlannerState createState() => TripPlannerState();
}

class TripPlannerState extends State<TripPlanner> {
  TripPlannerState()
      : _client = TripPlannerClient.resolveFromRedirect(
            Uri.parse('https://www.bask.org/trip_planner/'),
            TripPlannerEndpoints(datapoints: Uri(path: 'datapoints.xml')));

  @override
  void initState() {
    super.initState();

    // TODO: Surface something to the user.
    void logException(Object e, StackTrace s) =>
        debug.log('Exception during initialization.',
            name: 'TripPlannerState', error: e, stackTrace: s);

    _client.then((client) {
      client.getDatapoints().then(
          (stations) => setState(() => this.stations = stations),
          onError: logException);
    }, onError: logException);
  }

  final Future<TripPlannerClient> _client;

  var stations = <Station>{};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BASK Trip Planner',
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(0xff, 0xc9, 0xd3, 0xdc),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BASK Trip Planner'),
        ),
        body: Map(stations: stations),
      ),
    );
  }
}
