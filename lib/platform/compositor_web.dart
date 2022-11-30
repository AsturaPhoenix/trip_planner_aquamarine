// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';

import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class CompositorImage {
  static Future<CompositorImage> decode(Uint8List data) async {
    final image = ImageElement(src: Url.createObjectUrl(Blob([data])));
    try {
      await image.decode();
    } on DomException {
      // This can fail transiently under high parallelism, so retry once.
      await image.decode();
    }
    return CompositorImage(image);
  }

  CompositorImage(this._image);
  final ImageElement _image;

  CompositorImage clone() => this;
  void dispose() {}
}

class Compositor {
  Compositor(this.size) : _canvas = CanvasElement(width: size, height: size) {
    _g = _canvas.context2D;
  }

  final int size;
  final CanvasElement _canvas;
  late final CanvasRenderingContext2D _g;

  void save() => _g.save();
  void restore() => _g.restore();
  void scale(double factor) => _g.scale(factor, factor);

  void composite(CompositorImage image, Rect src, Rect dst) =>
      _g.drawImageScaledFromSource(
        image._image,
        src.left,
        src.top,
        src.width,
        src.height,
        dst.left,
        dst.top,
        dst.width,
        dst.height,
      );

  Future<Image> toImage() async => WebImage(_canvas);
}
