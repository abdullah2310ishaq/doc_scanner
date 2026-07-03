import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_unit_ids.dart';

/// App open ads — only when user returns from background, not on cold start
/// or right after splash interstitial.
class AppOpenAdService {
  AppOpenAdService._();

  static final AppOpenAdService instance = AppOpenAdService._();

  final String _adUnitId = AdIds.testAppOpenId;

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  bool _hasHandledColdStart = false;
  bool _isInBackground = false;
  bool _blockNextForegroundShow = false;
  bool Function()? _shouldShowAds;

  bool get isAdAvailable => _appOpenAd != null;

  /// When this returns false (e.g. Pro user), app-open ads are skipped.
  void configure({required bool Function() shouldShowAds}) {
    _shouldShowAds = shouldShowAds;
  }

  bool get _canShowAds => _shouldShowAds?.call() ?? true;

  /// Skip the next foreground show (e.g. right after splash interstitial).
  void blockNextForegroundShow() {
    _blockNextForegroundShow = true;
  }

  void onAppHidden() {
    _isInBackground = true;
  }

  void onAppShown() {
    if (!_hasHandledColdStart) {
      _hasHandledColdStart = true;
      return;
    }

    if (!_isInBackground) {
      return;
    }

    _isInBackground = false;

    if (_blockNextForegroundShow) {
      _blockNextForegroundShow = false;
      return;
    }

    if (!_canShowAds) {
      return;
    }

    showAdIfAvailable();
  }

  void loadAd() {
    if (!_canShowAds) {
      return;
    }
    if (_appOpenAd != null || _isShowingAd) {
      return;
    }

    AppOpenAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          _appOpenAd = null;
        },
      ),
    );
  }

  void showAdIfAvailable() {
    if (!_canShowAds) {
      return;
    }

    if (!isAdAvailable) {
      loadAd();
      return;
    }

    if (_isShowingAd) {
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );

    _appOpenAd!.show();
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

  Future<void> showSplashAdIfAvailable() async {
    if (!_canShowAds || !isAdAvailable || _isShowingAd) {
      return;
    }

    final ad = _appOpenAd;
    if (ad == null) {
      return;
    }

    final completer = Completer<void>();
    _hasHandledColdStart = true;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (shownAd) {
        _isShowingAd = true;
      },
      onAdDismissedFullScreenContent: (dismissedAd) {
        _isShowingAd = false;
        dismissedAd.dispose();
        _appOpenAd = null;
        loadAd();
        if (!completer.isCompleted) completer.complete();
      },
      onAdFailedToShowFullScreenContent: (failedAd, error) {
        _isShowingAd = false;
        failedAd.dispose();
        _appOpenAd = null;
        loadAd();
        if (!completer.isCompleted) completer.complete();
      },
    );

    ad.show();
    return completer.future;
  }
}
