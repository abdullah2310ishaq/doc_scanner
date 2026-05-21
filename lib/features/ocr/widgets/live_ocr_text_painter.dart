import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/ocr_text_block.dart';

class LiveOcrTextPainter extends CustomPainter {
  const LiveOcrTextPainter({required this.blocks});

  final List<OcrTextBlock> blocks;

  @override
  void paint(Canvas canvas, Size size) {
    if (blocks.isEmpty) return;

    final fillPaint = Paint()
      ..color = AppColors.ocrHighlightFill
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = AppColors.navbarGradientStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (final block in blocks) {
      canvas.drawRect(block.boundingBox, fillPaint);
      canvas.drawRect(block.boundingBox, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant LiveOcrTextPainter oldDelegate) {
    // Avoid repaint if block count and individual rects all match.
    if (oldDelegate.blocks.length != blocks.length) return true;
    for (var i = 0; i < blocks.length; i++) {
      if (oldDelegate.blocks[i].boundingBox != blocks[i].boundingBox) {
        return true;
      }
    }
    return false;
  }
}
