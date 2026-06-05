import 'package:flutter/material.dart';

import 'pages/smart_crop_crop_processing_screen.dart';
import 'providers/smart_crop_session_provider.dart';

/// Captured → auto edge detect + crop → filters → PDF.
abstract final class SmartCropNavigation {
  static void goToCropProcessing(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) {
    if (session.isEmpty) return;

    // Gallery + camera: processing screen auto-detects edges and crops.
    SmartCropCropProcessingScreen.open(context, pages: session.pages);
  }
}
