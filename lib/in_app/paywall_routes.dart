import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/subscription/providers/subscription_provider.dart';
import 'paywall.dart';

class PaywallRoutes {
  PaywallRoutes._();

  static bool _isPro(BuildContext context) =>
      context.read<SubscriptionProvider>().isPro;

  static Future<void> openManualPaywall(BuildContext context) {
    if (_isPro(context)) {
      return Future<void>.value();
    }

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
    if (_isPro(context)) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => nextScreen),
      );
      return;
    }

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
    if (_isPro(context)) {
      return Future<void>.value();
    }

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
