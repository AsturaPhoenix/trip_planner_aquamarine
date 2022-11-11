import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/wms_tile_provider.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  MapState createState() {
    return MapState();
  }
}

class MapState extends State<Map> {
  final _nauticalTileProvider = WmsTileProvider(
      url: Uri.parse(
          'https://gis.charttools.noaa.gov/arcgis/rest/services/MCS/NOAAChartDisplay/MapServer/exts/MaritimeChartService/WMSServer'),
      fetchLod: 1,
      params: WmsParams()
        ..version = '1.3.0'
        ..layers = '0,1,2,3,4,5,6,7');

  @override
  Widget build(BuildContext context) {
    final tileSize = (MediaQuery.of(context).devicePixelRatio *
            WmsTileProvider.logicalTileSize)
        .ceil();
    _nauticalTileProvider.preferredTileSize = tileSize;

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: const CameraPosition(
        target: LatLng(37.7717, -122.2983), // Center on Alameda shoreline.
        zoom: 12,
      ),
      tileOverlays: {
        TileOverlay(
            tileOverlayId: const TileOverlayId('nautical'),
            tileProvider: _nauticalTileProvider,
            tileSize: tileSize)
      },
      onMapCreated: (controller) async => controller.setMapStyle(
          await DefaultAssetBundle.of(context)
              .loadString('assets/nautical-style.json')),
    );
  }
}
