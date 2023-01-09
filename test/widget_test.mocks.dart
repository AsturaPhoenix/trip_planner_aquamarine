// Mocks generated by Mockito 5.3.3-dev from annotations
// in trip_planner_aquamarine/test/widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:convert' as _i7;
import 'dart:typed_data' as _i5;

import 'package:http/http.dart' as _i2;
import 'package:joda/time.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart'
    as _i9;
import 'package:plugin_platform_interface/plugin_platform_interface.dart'
    as _i8;
import 'package:trip_planner_aquamarine/providers/trip_planner_client.dart'
    as _i3;

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

class _FakeUri_1 extends _i1.SmartFake implements Uri {
  _FakeUri_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_3 extends _i1.SmartFake
    implements _i2.StreamedResponse {
  _FakeStreamedResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TripPlannerHttpClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockTripPlannerHttpClient extends _i1.Mock
    implements _i3.TripPlannerHttpClient {
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
  Uri get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _FakeUri_1(
          this,
          Invocation.getter(#baseUrl),
        ),
        returnValueForMissingStub: _FakeUri_1(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as Uri);
  @override
  Uri get datapointsUrl => (super.noSuchMethod(
        Invocation.getter(#datapointsUrl),
        returnValue: _FakeUri_1(
          this,
          Invocation.getter(#datapointsUrl),
        ),
        returnValueForMissingStub: _FakeUri_1(
          this,
          Invocation.getter(#datapointsUrl),
        ),
      ) as Uri);
  @override
  Uri get tidesUrl => (super.noSuchMethod(
        Invocation.getter(#tidesUrl),
        returnValue: _FakeUri_1(
          this,
          Invocation.getter(#tidesUrl),
        ),
        returnValueForMissingStub: _FakeUri_1(
          this,
          Invocation.getter(#tidesUrl),
        ),
      ) as Uri);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<Map<_i3.StationId, _i3.Station>> getDatapoints() =>
      (super.noSuchMethod(
        Invocation.method(
          #getDatapoints,
          [],
        ),
        returnValue: _i4.Future<Map<_i3.StationId, _i3.Station>>.value(
            <_i3.StationId, _i3.Station>{}),
        returnValueForMissingStub:
            _i4.Future<Map<_i3.StationId, _i3.Station>>.value(
                <_i3.StationId, _i3.Station>{}),
      ) as _i4.Future<Map<_i3.StationId, _i3.Station>>);
  @override
  _i4.Future<_i5.Uint8List> getTideGraph(
    _i3.Station? station,
    int? days,
    int? width,
    int? height,
    _i6.Date? begin,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTideGraph,
          [
            station,
            days,
            width,
            height,
            begin,
          ],
        ),
        returnValue: _i4.Future<_i5.Uint8List>.value(_i5.Uint8List(0)),
        returnValueForMissingStub:
            _i4.Future<_i5.Uint8List>.value(_i5.Uint8List(0)),
      ) as _i4.Future<_i5.Uint8List>);
  @override
  _i4.Future<String> getTideCurrentStationDetails(_i3.Station? station) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTideCurrentStationDetails,
          [station],
        ),
        returnValue: _i4.Future<String>.value(''),
        returnValueForMissingStub: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i2.Client {
  @override
  _i4.Future<_i2.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<String>.value(''),
        returnValueForMissingStub: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<_i5.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i5.Uint8List>.value(_i5.Uint8List(0)),
        returnValueForMissingStub:
            _i4.Future<_i5.Uint8List>.value(_i5.Uint8List(0)),
      ) as _i4.Future<_i5.Uint8List>);
  @override
  _i4.Future<_i2.StreamedResponse> send(_i2.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i4.Future<_i2.StreamedResponse>.value(_FakeStreamedResponse_3(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.StreamedResponse>.value(_FakeStreamedResponse_3(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i4.Future<_i2.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [PermissionHandlerPlatform].
///
/// See the documentation for Mockito's code generation for more information.
class MockPermissionHandlerPlatform extends _i1.Mock
    with _i8.MockPlatformInterfaceMixin
    implements _i9.PermissionHandlerPlatform {
  @override
  _i4.Future<_i9.PermissionStatus> checkPermissionStatus(
          _i9.Permission? permission) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkPermissionStatus,
          [permission],
        ),
        returnValue:
            _i4.Future<_i9.PermissionStatus>.value(_i9.PermissionStatus.denied),
        returnValueForMissingStub:
            _i4.Future<_i9.PermissionStatus>.value(_i9.PermissionStatus.denied),
      ) as _i4.Future<_i9.PermissionStatus>);
  @override
  _i4.Future<_i9.ServiceStatus> checkServiceStatus(
          _i9.Permission? permission) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkServiceStatus,
          [permission],
        ),
        returnValue:
            _i4.Future<_i9.ServiceStatus>.value(_i9.ServiceStatus.disabled),
        returnValueForMissingStub:
            _i4.Future<_i9.ServiceStatus>.value(_i9.ServiceStatus.disabled),
      ) as _i4.Future<_i9.ServiceStatus>);
  @override
  _i4.Future<bool> openAppSettings() => (super.noSuchMethod(
        Invocation.method(
          #openAppSettings,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<Map<_i9.Permission, _i9.PermissionStatus>> requestPermissions(
          List<_i9.Permission>? permissions) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestPermissions,
          [permissions],
        ),
        returnValue:
            _i4.Future<Map<_i9.Permission, _i9.PermissionStatus>>.value(
                <_i9.Permission, _i9.PermissionStatus>{}),
        returnValueForMissingStub:
            _i4.Future<Map<_i9.Permission, _i9.PermissionStatus>>.value(
                <_i9.Permission, _i9.PermissionStatus>{}),
      ) as _i4.Future<Map<_i9.Permission, _i9.PermissionStatus>>);
  @override
  _i4.Future<bool> shouldShowRequestPermissionRationale(
          _i9.Permission? permission) =>
      (super.noSuchMethod(
        Invocation.method(
          #shouldShowRequestPermissionRationale,
          [permission],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
