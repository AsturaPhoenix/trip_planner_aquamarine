import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// Most browsers won't surface a location permission request unless we're using
/// https.
final bool canRequestLocation =
    !kIsWeb || Uri.base.scheme == 'https' || Uri.base.host == 'localhost';

Future<bool> requestPermission() => _permissionRequest.fetch(
      () async {
        final wasEnabled = _isEnabled;
        final oldPermissionStatus = _permissionStatus;
        _isEnabled = kIsWeb ||
            (_permissionStatus = await Permission.locationWhenInUse.request())
                .isGranted;

        if (oldPermissionStatus != _permissionStatus) {
          _permissionStatusStream.add(_permissionStatus);
        }

        if (_passivePositionListeners > 0 && wasEnabled != _isEnabled) {
          if (_isEnabled) {
            _subscribePassivePosition();
          } else {
            _passivePositionSubscription!.cancel();
            _position = null;
            _passivePosition.add(null);
          }
        }
        return _isEnabled;
      },
    );
final _permissionRequest = AsyncCache<bool>.ephemeral();

bool get isEnabled => _isEnabled;
bool _isEnabled = false;
PermissionStatus? get permissionStatus => _permissionStatus;
PermissionStatus? _permissionStatus;
final Stream<PermissionStatus?> permissionStatusStream =
    _permissionStatusStream.stream;
final _permissionStatusStream = StreamController<PermissionStatus?>.broadcast();

final Stream<Position?> requestedPosition = Stream.multi(
  (controller) async => controller.addStream(
    await requestPermission()
        ? passivePosition.skipWhile((position) => position == null)
        : passivePosition,
  ),
);

final Stream<Position?> passivePosition = Stream.multi((controller) {
  if (_passivePositionListeners++ == 0 && _isEnabled) {
    _subscribePassivePosition();
  }
  controller.onCancel = () {
    if (--_passivePositionListeners == 0 && _isEnabled) {
      _passivePositionSubscription!.cancel();
    }
  };
  controller.add(_position);
  controller.addStream(_passivePosition.stream);
});

void _subscribePassivePosition() {
  _passivePositionSubscription =
      Geolocator.getPositionStream().listen((position) {
    _position = position;
    _passivePosition.add(position);
  });
}

int _passivePositionListeners = 0;
StreamSubscription? _passivePositionSubscription;
Position? get position => _position;
Position? _position;
final _passivePosition = StreamController<Position?>.broadcast();
