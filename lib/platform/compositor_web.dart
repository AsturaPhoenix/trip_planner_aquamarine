// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';

import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

import 'compositor.dart' as ifc;

class CompositorImage implements ifc.CompositorImage {
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

  @override
  CompositorImage clone() => this;
  @override
  void dispose() {}
}

class Compositor implements ifc.Compositor {
  Compositor(this.size) : _canvas = CanvasElement(width: size, height: size) {
    _g = _canvas.context2D;
  }

  @override
  final int size;
  final CanvasElement _canvas;
  late final CanvasRenderingContext2D _g;

  @override
  void save() => _g.save();
  @override
  void restore() => _g.restore();
  @override
  void scale(double factor) => _g.scale(factor, factor);

  @override
  void composite(ifc.CompositorImage image, Rect src, Rect dst) =>
      _g.drawImageScaledFromSource(
        (image as CompositorImage)._image,
        src.left,
        src.top,
        src.width,
        src.height,
        dst.left,
        dst.top,
        dst.width,
        dst.height,
      );

  @override
  Future<Image> toImage() async => WebImage(_canvas);
}
