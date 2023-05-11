// Mocks generated by Mockito 5.4.0 from annotations
// in aquamarine_server/test/aquamarine_server_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:aquamarine_server/ofs_client.dart' as _i6;
import 'package:aquamarine_server/persistence/v2.dart' as _i9;
import 'package:aquamarine_server/types.dart' as _i4;
import 'package:aquamarine_server_interface/types.dart' as _i5;
import 'package:file/file.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFileSystem_1 extends _i1.SmartFake implements _i3.FileSystem {
  _FakeFileSystem_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSimulationTime_2 extends _i1.SmartFake
    implements _i4.SimulationTime {
  _FakeSimulationTime_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHex32_3 extends _i1.SmartFake implements _i5.Hex32 {
  _FakeHex32_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [OfsClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockOfsClient extends _i1.Mock implements _i6.OfsClient {
  @override
  _i2.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
        returnValueForMissingStub: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
      ) as _i2.Client);
  @override
  _i7.Future<_i2.ByteStream?> fetchResource(
    _i4.SimulationTime? s,
    List<String>? query,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchResource,
          [
            s,
            query,
          ],
        ),
        returnValue: _i7.Future<_i2.ByteStream?>.value(),
        returnValueForMissingStub: _i7.Future<_i2.ByteStream?>.value(),
      ) as _i7.Future<_i2.ByteStream?>);
  @override
  _i7.Future<_i7.Stream<_i8.Uint8List>?> fetchLatLng(_i4.SimulationTime? s) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchLatLng,
          [s],
        ),
        returnValue: _i7.Future<_i7.Stream<_i8.Uint8List>?>.value(),
        returnValueForMissingStub:
            _i7.Future<_i7.Stream<_i8.Uint8List>?>.value(),
      ) as _i7.Future<_i7.Stream<_i8.Uint8List>?>);
  @override
  _i7.Future<_i6.OfsUvData?> fetchUv(_i4.SimulationTime? s) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchUv,
          [s],
        ),
        returnValue: _i7.Future<_i6.OfsUvData?>.value(),
        returnValueForMissingStub: _i7.Future<_i6.OfsUvData?>.value(),
      ) as _i7.Future<_i6.OfsUvData?>);
}

/// A class which mocks [Persistence].
///
/// See the documentation for Mockito's code generation for more information.
class MockPersistence extends _i1.Mock implements _i9.Persistence {
  @override
  _i3.FileSystem get fileSystem => (super.noSuchMethod(
        Invocation.getter(#fileSystem),
        returnValue: _FakeFileSystem_1(
          this,
          Invocation.getter(#fileSystem),
        ),
        returnValueForMissingStub: _FakeFileSystem_1(
          this,
          Invocation.getter(#fileSystem),
        ),
      ) as _i3.FileSystem);
  @override
  bool get allClosed => (super.noSuchMethod(
        Invocation.getter(#allClosed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i7.Future<bool> latlngFileExists(_i5.Hex32? hash) => (super.noSuchMethod(
        Invocation.method(
          #latlngFileExists,
          [hash],
        ),
        returnValue: _i7.Future<bool>.value(false),
        returnValueForMissingStub: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<void> verifyLatLng({
    _i3.File? file,
    _i5.Hex32? hash,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #verifyLatLng,
          [],
          {
            #file: file,
            #hash: hash,
          },
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<_i7.Stream<List<int>>?> readLatLng(_i5.Hex32? hash) =>
      (super.noSuchMethod(
        Invocation.method(
          #readLatLng,
          [hash],
        ),
        returnValue: _i7.Future<_i7.Stream<List<int>>?>.value(),
        returnValueForMissingStub: _i7.Future<_i7.Stream<List<int>>?>.value(),
      ) as _i7.Future<_i7.Stream<List<int>>?>);
  @override
  _i7.Future<void> writeLatLng(
    _i5.Hex32? hash,
    _i7.Stream<List<int>>? stream,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #writeLatLng,
          [
            hash,
            stream,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<_i9.UvReader?> readUv(_i5.HourUtc? t) => (super.noSuchMethod(
        Invocation.method(
          #readUv,
          [t],
        ),
        returnValue: _i7.Future<_i9.UvReader?>.value(),
        returnValueForMissingStub: _i7.Future<_i9.UvReader?>.value(),
      ) as _i7.Future<_i9.UvReader?>);
  @override
  _i7.Future<void> writeUv(
    _i4.SimulationTime? s,
    _i5.Hex32? latlngHash,
    _i7.Stream<List<int>>? vectorBytes,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #writeUv,
          [
            s,
            latlngHash,
            vectorBytes,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> writeSimulationTimes() => (super.noSuchMethod(
        Invocation.method(
          #writeSimulationTimes,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> migrate() => (super.noSuchMethod(
        Invocation.method(
          #migrate,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}

/// A class which mocks [UvReader].
///
/// See the documentation for Mockito's code generation for more information.
class MockUvReader extends _i1.Mock implements _i9.UvReader {
  @override
  _i4.SimulationTime get simulationTime => (super.noSuchMethod(
        Invocation.getter(#simulationTime),
        returnValue: _FakeSimulationTime_2(
          this,
          Invocation.getter(#simulationTime),
        ),
        returnValueForMissingStub: _FakeSimulationTime_2(
          this,
          Invocation.getter(#simulationTime),
        ),
      ) as _i4.SimulationTime);
  @override
  _i7.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<_i5.Hex32> readLatLngHash() => (super.noSuchMethod(
        Invocation.method(
          #readLatLngHash,
          [],
        ),
        returnValue: _i7.Future<_i5.Hex32>.value(_FakeHex32_3(
          this,
          Invocation.method(
            #readLatLngHash,
            [],
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i5.Hex32>.value(_FakeHex32_3(
          this,
          Invocation.method(
            #readLatLngHash,
            [],
          ),
        )),
      ) as _i7.Future<_i5.Hex32>);
  @override
  _i7.Future<_i8.Uint8List> readVectorBytes(int? index) => (super.noSuchMethod(
        Invocation.method(
          #readVectorBytes,
          [index],
        ),
        returnValue: _i7.Future<_i8.Uint8List>.value(_i8.Uint8List(0)),
        returnValueForMissingStub:
            _i7.Future<_i8.Uint8List>.value(_i8.Uint8List(0)),
      ) as _i7.Future<_i8.Uint8List>);
}
