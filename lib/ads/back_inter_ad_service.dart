import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/remote_config_service.dart';
import '../features/subscription/providers/subscription_provider.dart';
import 'ad_unit_ids.dart';
import 'interstitial_ad_manager.dart';

/// Shows an interstitial every 3rd time the user returns to the home screen.
abstract final class BackInterAdService {
  static const int _showEvery = 3;

  /// Completed back-to-home events in the current cycle (0–2, then show on 3).
  static int _backCount = 0;
  static DateTime? _lastHandledAt;

  static Future<void> handleBackToHome(
    BuildContext context, {
    VoidCallback? onComplete,
  }) async {
    void finish() => onComplete?.call();

    final now = DateTime.now();
    if (_lastHandledAt != null &&
        now.difference(_lastHandledAt!) < const Duration(milliseconds: 500)) {
      finish();
      return;
    }
    _lastHandledAt = now;

    if (!RemoteConfigService.backInterAd) {
      finish();
      return;
    }

    if (context.read<SubscriptionProvider>().isPro) {
      finish();
      return;
    }

    _backCount++;
    if (_backCount < _showEvery) {
      finish();
      return;
    }

    _backCount = 0;
    await InterstitialAdManager.show(
      context: context,
      adUnitId: AdIds.testInterId,
      onComplete: finish,
    );
  }
}
