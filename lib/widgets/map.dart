import 'dart:developer' as debug;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:trip_planner_aquamarine/providers/asset_cache.dart';
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart';

import '../providers/wms_tile_provider.dart';

class Map extends StatefulWidget {
  const Map({super.key, this.stations = const {}, this.onStationSelect});

  final Set<Station> stations;
  final void Function(Station station)? onStationSelect;

  @override
  MapState createState() => MapState();
}

class TileOverlayConfiguration<T extends TileProvider> {
  final TileOverlayId id;
  final T tileProvider;
  TileOverlayConfiguration(String id, this.tileProvider)
      : id = TileOverlayId(id);
}

class MapState extends State<Map> {
  static const initialCameraPosition = CameraPosition(
    // Center map on Alcatraz, to show the interesting points around the Bay.
    target: LatLng(37.8331, -122.4165),
    zoom: 12,
  );

  final chartOverlays = [
    TileOverlayConfiguration(
      'nautical',
      WmsTileProvider(
        url: Uri.parse(
          'https://gis.charttools.noaa.gov/arcgis/rest/services/MCS/NOAAChartDisplay/MapServer/exts/MaritimeChartService/WMSServer',
        ),
        fetchLod: 1,
        params: WmsParams()
          ..version = '1.3.0'
          ..layers = '0,1,2,3,4,5,6,7',
      ),
    )
  ];
  GoogleMapController? _gmap;

  int zoom = initialCameraPosition.zoom.toInt();
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

  var _markerIcons = AssetCache<BitmapDescriptor>();

  @override
  Widget build(BuildContext context) {
    final tileSize = (MediaQuery.of(context).devicePixelRatio *
            WmsTileProvider.logicalTileSize)
        .ceil();

    for (final overlay in chartOverlays) {
      overlay.tileProvider.preferredTileSize = tileSize;
    }

    _markerIcons.beginBuild(context);

    final markers = <Marker>{};
    for (final station in widget.stations) {
      final icon = _markerIcons[station.type];
      if (icon != null) {
        // tp.js: create_station
        markers.add(
          Marker(
            markerId: MarkerId(station.id),
            position: station.marker,
            icon: icon,
            infoWindow: InfoWindow(title: station.typedShortTitle),
            onTap: () => widget.onStationSelect?.call(station),
          ),
        );
      }
    }

    _markerIcons
        .fetchIfNeeded(
      (configuration, stationType) => BitmapDescriptor.fromAssetImage(
        configuration,
        'assets/markers/$stationType.png',
        mipmaps: false,
      ),
    )
        .then(
      (cache) {
        if (cache != null) {
          setState(() => _markerIcons = cache);
        }
      },
      onError: (e, StackTrace s) => debug.log(
        'Exception while fetching marker icons.',
        name: 'MapState',
        error: e,
        stackTrace: s,
      ),
    );

    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          markers: markers,
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
        if (_gmap != null)
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 115),
            child: PointerInterceptor(
              child: _LodControls(
                zoom: zoom,
                lod: chartOverlay.tileProvider.levelOfDetail,
                maxOversample: chartOverlay.tileProvider.maxOversample,
                setLod: _setLod,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _gmap?.dispose();
    for (final overlay in chartOverlays) {
      overlay.tileProvider.dispose();
    }
    super.dispose();
  }
}

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
