import 'dart:async';
import 'dart:developer' as debug;

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:joda/time.dart';
import 'package:logging/logging.dart';
import 'package:timezone/data/latest.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';
import 'package:trip_planner_aquamarine/persistence/cache_box.dart';

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

  final httpClient = TripPlannerHttpClient.resolveFromRedirect(
    Uri.parse('https://www.bask.org/trip_planner/'),
    TripPlannerEndpoints(
      datapoints: Uri(path: 'datapoints.xml'),
      tides: Uri(path: 'tides.php'),
    ),
  );

  final hive = Hive.initFlutter();

  runApp(
    TripPlanner(
      client: () async {
        await hive;

        BlobCache.registerAdapters();
        TripPlannerClient.registerAdapters();

        final stationCache = CacheBox.tryOpen<Station>('Stations');
        final tideGraphCache = await BlobCache.open('TideGraphCache');
        tideGraphCache
            .evict((blobs, metadata) => blobs > 250); // approx. 20 kB ea.

        return TripPlannerClient(
          await stationCache,
          tideGraphCache,
          await httpClient,
          TimeZone.forId('America/Los_Angeles'),
        );
      }(),
    ),
  );
}

class TripPlanner extends StatefulWidget {
  const TripPlanner({super.key, required this.client});

  final FutureOr<TripPlannerClient> client;

  @override
  TripPlannerState createState() => TripPlannerState();
}

class TripPlannerState extends State<TripPlanner> {
  static final log = Logger('TripPlannerState');

  Station? selectedStation;
  Instant t = Instant.now();

  @override
  void initState() {
    super.initState();
    setClient(widget.client);
  }

  @override
  void didUpdateWidget(covariant TripPlanner oldWidget) {
    setClient(widget.client);
    super.didUpdateWidget(oldWidget);
  }

  late TripPlannerClient client;
  CancelableOperation<void>? _clientOperation;
  void setClient(FutureOr<TripPlannerClient> value) {
    _clientOperation?.cancel();

    _clientOperation =
        CancelableOperation.fromFuture(Future.value(value)).then((value) {
      client = value;
      setState(() => stations = client.getDatapoints().asBroadcastStream());
      return stations!.first;
    }).then(
      (stations) {
        if (selectedStation == null) {
          setState(() {
            selectedStation = stations.first;
          });
        }
      },
      onError: (e, s) =>
          // TODO: Surface something to the user.
          log.severe('Exception during initialization.', e, s),
    );
  }

  Stream<Set<Station>>? stations;

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
          const double selectedStationBarMinWidth = 480,
              titleAreaPadding = 164,
              selectedStationBarMinPadding = 16;
          final centeredInlineStationBar = boxConstraints.maxWidth >=
              selectedStationBarMinWidth +
                  2 *
                      (_SelectedStationBar.blendedHorizontalPadding +
                          selectedStationBarMinPadding +
                          titleAreaPadding);
          final inlineStationBar = boxConstraints.maxWidth >=
              selectedStationBarMinWidth +
                  2 *
                      (_SelectedStationBar.blendedHorizontalPadding +
                          selectedStationBarMinPadding) +
                  titleAreaPadding;

          const title = Text('BASK Trip Planner');

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  title,
                  if (selectedStation != null && inlineStationBar)
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: selectedStationBarMinPadding,
                        ),
                        child: _SelectedStationBar(
                          selectedStation!,
                          blendEdges: true,
                        ),
                      ),
                    ),
                  if (centeredInlineStationBar)
                    const Opacity(opacity: 0, child: title),
                ],
              ),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: StreamBuilder(
                                stream: stations,
                                builder: (context, snapshot) => Map(
                                      stations: snapshot.data ?? {},
                                      onStationSelected: (station) => setState(
                                          () => selectedStation = station),
                                    )),
                          ),
                          if (selectedStation != null)
                            FittedBox(
                              alignment: Alignment.topCenter,
                              fit: BoxFit.scaleDown,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: horizontal
                                      ? boxConstraints.maxWidth / 2
                                      : boxConstraints.maxWidth,
                                ),
                                child: TidePanel(
                                  client: client,
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
        width: preferredWidth,
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
        child: (blendEdges ? blendedEdgeContainer : fullWidthContainer)(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: FittedBox(
            child: Text(
              station.typedShortTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      );
}
