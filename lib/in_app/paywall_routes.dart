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

  /// Paywall + interstitial on close, then [nextScreen] (e.g. after processing).
  static void replaceWithPostProcessGate(
    BuildContext context, {
    required Widget nextScreen,
  }) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ProAccessScreen(
          nextScreen: nextScreen,
          initialTrialEnabled: false,
          showAdOnClose: true,
          replaceOnExit: true,
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
