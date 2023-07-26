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

Future<bool> requestPermission() =>
    PlatformLocation._instance.requestPermission();
InitializedValueStream<bool> get isEnabled =>
    PlatformLocation._instance.isEnabled;
ValueStream<PermissionStatus> get permissionStatus =>
    PlatformLocation._instance.permissionStatus;
Stream<Position?> get requestedPosition =>
    PlatformLocation._instance.requestedPosition;
ValueStream<Position?> get passivePosition =>
    PlatformLocation._instance.passivePosition;

class PlatformLocation {
  static PlatformLocation _instance = PlatformLocation();

  @visibleForTesting
  static void reset() => _instance = PlatformLocation();

  Future<bool> requestPermission() => _permissionRequest.fetch(
        () async {
          final wasEnabled = isEnabled.value;
          if (kIsWeb) {
            _isEnabled.add(true);
          } else {
            _permissionStatus.add(await Permission.locationWhenInUse.request());
            _isEnabled.add(permissionStatus.value!.isGranted);
          }

          if (_passivePosition.streamController.hasListener &&
              wasEnabled != isEnabled.value) {
            if (isEnabled.value) {
              _subscribePassivePosition();
            } else {
              _passivePositionSubscription!.cancel();
              _passivePosition.add(null);
            }
          }
          return isEnabled.value;
        },
      );
  final _permissionRequest = AsyncCache<bool>.ephemeral();

  late final isEnabled = _isEnabled.valueStream;
  final _isEnabled = InitializedValueStreamController<bool>(
    StreamController.broadcast(),
    false,
  );
  late final permissionStatus = _permissionStatus.valueStream;
  final _permissionStatus =
      ValueStreamController<PermissionStatus>(StreamController.broadcast());

  late final Stream<Position?> requestedPosition = Stream.multi(
    (controller) async {
      try {
        return controller.addStream(
          await requestPermission()
              ? passivePosition.seededStream
                  .skipWhile((position) => position == null)
              : passivePosition.seededStream,
        );
      } catch (e, s) {
        controller.addError(e, s);
      }
    },
  );

  late final passivePosition =
      _passivePosition.valueStream.transform((s, _) => s.refCount());

  StreamSubscription? _passivePositionSubscription;
  late final _passivePosition = ValueStreamController<Position?>(
    StreamController.broadcast(
      onListen: () {
        if (isEnabled.value) {
          _subscribePassivePosition();
        }
      },
      onCancel: () {
        if (isEnabled.value) {
          _passivePositionSubscription!.cancel();
        }
      },
    ),
  );

  void _subscribePassivePosition() {
    _passivePositionSubscription =
        Geolocator.getPositionStream().listen(_passivePosition.add);
  }
}
