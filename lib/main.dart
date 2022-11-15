import 'dart:async';
import 'dart:developer' as debug;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

import 'providers/trip_planner_client.dart';
import 'widgets/map.dart';
import 'widgets/tide_panel.dart';

void main() {
  Logger.root.onRecord.listen(
    (record) => debug.log(
      '${record.level.name}: ${record.time}: ${record.message}',
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
    ),
  );

  initializeTimeZones();

  runApp(const TripPlanner());
}

class TripPlanner extends StatefulWidget {
  static const double appBarHorizontalPadding = 0xE0, sidePanelWidth = 473;

  const TripPlanner({super.key});

  @override
  TripPlannerState createState() => TripPlannerState();
}

class TripPlannerState extends State<TripPlanner> {
  static final log = Logger('TripPlannerState');

  TripPlannerState()
      : _client = TripPlannerClient.resolveFromRedirect(
          Uri.parse('https://www.bask.org/trip_planner/'),
          TripPlannerEndpoints(
            datapoints: Uri(path: 'datapoints.xml'),
            tides: Uri(path: 'tides.php'),
          ),
          timeZone: getLocation('America/Los_Angeles'),
        );

  Station? selectedStation;
  DateTime t = DateTime.now();

  @override
  void initState() {
    super.initState();

    // TODO: Surface something to the user.
    void logException(Object e, StackTrace s) => log.severe(
          'Exception during initialization.',
          e,
          s,
        );

    Future.value(_client).then(
      (client) {
        _client = client;
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

  FutureOr<TripPlannerClient> _client;

  var stations = <Station>{};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BASK Trip Planner',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xffbbccff),
        scaffoldBackgroundColor: const Color(0xffbbccff),
      ),
      home: LayoutBuilder(
        builder: (context, boxConstraints) {
          final inlineStationBar = boxConstraints.maxWidth >=
              TripPlanner.sidePanelWidth +
                  2 *
                      (_SelectedStationBar.blendedHorizontalPadding +
                          TripPlanner.appBarHorizontalPadding);
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
                          selectedStation!,
                          blendEdges: true,
                        ),
                      ),
                    )
                  : null,
            ),
            body: Column(
              children: [
                if (selectedStation != null && !inlineStationBar)
                  _SelectedStationBar(selectedStation!, blendEdges: false),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, boxConstraints) {
                      bool horizontal =
                          boxConstraints.maxWidth >= boxConstraints.maxHeight;
                      return Flex(
                        direction: horizontal ? Axis.horizontal : Axis.vertical,
                        children: [
                          Expanded(
                            child: Map(
                              stations: stations,
                              onStationSelected: (station) =>
                                  setState(() => selectedStation = station),
                            ),
                          ),
                          if (selectedStation != null)
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: horizontal
                                    ? min(
                                        TripPlanner.sidePanelWidth,
                                        boxConstraints.maxWidth / 2,
                                      )
                                    : boxConstraints.maxWidth,
                              ),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: TidePanel(
                                  client: _client as TripPlannerClient,
                                  station: selectedStation!,
                                  t: t,
                                  onTimeChanged: (t) =>
                                      setState(() => this.t = t),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SelectedStationBar extends StatelessWidget {
  static const double verticalPadding = 6, blendedHorizontalPadding = 40;
  static const double preferredWidth = 0x2C0;

  static Widget blendedEdgeContainer({
    required Color color,
    required Widget child,
  }) =>
      Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(minWidth: preferredWidth),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.elliptical(32, 4)),
          gradient: LinearGradient(
            colors: [Colors.transparent, color, color, Colors.transparent],
            stops: const [0, .05, .95, 1],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: blendedHorizontalPadding,
        ),
        child: child,
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

  final Station station;
  final bool blendEdges;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide()),
        ),
        position: DecorationPosition.foreground,
        child: UnconstrainedBox(
          constrainedAxis: Axis.horizontal,
          child: (blendEdges ? blendedEdgeContainer : fullWidthContainer)(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                station.typedShortTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
      );
}
