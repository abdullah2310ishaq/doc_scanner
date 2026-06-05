import 'package:flutter/material.dart';

import 'pages/smart_crop_corner_adjust_screen.dart';
import 'pages/smart_crop_crop_processing_screen.dart';
import 'providers/smart_crop_session_provider.dart';

/// Captured → auto edge detect + crop → filters → PDF.
abstract final class SmartCropNavigation {
  static void goToCropProcessing(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) {
    if (session.isEmpty) return;

    // Live camera (ML Kit) and any already-scanned pages go straight through.
    if (session.allPagesAlreadyScanned) {
      SmartCropCropProcessingScreen.open(context, pages: session.pages);
      return;
    }

    // Gallery: if we are unsure about corners, let user confirm once.
    if (session.anyPageNeedsCornerReview) {
      SmartCropCornerAdjustScreen.open(context, session: session);
      return;
    }

    SmartCropCropProcessingScreen.open(context, pages: session.pages);
  }
}
