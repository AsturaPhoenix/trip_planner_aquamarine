import 'dart:typed_data';
import 'dart:ui';

import 'compositor_sky.dart' if (dart.library.html) 'compositor_web.dart'
    as impl;

abstract class CompositorImage {
  static Future<CompositorImage> Function(Uint8List data) decode =
      impl.CompositorImage.decode;

  CompositorImage clone();
  void dispose();
}

abstract class Compositor {
  factory Compositor(int size) => impl.Compositor(size);

  int get size;

  void save();
  void restore();
  void scale(double factor);

  void composite(CompositorImage image, Rect src, Rect dst);
  Future<Image> toImage();
}
