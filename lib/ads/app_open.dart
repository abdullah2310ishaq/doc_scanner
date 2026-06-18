import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_unit_ids.dart';

/// App open ads — only when user returns from background, not on cold start
/// or right after splash interstitial.
class AppOpenAdService {
  AppOpenAdService._();

  static final AppOpenAdService instance = AppOpenAdService._();

  final String _adUnitId = AdUnitIds.appOpen;

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  bool _hasHandledColdStart = false;
  bool _isInBackground = false;
  bool _blockNextForegroundShow = false;

  bool get isAdAvailable => _appOpenAd != null;

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

    showAdIfAvailable();
  }

  void loadAd() {
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
}
