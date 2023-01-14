import 'package:camera/camera.dart' as camera;
import 'package:flutter/widgets.dart';

class CameraController extends ValueNotifier<camera.CameraController?> {
  CameraController(this.description, this.resolutionPreset) : super(null);

  Future<camera.CameraDescription?> description;
  camera.ResolutionPreset resolutionPreset;
  bool isPreviewPaused = false;

  Future<camera.CameraController?>? _init;

  void stop() {
    isPreviewPaused = true;
    // pausePreview and resumePreview may fail if the camera controller was
    // disposed while the operation was in progress. We can safely ignore that
    // case since the camera controller will be recreated the next time we need
    // it.
    value?.pausePreview().ignore();
  }

  start() {
    isPreviewPaused = false;
    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      _init ??= _initialize();
      value?.resumePreview().ignore();
    }
  }

  Future<camera.CameraController?> _initialize() async {
    final description = await this.description;
    if (description == null) return null;

    final value = camera.CameraController(
      description,
      resolutionPreset,
      enableAudio: false,
    );

    await value.initialize();
    if (isPreviewPaused) {
      value.pausePreview().ignore();
    }
    this.value = value;
    return value;
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      await _init;
      // Guard against race; camera platform impls (e.g. Android) may only allow
      // one concurrent instance at a time, so we can't easily cancel and start
      // a fresh initialization. We could dispose and reinitialize in sequence,
      // but it's unclear whether that's the best way to handle things. For now,
      // if the app resumed while initialization was still completing, hope for
      // the best.
      if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
        return;
      }
      value?.dispose();
      value = null;
      _init = null;
    } else if (state == AppLifecycleState.resumed) {
      _init ??= _initialize();
    }
  }

  @override
  Future<void> dispose() async {
    (await _init)?.dispose();
    super.dispose();
  }
}
