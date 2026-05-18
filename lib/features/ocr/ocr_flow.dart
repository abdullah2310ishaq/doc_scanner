import 'package:flutter/material.dart';

import 'screens/ocr_analyze_screen.dart';
import 'services/image_picker_service.dart';

abstract final class OcrFlow {
  static Future<void> pickImageAndAnalyze(
    BuildContext context, {
    bool replaceCurrentRoute = false,
  }) async {
    final imagePath = await ImagePickerService().pickImageFromGallery();
    if (imagePath == null || !context.mounted) return;
    await OcrAnalyzeScreen.open(
      context,
      imagePath: imagePath,
      replaceCurrentRoute: replaceCurrentRoute,
    );
  }

  static Future<void> analyzeImage(
    BuildContext context, {
    required String imagePath,
    bool replaceCurrentRoute = false,
  }) {
    return OcrAnalyzeScreen.open(
      context,
      imagePath: imagePath,
      replaceCurrentRoute: replaceCurrentRoute,
    );
  }
}
