import 'dart:core';
import 'dart:core' as core;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'package:trip_planner_aquamarine/util/optional.dart';

import '../providers/wms_tile_provider.dart';

class Map extends StatefulWidget {
  static const initialCameraPosition = CameraPosition(
    // Center map on Alcatraz, to show the interesting points around the Bay.
    target: LatLng(37.8331, -122.4165),
    zoom: 12,
  );

  const Map({
    super.key,
    required this.client,
    required this.tileCache,
    this.stations = const {},
    this.selectedStation,
    this.onStationSelected,
  });

  final http.Client client;
  final BlobCache tileCache;
  final core.Map<StationId, Station> stations;
  final Station? selectedStation;

  final void Function(Station station)? onStationSelected;

  @override
  MapState createState() => MapState();
}

class TileOverlayConfiguration<T extends TileProvider> {
  final TileOverlayId id;
  final T tileProvider;
  TileOverlayConfiguration(String id, this.tileProvider)
      : id = TileOverlayId(id);
}

class _MarkerIcons {
  _MarkerIcons({
    required this.stations,
    required this.selected,
    required this.tcSelected,
  });
  final core.Map<StationType, BitmapDescriptor> stations;

  /// Halo for the selected location.
  final BitmapDescriptor selected,

      /// Halo for a nearby tide/current station, when the selected location is
      /// not tide/current.
      tcSelected;
}

/// I'm not sure there's an official source, but this seems to be a consensus
/// format for reporting to the Coast Guard.
String formatPosition(Position position) {
  String formatPolar(
    double polar,
    String positiveSuffix,
    String negativeSuffix,
  ) =>
      "${polar.abs().truncate()}° ${(polar.abs() % 1 * 60).toStringAsFixed(2)}'"
      ' ${polar >= 0 ? positiveSuffix : negativeSuffix}';
  return '${formatPolar(position.latitude, 'N', 'S')}, '
      '${formatPolar(position.longitude, 'E', 'W')}';
}

class MapState extends State<Map> {
  static final log = Logger('MapState');

  // TODO: make this configurable
  static const showMarkerTypes = {
    StationType.tide,
    StationType.current,
    StationType.launch,
    StationType.destination,
  };

  late final chartOverlays = [
    TileOverlayConfiguration(
      'nautical',
      WmsTileProvider(
        client: widget.client,
        cache: widget.tileCache,
        tileType: 'nautical',
        url: Uri.parse(
          'https://gis.charttools.noaa.gov/arcgis/rest/services/MCS/NOAAChartDisplay/MapServer/exts/MaritimeChartService/WMSServer',
        ),
        fetchLod: 2,
        levelOfDetail: 14,
        params: WmsParams()
          ..version = '1.3.0'
          ..layers = '0,1,2,3,4,5,6,7',
      ),
    )
  ];
  GoogleMapController? _gmap;

  int zoom = Map.initialCameraPosition.zoom.toInt();
  int chartOverlayIndex = 0;
  TileOverlayConfiguration<WmsTileProvider> get chartOverlay =>
      chartOverlays[chartOverlayIndex];

  void _setLod(int lod) => setState(() {
        for (final overlay in chartOverlays) {
          overlay.tileProvider.levelOfDetail = lod;
          // TODO: This does not cancel inflight requests, which can leave stale tiles.
          _gmap!.clearTileCache(overlay.id);
        }
      });

  Future<_MarkerIcons>? _markerIcons;
  late final Future<bool> locationEnabled;
  Stream<Position>? _positionStream;

  @override
  void initState() {
    super.initState();
    locationEnabled = Permission.locationWhenInUse
        .request()
        .isGranted
        .catchError((_) => false)
      ..then((locationEnabled) {
        // This probably isn't the most efficient way to do this. If battery use
        // is a problem, try querying on tap instead.
        if (locationEnabled) {
          setState(() => _positionStream = Geolocator.getPositionStream());
        }
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future<BitmapDescriptor> loadAsset(
      String type,
      ImageConfiguration imageConfiguration,
    ) =>
        BitmapDescriptor.fromAssetImage(
          imageConfiguration,
          'assets/markers/$type.png',
          mipmaps: false,
        );

    final defaultConfiguration = createLocalImageConfiguration(context);
    final stations = [
      for (final stationType in showMarkerTypes)
        loadAsset(stationType.name, defaultConfiguration)
    ];

    final selConfiguration =
        defaultConfiguration.copyWith(size: const Size(22, 21));
    final selected = loadAsset('sel', selConfiguration);
    final tcSelected = loadAsset('tc_sel', selConfiguration);

    _markerIcons = (() async => _MarkerIcons(
          stations: core.Map.fromIterables(
            showMarkerTypes,
            await Future.wait(stations),
          ),
          selected: await selected,
          tcSelected: await tcSelected,
        ))();

    final maxOversample =
        2 + (defaultConfiguration.devicePixelRatio?.floor() ?? 1) - 1;
    for (final overlay in chartOverlays) {
      overlay.tileProvider.maxOversample = maxOversample;
    }
  }

  @override
  void didUpdateWidget(covariant Map oldWidget) {
    super.didUpdateWidget(oldWidget);
    for (final overlay in chartOverlays) {
      overlay.tileProvider.client = widget.client;
      overlay.tileProvider.cache = widget.tileCache;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tileSize = (MediaQuery.of(context).devicePixelRatio *
            WmsTileProvider.logicalTileSize)
        .ceil();

    for (final overlay in chartOverlays) {
      overlay.tileProvider.preferredTileSize = tileSize;
    }

    return Stack(
      children: [
        FutureBuilder(
          future: _markerIcons,
          builder: (context, iconsSnapshot) => StreamBuilder(
            stream: _positionStream,
            builder: (context, positionSnapshot) {
              final markers = <Marker>{};

              if (iconsSnapshot.hasData) {
                final markerIcons = iconsSnapshot.data!;

                if (positionSnapshot.hasData) {
                  const markerId = MarkerId('current location');
                  final position = positionSnapshot.data!;
                  markers.add(
                    Marker(
                      markerId: markerId,
                      anchor: const Offset(.5, .5),
                      position: LatLng(position.latitude, position.longitude),
                      // This icon will be transparent, but we want something of
                      //roughly this size and anchored at the center.
                      icon: markerIcons.selected,
                      alpha: 0,
                      // TODO: This text does not update while the info window
                      // is shown.
                      infoWindow: InfoWindow(
                        title: formatPosition(position),
                        // No need for kIsWeb since we haven't implemented a
                        // location widget for web yet.
                        onTap: () => _gmap!.hideMarkerInfoWindow(markerId),
                      ),
                      // Take precedence over other markers.
                      zIndex: 10,
                    ),
                  );
                }

                // tp.js: show_hide_marker
                bool stationFilter(Station station) =>
                    showMarkerTypes.contains(station.type) &&
                    !(station.type.isTideCurrent && station.isLegacy);

                for (final station
                    in widget.stations.values.where(stationFilter)) {
                  final icon = markerIcons.stations[station.type];
                  if (icon != null) {
                    // tp.js: create_station
                    final markerId = MarkerId(station.id.toString());
                    final visualMinor = [
                          station.isLegacy,
                          station.isSubordinate
                        ].indexOf(true) %
                        3;
                    final visualMajor = station.type.isTideCurrent ? 1 : 0;
                    markers.add(
                      Marker(
                        markerId: markerId,
                        position: station.marker,
                        alpha: (1 + visualMinor) / 3,
                        icon: icon,
                        infoWindow: InfoWindow(
                          title: station.typedShortTitle,
                          onTap: kIsWeb
                              ? null
                              : () => _gmap!.hideMarkerInfoWindow(markerId),
                        ),
                        // In tp.js, this is 4 for current stations and 3 for
                        // everything else. However, on smaller screens we
                        // should try to keep touch response consistent with
                        // alpha.
                        zIndex: (3 + 3 * visualMajor + visualMinor).toDouble(),
                        onTap: () => widget.onStationSelected?.call(station),
                      ),
                    );
                  }
                }

                // tp.js: create_sel_marker
                void createSelectionMarker(
                  MarkerId id,
                  BitmapDescriptor icon,
                  LatLng? location,
                ) =>
                    markers.add(
                      Marker(
                        markerId: id,
                        anchor: const Offset(.5, .65),
                        icon: icon,
                        // tp.js: move_sel_marker
                        position: location ?? const LatLng(0, 0),
                        visible: location != null,
                        zIndex: 1,
                      ),
                    );

                createSelectionMarker(
                  const MarkerId('sel'),
                  markerIcons.selected,
                  widget.selectedStation?.marker,
                );

                createSelectionMarker(
                  const MarkerId('tc_sel'),
                  markerIcons.tcSelected,
                  Optional(widget.selectedStation?.tideCurrentStationId)
                      .map((tcid) => widget.stations[tcid]?.marker),
                );
              }

              return FutureBuilder(
                future: locationEnabled,
                builder: (context, locationEnabledSnapshot) => GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: Map.initialCameraPosition,
                  markers: markers,
                  myLocationEnabled: locationEnabledSnapshot.data ?? false,
                  tileOverlays: {
                    TileOverlay(
                      tileOverlayId: chartOverlay.id,
                      tileProvider: chartOverlay.tileProvider,
                      tileSize: tileSize,
                    ),
                  },
                  onCameraMove: (position) =>
                      setState(() => zoom = position.zoom.toInt()),
                  onMapCreated: (controller) async {
                    setState(() => _gmap = controller);
                    controller.setMapStyle(
                      await DefaultAssetBundle.of(context)
                          .loadString('assets/nautical-style.json'),
                    );
                  },
                ),
              );
            },
          ),
        ),
        if (_gmap != null)
          Positioned(
            top: 64,
            bottom: 115,
            right: 10,
            child: FittedBox(
              alignment: Alignment.bottomLeft,
              fit: BoxFit.scaleDown,
              child: PointerInterceptor(
                child: _LodControls(
                  zoom: zoom,
                  lod: chartOverlay.tileProvider.levelOfDetail,
                  maxOversample: chartOverlay.tileProvider.maxOversample,
                  setLod: _setLod,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _gmap?.dispose();
    for (final overlay in chartOverlays) {
      overlay.tileProvider.dispose();
    }
  }
}

// TODO: tooltip text
// TODO: consistent weight with Maps zoom buttons (Material font doesn't support weight for these symbols)
// TODO: consistent size with Maps zoom buttons? may need to replace them with our own
class _LodControls extends StatelessWidget {
  const _LodControls({
    required this.lod,
    required this.zoom,
    required this.maxOversample,
    required this.setLod,
  });
  final int lod, zoom, maxOversample;
  final void Function(int) setLod;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey.shade800,
            fixedSize: const Size.square(40),
            minimumSize: const Size.square(40),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.zero,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xffe6e6e6),
          space: 1,
          thickness: 1,
          indent: 5,
          endIndent: 5,
        ),
      ),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        child: SizedBox(
          width: 40,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: lod < zoom + maxOversample
                    ? () => setLod(max(lod, zoom) + 1)
                    : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/lodinc.png'),
                    const Icon(Icons.add)
                  ],
                ),
              ),
              const Divider(),
              _HoverButton(
                onPressed: () => setLod(lod == 0 ? zoom : 0),
                childBuilder: (_, hover) => Icon(
                  lod == 0
                      ? hover
                          ? Icons.lock_outlined
                          : Icons.lock_open
                      : Icons.sync,
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: lod > zoom
                    ? () => setLod(min(lod, zoom + maxOversample) - 1)
                    : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/loddec.png'),
                    const Icon(Icons.remove)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HoverButton extends StatefulWidget {
  const _HoverButton({this.onPressed, required this.childBuilder});
  final void Function()? onPressed;
  final Widget Function(BuildContext, bool hover) childBuilder;

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onHover: (value) => setState(() => hover = value),
      onPressed: widget.onPressed,
      child: widget.childBuilder(context, hover),
    );
  }
}
