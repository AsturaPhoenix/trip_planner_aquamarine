import 'dart:typed_data';
import 'dart:ui';

import 'compositor.dart' as ifc;

class CompositorImage implements ifc.CompositorImage {
  static Future<CompositorImage> decode(Uint8List data) async {
    final buffer = await ImmutableBuffer.fromUint8List(data);
    final ImageDescriptor imageDescriptor;
    try {
      imageDescriptor = await ImageDescriptor.encoded(buffer);
    } finally {
      buffer.dispose();
    }

    try {
      final codec = await imageDescriptor.instantiateCodec();
      try {
        return CompositorImage((await codec.getNextFrame()).image);
      } finally {
        codec.dispose();
      }
    } finally {
      imageDescriptor.dispose();
    }
  }

  CompositorImage(this._image);
  final Image _image;

  @override
  CompositorImage clone() => CompositorImage(_image.clone());
  @override
  void dispose() => _image.dispose();
}

class Compositor implements ifc.Compositor {
  static final _paint = Paint();

  Compositor(this.size) : _pictureRecorder = PictureRecorder() {
    _canvas = Canvas(_pictureRecorder);
  }

  @override
  final int size;

  final PictureRecorder _pictureRecorder;
  late final Canvas _canvas;

  @override
  void save() => _canvas.save();
  @override
  void restore() => _canvas.restore();
  @override
  void scale(double factor) => _canvas.scale(factor);

  @override
  void composite(ifc.CompositorImage image, Rect src, Rect dst) => _canvas
      .drawImageRect((image as CompositorImage)._image, src, dst, _paint);

  @override
  Future<Image> toImage() {
    final picture = _pictureRecorder.endRecording();
    try {
      return picture.toImage(size, size);
    } finally {
      picture.dispose();
    }
  }
}
