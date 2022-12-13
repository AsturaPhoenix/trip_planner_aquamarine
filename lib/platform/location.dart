import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../util/value_stream.dart';

/// Most browsers won't surface a location permission request unless we're using
/// https.
final bool canRequestLocation =
    !kIsWeb || Uri.base.scheme == 'https' || Uri.base.host == 'localhost';

Future<bool> requestPermission() => _permissionRequest.fetch(
      () async {
        final wasEnabled = _isEnabled;
        if (kIsWeb) {
          _isEnabled = true;
        } else {
          _permissionStatus.add(await Permission.locationWhenInUse.request());
          _isEnabled = permissionStatus.value!.isGranted;
        }

        if (_passivePosition.streamController.hasListener &&
            wasEnabled != _isEnabled) {
          if (_isEnabled) {
            _subscribePassivePosition();
          } else {
            _passivePositionSubscription!.cancel();
            _passivePosition.add(null);
          }
        }
        return _isEnabled;
      },
    );
final _permissionRequest = AsyncCache<bool>.ephemeral();

bool get isEnabled => _isEnabled;
bool _isEnabled = false;
final permissionStatus = _permissionStatus.valueStream;
final _permissionStatus =
    ValueStreamController<PermissionStatus>(StreamController.broadcast());

final Stream<Position?> requestedPosition = Stream.multi(
  (controller) async => controller.addStream(
    await requestPermission()
        ? passivePosition.seededStream.skipWhile((position) => position == null)
        : passivePosition.seededStream,
  ),
);

final passivePosition = _passivePosition.valueStream;

StreamSubscription? _passivePositionSubscription;
Position? get position => _position;
Position? _position;
final _passivePosition = ValueStreamController<Position?>(
  StreamController.broadcast(
    onListen: () {
      if (_isEnabled) {
        _subscribePassivePosition();
      }
    },
    onCancel: () {
      if (_isEnabled) {
        _passivePositionSubscription!.cancel();
      }
    },
  ),
  (stream) => stream.refCount(),
);

void _subscribePassivePosition() {
  _passivePositionSubscription =
      Geolocator.getPositionStream().listen((position) {
    _position = position;
    _passivePosition.add(position);
  });
}
