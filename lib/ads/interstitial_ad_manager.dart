import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../core/utils/l10n_extension.dart';
import '../core/widgets/loading_dialog.dart';
import '../features/subscription/providers/subscription_provider.dart';

class InterstitialAdManager {
  InterstitialAdManager._();

  static bool _isShowingAd = false;
  static bool _isLoadingVisible = false;

  static void _showLoading(BuildContext context) {
    if (_isLoadingVisible) return;

    _isLoadingVisible = true;
    LoadingDialog.show(context, message: context.l10n.adLoading);
  }

  static void _hideLoading(BuildContext context) {
    if (!_isLoadingVisible) return;

    _isLoadingVisible = false;
    if (!context.mounted) return;

    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  /// Loads and shows an interstitial ad. Pass the ad unit id for the placement.
  /// [onComplete] runs after the ad is dismissed or if load/show fails.
  static Future<void> show({
    required BuildContext context,
    required String adUnitId,
    VoidCallback? onComplete,
  }) async {
    if (context.read<SubscriptionProvider>().isPro) {
      onComplete?.call();
      return;
    }

    if (_isShowingAd) {
      onComplete?.call();
      return;
    }

    final completer = Completer<void>();

    void finish() {
      onComplete?.call();
      if (!completer.isCompleted) {
        completer.complete();
      }
    }

    _showLoading(context);

    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (context.mounted) {
            _hideLoading(context);
          } else {
            _isLoadingVisible = false;
          }

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              _isShowingAd = true;
              debugPrint('✅ Interstitial ad showing');
            },
            onAdDismissedFullScreenContent: (ad) {
              _isShowingAd = false;
              ad.dispose();
              debugPrint('✅ Interstitial ad dismissed');
              finish();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              _isShowingAd = false;
              ad.dispose();
              debugPrint('❌ Interstitial ad failed to show: $error');
              finish();
            },
          );

          ad.show();
        },
        onAdFailedToLoad: (error) {
          if (context.mounted) {
            _hideLoading(context);
          } else {
            _isLoadingVisible = false;
          }
          debugPrint('❌ Failed to load interstitial ad: $error');
          finish();
        },
      ),
    );

    return completer.future;
  }
}
