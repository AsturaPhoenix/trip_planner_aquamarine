import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

class CameraManager extends ChangeNotifier {
  static final log = Logger('Camera');

  CameraManager(this.description, this.resolutionPreset);

  Future<CameraDescription?> description;
  ResolutionPreset resolutionPreset;
  bool isPreviewPaused = false;
  ConnectionState _connectionState = ConnectionState.none;
  ConnectionState get connectionState => _connectionState;
  CameraController? _controller;
  CameraController? get controller => _controller;

  Future<void>? _init;

  void stop() {
    isPreviewPaused = true;
    // pausePreview and resumePreview may fail if the camera controller was
    // disposed while the operation was in progress. We can safely ignore that
    // case since the camera controller will be recreated the next time we need
    // it.
    controller?.pausePreview().ignore();
  }

  void start() {
    isPreviewPaused = false;
    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      _initialize();
      controller?.resumePreview().ignore();
    }
  }

  void _initialize() {
    // Camera platform impls (e.g. Android) may only allow one concurrent
    // instance at a time.
    late Future<void> thisInit;
    thisInit = _init ??= () async {
      assert(controller == null);
      _connectionState = ConnectionState.waiting;
      notifyListeners();

      try {
        final description = await this.description;
        if (description == null) return;

        final value = CameraController(
          description,
          resolutionPreset,
          enableAudio: false,
        );

        await value.initialize();
        if (isPreviewPaused) {
          value.pausePreview().ignore();
        }
        _controller = value;
      } catch (e, s) {
        log.warning(null, e, s);
      } finally {
        _connectionState = ConnectionState.done;
        assert(_init == thisInit);
        notifyListeners();
      }
    }();
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
      if (controller != null) {
        controller!.dispose();
        _controller = null;
        _init = null;
        notifyListeners();
      }
      // If initialization failed, i.e. if controller was null, don't reset
      // _init because if it was due to permissions denied, this could rapidly
      // pause and resume the app; even if the permissions UI isn't shown, the
      // app seems to pause and resume on Android, which would kick off another
      // initialization attempt ad infinitum.
    } else if (state == AppLifecycleState.resumed) {
      _initialize();
    }
  }

  @override
  Future<void> dispose() async {
    await _init;
    controller?.dispose();
    super.dispose();
  }
}
