import 'package:flutter/material.dart';

import 'pages/smart_crop_corner_adjust_screen.dart';
import 'pages/smart_crop_crop_processing_screen.dart';
import 'providers/smart_crop_session_provider.dart';

/// Captured → corner adjust (gallery) → crop processing → filters → PDF.
abstract final class SmartCropNavigation {
  static void goToCropProcessing(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) {
    if (session.isEmpty) return;

    // Gallery uploads need edge detection + manual corners before crop/filters.
    if (session.allPagesAlreadyScanned) {
      SmartCropCropProcessingScreen.open(context, pages: session.pages);
      return;
    }

    SmartCropCornerAdjustScreen.open(context, session: session);
  }
}
