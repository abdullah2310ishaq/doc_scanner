import 'dart:ui';

import 'ocr_text_block.dart';

class OcrAnalyzeResult {
  const OcrAnalyzeResult({
    required this.imagePath,
    required this.fullText,
    required this.blocks,
    required this.imageSize,
  });

  final String imagePath;
  final String fullText;
  final List<OcrTextBlock> blocks;
  final Size imageSize;
}
