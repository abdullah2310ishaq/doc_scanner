import 'package:flutter/material.dart';

import 'paywall.dart';

class PaywallRoutes {
  PaywallRoutes._();

  static Future<void> openManualPaywall(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => const ProAccessScreen(
          nextScreen: SizedBox.shrink(),
          initialTrialEnabled: false,
          showAdOnClose: false,
          replaceOnExit: false,
        ),
      ),
    );
  }

  /// Paywall then interstitial on close — used before gated features.
  static Future<void> openFeatureGate(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => const ProAccessScreen(
          nextScreen: SizedBox.shrink(),
          initialTrialEnabled: false,
          showAdOnClose: true,
          replaceOnExit: false,
        ),
      ),
    );
  }

  /// Shown after OCR analysis for free users — paywall then interstitial on close.
  static Future<void> openOcrGate(BuildContext context) =>
      openFeatureGate(context);
}
