import 'dart:typed_data';

import 'package:aquamarine_server_interface/types.dart';

import '../types.dart';

abstract class UvReader {
  SimulationTime get simulationTime;

  Future<void> close();
  Future<Hex32> readLatLngHash();
  Future<Uint8List> readVectorBytes(int index);
}

abstract class Persistence {
  Future<bool> latlngFileExists(Hex32 hash);
  Future<Stream<List<int>>?> readLatLng(Hex32 hash);
  Future<UvReader?> readUv(HourUtc t);
  Future<void> writeLatLng(Hex32 hash, Stream<List<int>> stream);
  Future<void> writeUv(
      SimulationTime s, Hex32 latlngHash, Stream<List<int>> vectorBytes);
}
