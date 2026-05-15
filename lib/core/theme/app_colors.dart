import 'dart:math' as math;

import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color navbarGradientStart = Color(0xFF1567FF);
  static const Color navbarGradientEnd = Color(0xFF645CF1);

  static const LinearGradient navbarGradient = LinearGradient(
    begin: Alignment(-0.9998, -0.0317),
    end: Alignment(0.9998, 0.0317),
    colors: [navbarGradientStart, navbarGradientEnd],
    stops: [0.0032, 0.9702],
  );

  static const double navbarRadius = 8;

  // —— Home hero card (CSS: 108.97deg, #205CDB → #735CF3) ——
  static const Color homeHeroGradientStart = Color(0xFF205CDB);
  static const Color homeHeroGradientEnd = Color(0xFF735CF3);

  static const LinearGradient homeHeroGradient = LinearGradient(
    begin: Alignment(-0.946, -0.325),
    end: Alignment(0.946, 0.325),
    colors: [homeHeroGradientStart, homeHeroGradientEnd],
    stops: [0.0103, 1.0],
  );

  static const double homeHeroRadius = 16;
  static const double homeHeroButtonRadius = 8;

  static const Color white = Color(0xFFFFFFFF);
  static const Color textOnPrimary = white;
  static const Color scaffoldBackground = Color(0xFFF8F9FC);

  static const Color textPrimary = Color(0xFF1A1D26);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLink = Color(0xFF1567FF);

  static const Color proBadgeStart = Color(0xFF7B61FF);
  static const Color proBadgeEnd = Color(0xFF4F8CFF);

  static const LinearGradient proBadgeGradient = LinearGradient(
    colors: [proBadgeStart, proBadgeEnd],
  );

  static const Color scannerHighlightBg = Color(0xFFF0EFFF);
  static const Color scannerBracket = Color(0xFF4F7CFF);

  static const Color tagBackground = Color(0xFFF3F4F6);
  static const Color tagBorder = Color(0xFFE5E7EB);

  static const Color searchFill = Color(0xFFFFFFFF);
  static const Color searchBorder = Color(0xFFE8EAED);

  static const Color cardOcrBg = Color(0xFFF1F0FF);
  static const Color cardPdfBg = Color(0xFFFFF1E6);
  static const Color cardChatbotBg = Color(0xFFF0EFFF);
  static const Color cardCropBg = Color(0xFFE8F5E9);

  static const Color cardOcrIcon = Color(0xFF5B6CFF);
  static const Color cardPdfIcon = Color(0xFFFF8A3D);
  static const Color cardChatbotIcon = Color(0xFF7B61FF);
  static const Color cardCropIcon = Color(0xFF43A047);

  static const Color documentCardBg = Color(0xFFFFFFFF);
  static const Color documentCardBorder = Color(0xFFEEEEEE);
  static const Color pdfIconBg = Color(0xFFE8F5E9);
  static const Color pdfIconColor = Color(0xFF2E7D32);

  static const Color cardShadow = Color(0x0F000000);

  /// Builds a [LinearGradient] from a CSS `linear-gradient(deg, ...)` angle.
  static LinearGradient cssLinearGradient({
    required double degrees,
    required List<Color> colors,
    List<double>? stops,
  }) {
    final radians = degrees * math.pi / 180;
    final x = math.sin(radians);
    final y = -math.cos(radians);
    return LinearGradient(
      begin: Alignment(-x, -y),
      end: Alignment(x, y),
      colors: colors,
      stops: stops,
    );
  }
}
