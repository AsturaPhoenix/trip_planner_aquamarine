import 'dart:core';
import 'dart:core' as core;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:trip_planner_aquamarine/persistence/blob_cache.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';
import 'package:trip_planner_aquamarine/util/optional.dart';

import '../providers/wms_tile_provider.dart';

class Map extends StatefulWidget {
  static const minZoom = 0, maxZoom = 22;
  static const initialCameraPosition = CameraPosition(
    // Center map on Alcatraz, to show the interesting points around the Bay.
    target: LatLng(37.8331, -122.4165),
    zoom: 12,
  );

  // TODO: make this configurable
  static const showMarkerTypes = {
    StationType.tide,
    StationType.current,
    StationType.launch,
    StationType.destination,
  };

  Map({
    super.key,
    required this.client,
    required this.tileCache,
    this.stations = const {},
    this.selectedStation,
    double Function(StationType type)? stationPriority,
    this.onStationSelected,
    this.locationEnabled = false,
    this.onLocationRequest,
  }) : stationPriority =
            stationPriority ?? ((type) => type.isTideCurrent ? 1 : 0);

  final http.Client client;
  final BlobCache tileCache;
  final core.Map<StationId, Station> stations;
  final Station? selectedStation;

  final double Function(StationType type) stationPriority;
  final void Function(Station station)? onStationSelected;

  final bool locationEnabled;
  final Future<bool> Function()? onLocationRequest;

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
    required this.location,
  });
  final core.Map<StationType, BitmapDescriptor> stations;

  /// Halo for the selected location.
  final BitmapDescriptor selected,

      /// Halo for a nearby tide/current station, when the selected location is
      /// not tide/current.
      tcSelected,
      location;
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

class MarkerClass {
  static const double selection = 1, station = 3, currentLocation = 10;
}

class MapState extends State<Map> {
  static final log = Logger('MapState');

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
  Stream<Position>? positionStream;

  void animateToSelectedStation() {
    _gmap!
        .animateCamera(CameraUpdate.newLatLng(widget.selectedStation!.marker));
  }

  @override
  void initState() {
    super.initState();
    if (widget.locationEnabled) {
      positionStream = Geolocator.getPositionStream();
    }
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
      for (final stationType in Map.showMarkerTypes)
        loadAsset(stationType.name, defaultConfiguration)
    ];

    final selConfiguration =
        defaultConfiguration.copyWith(size: const Size(22, 21));
    final selected = loadAsset('sel', selConfiguration);
    final tcSelected = loadAsset('tc_sel', selConfiguration);

    final location = BitmapDescriptor.fromAssetImage(
      defaultConfiguration,
      'assets/markers/location.png',
    );

    _markerIcons = (() async => _MarkerIcons(
          stations: core.Map.fromIterables(
            Map.showMarkerTypes,
            await Future.wait(stations),
          ),
          selected: await selected,
          tcSelected: await tcSelected,
          location: await location,
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

    if (widget.locationEnabled && !oldWidget.locationEnabled) {
      positionStream = Geolocator.getPositionStream();
    } else if (oldWidget.locationEnabled && !widget.locationEnabled) {
      positionStream = null;
    }

    if (widget.selectedStation != null &&
        oldWidget.selectedStation == null &&
        _gmap != null) {
      animateToSelectedStation();
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

    return StreamBuilder(
      stream: positionStream,
      builder: (context, positionSnapshot) => Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
            future: _markerIcons,
            builder: (context, iconsSnapshot) {
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
                      icon: markerIcons.location,
                      // is shown.
                      infoWindow: InfoWindow(
                        title: formatPosition(position),
                        // No need for kIsWeb since we haven't implemented a
                        // location widget for web yet.
                        onTap: () => _gmap!.hideMarkerInfoWindow(markerId),
                      ),
                      // Take precedence over other markers.
                      zIndex: MarkerClass.currentLocation,
                    ),
                  );
                }

                // tp.js: show_hide_marker
                bool stationFilter(Station station) =>
                    Map.showMarkerTypes.contains(station.type) &&
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
                    final visualMajor = widget.stationPriority(station.type);

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
                        zIndex:
                            MarkerClass.station + 3 * visualMajor + visualMinor,
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
                        zIndex: MarkerClass.selection,
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

              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: Map.initialCameraPosition,
                markers: markers,
                tileOverlays: {
                  TileOverlay(
                    tileOverlayId: chartOverlay.id,
                    tileProvider: chartOverlay.tileProvider,
                    tileSize: tileSize,
                  ),
                },
                compassEnabled: false,
                zoomControlsEnabled: false,
                onCameraMove: (position) =>
                    setState(() => zoom = position.zoom.toInt()),
                onMapCreated: (controller) async {
                  setState(() => _gmap = controller);
                  controller.setMapStyle(
                    await DefaultAssetBundle.of(context)
                        .loadString('assets/nautical-style.json'),
                  );
                  if (widget.selectedStation != null) {
                    animateToSelectedStation();
                  }
                },
              );
            },
          ),
          if (_gmap != null)
            Theme(
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
                tooltipTheme: const TooltipThemeData(
                  waitDuration: Duration(milliseconds: 600),
                ),
                dividerTheme: const DividerThemeData(
                  color: Color(0xffe6e6e6),
                  space: 1,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: MapControls(
                  zoom: zoom,
                  lod: chartOverlay.tileProvider.levelOfDetail,
                  maxOversample: chartOverlay.tileProvider.maxOversample,
                  centerLocation: Optional(positionSnapshot.data).map(
                        (position) => () => _gmap!.animateCamera(
                              CameraUpdate.newLatLng(
                                LatLng(
                                  position.latitude,
                                  position.longitude,
                                ),
                              ),
                            ),
                      ) ??
                      Optional(widget.onLocationRequest).map(
                        (f) => () async {
                          await f();
                          final position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.medium,
                            timeLimit: const Duration(seconds: 10),
                          );
                          _gmap!.animateCamera(
                            CameraUpdate.newLatLng(
                              LatLng(position.latitude, position.longitude),
                            ),
                          );
                        },
                      ),
                  zoomIn: () => _gmap!.animateCamera(CameraUpdate.zoomIn()),
                  zoomOut: () => _gmap!.animateCamera(CameraUpdate.zoomOut()),
                  setLod: _setLod,
                ),
              ),
            ),
        ],
      ),
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

extension on List<Widget> {
  List<Widget> delimit(Widget delimiter) => [
        ...[
          for (final e in this) ...[delimiter, e]
        ].skip(1)
      ];
}

class MapControls extends StatelessWidget {
  const MapControls({
    super.key,
    this.zoom = 12,
    this.lod = 14,
    this.maxOversample = 0,
    this.centerLocation,
    this.zoomIn,
    this.zoomOut,
    required this.setLod,
  });
  final int zoom, lod, maxOversample;
  final void Function()? centerLocation;
  final void Function()? zoomIn, zoomOut;
  final void Function(int lod) setLod;

  @override
  Widget build(BuildContext context) {
    final locationControls = LocationControls(centerLocation: centerLocation);
    final zoomControls = MapButtonPanel(
      children: [
        Tooltip(
          message: 'Zoom in',
          child: TextButton(
            onPressed: zoom < Map.maxZoom ? zoomIn : null,
            child: const Icon(Icons.add),
          ),
        ),
        Tooltip(
          message: 'Zoom out',
          child: TextButton(
            onPressed: zoom > Map.minZoom ? zoomOut : null,
            child: const Icon(Icons.remove),
          ),
        ),
      ],
    );
    final lodControls = LodControls(
      zoom: zoom,
      lod: lod,
      maxOversample: maxOversample,
      setLod: setLod,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        const double buttonHeight = 40,
            spacing = 10,
            divider = 1,
            logo = 26,
            notices = kIsWeb ? 14 : 0;
        final wrap = constraints.maxHeight <
            6 * buttonHeight + 2 * spacing + logo + 3 * divider;

        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: logo),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    locationControls,
                    zoomControls,
                    if (!wrap) lodControls
                  ].delimit(const SizedBox(height: spacing)),
                ),
              ),
            ),
            if (wrap)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: notices),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: lodControls,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class MapButtonPanel extends StatelessWidget {
  const MapButtonPanel({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => PointerInterceptor(
        child: Card(
          elevation: 3,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          child: SizedBox(
            width: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children.delimit(const Divider()),
            ),
          ),
        ),
      );
}

class LocationControls extends StatelessWidget {
  const LocationControls({super.key, this.centerLocation});
  final void Function()? centerLocation;

  @override
  Widget build(BuildContext context) => MapButtonPanel(
        children: [
          Tooltip(
            message: 'My location',
            child: TextButton(
              onPressed: centerLocation,
              child: const Icon(Icons.my_location),
            ),
          )
        ],
      );
}

// TODO: tooltip text
// TODO: consistent weight with Maps zoom buttons (Material font doesn't support weight for these symbols)
// TODO: consistent size with Maps zoom buttons? may need to replace them with our own
class LodControls extends StatelessWidget {
  const LodControls({
    super.key,
    required this.lod,
    required this.zoom,
    required this.maxOversample,
    required this.setLod,
  });
  final int lod, zoom, maxOversample;
  final void Function(int) setLod;

  @override
  Widget build(BuildContext context) => MapButtonPanel(
        children: [
          Tooltip(
            message: 'Increase detail',
            child: TextButton(
              onPressed: lod < zoom + maxOversample
                  ? () => setLod(max(lod, zoom) + 1)
                  : null,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/lodinc.png',
                    opacity: const AlwaysStoppedAnimation(.625),
                    excludeFromSemantics: true,
                  ),
                  const Icon(Icons.add)
                ],
              ),
            ),
          ),
          Tooltip(
            message: lod == 0 ? 'Lock detail' : 'Reset detail',
            child: _HoverButton(
              onPressed: () => setLod(lod == 0 ? zoom : 0),
              childBuilder: (_, hover) => Icon(
                lod == 0
                    ? hover
                        ? Icons.lock_outlined
                        : Icons.lock_open
                    : Icons.sync,
              ),
            ),
          ),
          Tooltip(
            message: 'Decrease detail',
            child: TextButton(
              onPressed: lod > zoom
                  ? () => setLod(min(lod, zoom + maxOversample) - 1)
                  : null,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/loddec.png',
                    opacity: const AlwaysStoppedAnimation(.625),
                    excludeFromSemantics: true,
                  ),
                  const Icon(Icons.remove)
                ],
              ),
            ),
          ),
        ],
      );
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
