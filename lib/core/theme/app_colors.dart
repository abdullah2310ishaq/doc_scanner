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
  static const double searchRadius = 14;

  static const Color cardOcrBg = Color(0xFFF2F1FD);
  static const Color cardPdfBg = Color(0xFFFFEFE4);
  static const Color cardChatbotBg = Color(0xFFECE7FB);
  static const Color chatbotAccent = proBadgeStart;
  static const Color chatbotSheetPdfBg = Color(0xFFEEF3FF);
  static const Color chatbotSheetRecentBg = Color(0xFFF2EEFB);
  static const double chatbotSheetRadius = 24;
  static const double chatbotSheetOptionRadius = 16;
  static const Color cardCropBg = Color(0xFFDCF0E0);

  static const Color ocrInputLiveBg = Color(0xFFE9F2FF);
  static const Color ocrInputUploadBg = Color(0xFFE8F8F0);
  static const double ocrInputSheetRadius = 24;
  static const double ocrInputOptionRadius = 14;

  static const Color liveCameraBackground = Color(0xFF000000);
  static const Color liveCameraOverlay = Color(0x33FFFFFF);
  static const Color liveCameraText = white;
  static const Color liveCameraTextMuted = Color(0xB3FFFFFF);
  static const Color liveCameraReticle = white;

  /// Smart crop live camera — black until document detected, then green.
  static const Color smartCropReticleIdle = Color(0xFF1A1A1A);
  static const Color smartCropReticleDetected = Color(0xFF22C55E);

  /// Smart crop review UI — white canvas, blue actions (design mock).
  static const Color smartCropCanvas = white;
  static const Color smartCropSoftBackground = Color(0xFFF9FAFD);
  static const Color smartCropPrimary = Color(0xFF5D5FEF);
  static const Color smartCropRetakeBackground = Color(0xFFEEEEFF);
  static const Color smartCropRetakeBorder = Color(0xFFDCDDFF);
  static const Color smartCropRetakeText = Color(0xFF4343FF);
  static const Color smartCropFrameBorder = smartCropPrimary;
  static const Color liveCameraShutterRing = Color(0xFF7B61FF);
  static const Color liveCameraTipBorder = Color(0x4DFFFFFF);

  static const Color ocrHighlightFill = Color(0x661567FF);
  static const Color ocrAnalyzeActionBg = white;
  static const Color ocrAnalyzeActionText = Color(0xFF6E6A6A);
  static const Color ocrAnalyzeActionBorder = Color(0xFF6E6A6A);
  static const double ocrAnalyzeActionRadius = 24;

  static const Color translateCardBorder = Color(0xFFE8EAED);
  static const double translateCardRadius = 12;
  static const Color translateSectionTitle = textLink;
  static const Color translateSavePngBg = Color(0xFFEEF3FF);
  static const Color translateSavePngBorder = Color(0xFFD6E4FF);
  static const Color translateDownloadSelectedBg = Color(0xFFE9F2FF);
  static const Color translateDownloadCompleteBg = Color(0xFFF2EEFB);
  static const double translateDownloadSheetRadius = 24;
  static const double translateDownloadOptionRadius = 16;

  static const LinearGradient translatePrimaryGradient = LinearGradient(
    colors: [navbarGradientStart, navbarGradientEnd],
  );

  /// Onboarding CTA — CSS: `linear-gradient(91.01deg, #1766FE 1.27%, #635CF1 53.96%)`.
  static const Color onboardingCtaGradientStart = Color(0xFF1766FE);
  static const Color onboardingCtaGradientEnd = Color(0xFF635CF1);

  static final LinearGradient onboardingCtaGradient = cssLinearGradient(
    degrees: 91.01,
    colors: [onboardingCtaGradientStart, onboardingCtaGradientEnd],
    stops: [0.0127, 0.5396],
  );

  static const double featureCardRadius = 6;

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
