import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/theme/app_colors.dart';
import 'ad_unit_ids.dart';

class InterstitialAdService {
  final String _adUnitId = AdUnitIds.interstitial;

  InterstitialAd? _interstitialAd;
  bool _isAvailable = false;
  bool _isLoading = false;

  bool get isAdAvailable => _isAvailable && _interstitialAd != null;

  void loadAd() {
    if (_isLoading || isAdAvailable) {
      return;
    }

    _isLoading = true;
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAvailable = true;
          _isLoading = false;
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isAvailable = false;
          _isLoading = false;
        },
      ),
    );
  }

  Future<bool> waitUntilReady({
    Duration timeout = const Duration(seconds: 5),
  }) async {
    if (isAdAvailable) {
      return true;
    }

    loadAd();

    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      if (isAdAvailable) {
        return true;
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }

    return isAdAvailable;
  }

  void showAdWithLoading({
    required BuildContext context,
    required String loadingMessage,
    required VoidCallback onAdDismissed,
  }) {
    if (!isAdAvailable) {
      loadAd();
      onAdDismissed();
      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Row(
              children: [
                const CircularProgressIndicator(color: AppColors.textLink),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    loadingMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future<void>.delayed(const Duration(milliseconds: 800), () {
      if (!context.mounted) {
        return;
      }

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      final ad = _interstitialAd;
      if (ad == null) {
        onAdDismissed();
        return;
      }

      ad.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (dismissedAd) {
          dismissedAd.dispose();
          _interstitialAd = null;
          _isAvailable = false;
          loadAd();
          onAdDismissed();
        },
        onAdFailedToShowFullScreenContent: (failedAd, error) {
          failedAd.dispose();
          _interstitialAd = null;
          _isAvailable = false;
          loadAd();
          onAdDismissed();
        },
      );

      ad.show();
    });
  }
}
