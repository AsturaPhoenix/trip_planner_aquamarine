import 'dart:async';
import 'dart:developer' as debug;

import 'package:flutter/material.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'widgets/map.dart';

void main() {
  runApp(const TripPlanner());
}

class TripPlanner extends StatefulWidget {
  static const double appBarHorizontalPadding = 0xE0;

  const TripPlanner({super.key});

  @override
  TripPlannerState createState() => TripPlannerState();
}

class TripPlannerState extends State<TripPlanner> {
  TripPlannerState()
      : _client = TripPlannerClient.resolveFromRedirect(
          Uri.parse('https://www.bask.org/trip_planner/'),
          TripPlannerEndpoints(datapoints: Uri(path: 'datapoints.xml')),
        );

  Station? selectedStation;

  @override
  void initState() {
    super.initState();

    // TODO: Surface something to the user.
    void logException(Object e, StackTrace s) => debug.log(
          'Exception during initialization.',
          name: 'TripPlannerState',
          error: e,
          stackTrace: s,
        );

    _client.then(
      (client) {
        client.getDatapoints().then(
              (stations) => setState(() {
                this.stations = stations;
                selectedStation = stations.first;
              }),
              onError: logException,
            );
      },
      onError: logException,
    );
  }

  final Future<TripPlannerClient> _client;

  var stations = <Station>{};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BASK Trip Planner',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xffc9d3dc),
      ),
      home: LayoutBuilder(
        builder: (context, boxConstraints) {
          final inlineStationBar = boxConstraints.maxWidth >=
              _SelectedStationBar.preferredWidth +
                  2 * TripPlanner.appBarHorizontalPadding;
          return Scaffold(
            appBar: AppBar(
              title: const Text('BASK Trip Planner'),
              flexibleSpace: selectedStation != null && inlineStationBar
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: TripPlanner.appBarHorizontalPadding,
                      ),
                      child: Center(
                        child: _SelectedStationBar(
                          selectedStation,
                          blendEdges: true,
                        ),
                      ),
                    )
                  : null,
            ),
            body: Column(
              children: [
                if (selectedStation != null && !inlineStationBar)
                  _SelectedStationBar(selectedStation, blendEdges: false),
                Expanded(
                  child: Map(
                    stations: stations,
                    onStationSelect: (station) =>
                        setState(() => selectedStation = station),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SelectedStationBar extends StatelessWidget {
  static const double verticalPadding = 6;
  static const double preferredWidth = 0x2C0;

  static Widget blendedEdgeContainer({
    required Color color,
    required Widget child,
  }) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.elliptical(32, 4)),
          gradient: LinearGradient(
            colors: [Colors.transparent, color, color, Colors.transparent],
            stops: const [0, .05, .95, 1],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: 40,
        ),
        constraints: const BoxConstraints(minWidth: preferredWidth),
        child: Align(
          alignment: Alignment.center,
          heightFactor: 1,
          widthFactor: 1,
          child: child,
        ),
      );

  static Widget fullWidthContainer({
    required Color color,
    required Widget child,
  }) =>
      Container(
        color: color,
        padding: const EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: 16,
        ),
        child: Center(child: child),
      );

  const _SelectedStationBar(this.station, {this.blendEdges = true});

  final Station? station;
  final bool blendEdges;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide()),
        ),
        position: DecorationPosition.foreground,
        child: (blendEdges ? blendedEdgeContainer : fullWidthContainer)(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              station?.typedShortTitle ?? '',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
