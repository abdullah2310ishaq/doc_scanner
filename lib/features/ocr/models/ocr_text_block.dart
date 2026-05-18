import 'dart:ui';

class OcrTextBlock {
  const OcrTextBlock({
    required this.text,
    required this.boundingBox,
  });

  final String text;
  final Rect boundingBox;
}
