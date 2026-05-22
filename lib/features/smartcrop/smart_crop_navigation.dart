import 'package:flutter/material.dart';

import 'pages/smart_crop_corner_adjust_screen.dart';
import 'pages/smart_crop_filters_screen.dart';
import 'providers/smart_crop_session_provider.dart';

/// Shared navigation after user taps Crop on captured screens.
abstract final class SmartCropNavigation {
  static void goToCropOrFilters(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) {
    if (session.allPagesAlreadyScanned) {
      final paths = session.pages.map((p) => p.imagePath).toList();
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => SmartCropFiltersScreen(imagePaths: paths),
        ),
      );
      return;
    }

    SmartCropCornerAdjustScreen.open(context, session: session);
  }
}
