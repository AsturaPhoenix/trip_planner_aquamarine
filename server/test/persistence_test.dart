import 'dart:async';
import 'dart:io';

import 'package:aquamarine_server/persistence.dart';
import 'package:aquamarine_server_interface/types.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([
  MockSpec<IOOverrides>(),
  MockSpec<File>(),
  MockSpec<IOSink>(),
])
import 'persistence_test.mocks.dart';

void main() {
  test('releases mutexes on incomplete read', () async {
    final io = MockIOOverrides();

    await IOOverrides.runWithIOOverrides(() async {
      final persistence = Persistence();

      final latlngFile = MockFile();
      when(io.createFile(any)).thenReturn(latlngFile);
      when(latlngFile.exists()).thenAnswer((_) async => true);
      when(latlngFile.openRead())
          .thenAnswer((_) => StreamController<List<int>>().stream);

      // Make sure that if we cancel the IO stream, we don't hold onto the read
      // lock and can write to the file later.
      final stream = await persistence.readLatLng(Hex32.zero);
      await stream!.listen(null).cancel();

      final latlngWrite = MockIOSink();
      when(latlngFile.openWrite()).thenReturn(latlngWrite);

      await persistence.writeLatLng(Hex32.zero, Stream.empty());
    }, io);
  });
}
