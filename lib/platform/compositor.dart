import 'dart:typed_data';
import 'dart:ui';

class CompositorImage {
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

  CompositorImage clone() => CompositorImage(_image.clone());
  void dispose() => _image.dispose();
}

class Compositor {
  static final _paint = Paint();

  Compositor(this.size) : _pictureRecorder = PictureRecorder() {
    _canvas = Canvas(_pictureRecorder);
  }

  final int size;
  final PictureRecorder _pictureRecorder;
  late final Canvas _canvas;

  void save() => _canvas.save();
  void restore() => _canvas.restore();
  void scale(double factor) => _canvas.scale(factor);

  void composite(CompositorImage image, Rect src, Rect dst) =>
      _canvas.drawImageRect(image._image, src, dst, _paint);

  Future<Image> toImage() {
    final picture = _pictureRecorder.endRecording();
    try {
      return picture.toImage(size, size);
    } finally {
      picture.dispose();
    }
  }
}
