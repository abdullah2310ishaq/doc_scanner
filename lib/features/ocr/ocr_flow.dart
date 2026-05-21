import 'package:flutter/material.dart';

import 'screens/ocr_analyze_screen.dart';
import 'services/document_scanner_service.dart';
import 'services/image_picker_service.dart';

/// Central entry point for all OCR flows.
///
/// Usage:
/// - [pickImageAndAnalyze]       → gallery picker → OCR
/// - [analyzeImage]              → direct image path → OCR
/// - [scanDocumentAndAnalyze]    → Google document scanner (Android) or
///                                 gallery picker (iOS) → OCR
abstract final class OcrFlow {
  /// Opens the system gallery picker. User selects an image, then OCR runs.
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

  /// Runs OCR directly on an image at [imagePath].
  /// Used after camera capture and from other features passing a file path.
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

  /// Launches the Google ML Kit Document Scanner (Android) or falls back to
  /// the gallery picker (iOS / unsupported).
  ///
  /// The document scanner gives:
  /// - Automatic edge detection
  /// - Perspective correction (de-warped pages)
  /// - Shadow and stain removal
  ///
  /// The resulting corrected image is then passed through the normal
  /// [MlKitOcrService] for text extraction, so all existing preprocessing
  /// (EXIF bake, contrast, upscale) still applies as a safety net.
  static Future<void> scanDocumentAndAnalyze(
    BuildContext context, {
    bool replaceCurrentRoute = false,
  }) async {
    if (!DocumentScannerService.isSupported) {
      // iOS / desktop: fall back to gallery picker.
      return pickImageAndAnalyze(
        context,
        replaceCurrentRoute: replaceCurrentRoute,
      );
    }

    final paths =
        await DocumentScannerService().scanDocument(pageLimit: 1);

    // User cancelled or an error occurred — do nothing.
    if (paths == null || paths.isEmpty || !context.mounted) return;

    await OcrAnalyzeScreen.open(
      context,
      imagePath: paths.first,
      replaceCurrentRoute: replaceCurrentRoute,
    );
  }
}
