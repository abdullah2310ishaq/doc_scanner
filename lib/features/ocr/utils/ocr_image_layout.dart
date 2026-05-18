import 'dart:math' as math;
import 'dart:ui';

class OcrImageLayout {
  const OcrImageLayout({
    required this.displaySize,
    required this.offset,
    required this.scale,
  });

  final Size displaySize;
  final Offset offset;
  final double scale;

  static OcrImageLayout fromContainer({
    required Size imageSize,
    required Size containerSize,
  }) {
    if (imageSize.width <= 0 || imageSize.height <= 0) {
      return OcrImageLayout(
        displaySize: Size.zero,
        offset: Offset.zero,
        scale: 1,
      );
    }

    final widthScale = containerSize.width / imageSize.width;
    final heightScale = containerSize.height / imageSize.height;
    final scale = math.min(widthScale, heightScale);

    final displaySize = Size(
      imageSize.width * scale,
      imageSize.height * scale,
    );

    final offset = Offset(
      (containerSize.width - displaySize.width) / 2,
      (containerSize.height - displaySize.height) / 2,
    );

    return OcrImageLayout(
      displaySize: displaySize,
      offset: offset,
      scale: scale,
    );
  }

  Rect mapRect(Rect source) {
    return Rect.fromLTWH(
      offset.dx + source.left * scale,
      offset.dy + source.top * scale,
      source.width * scale,
      source.height * scale,
    );
  }
}
