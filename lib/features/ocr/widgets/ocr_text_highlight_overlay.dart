import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/ocr_text_block.dart';
import '../utils/ocr_image_layout.dart';

class OcrTextHighlightOverlay extends StatelessWidget {
  const OcrTextHighlightOverlay({
    super.key,
    required this.blocks,
    required this.layout,
  });

  final List<OcrTextBlock> blocks;
  final OcrImageLayout layout;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (final block in blocks)
          Positioned.fromRect(
            rect: layout.mapRect(block.boundingBox),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.ocrHighlightFill,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
      ],
    );
  }
}
