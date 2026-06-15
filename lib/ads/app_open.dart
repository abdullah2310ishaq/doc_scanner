import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdService {
  // Google ki official testing App Open Ad ID Android ke liye
  final String _adUnitId = 'ca-app-pub-3940256099942544/9257395921';

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  /// Ad ko cache/background mein preload karne ke liye function
  void loadAd() {
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

  /// Check karna ke kya memory mein ad preloaded betha hai ya nahi
  bool get isAdAvailable => _appOpenAd != null;

  /// Ad ko bina kisi delay ya restriction ke screen par show karne ka logic
  void showAdIfAvailable() {
    // 1. Agar ad preloaded nahi hai, to naya load karo aur skip karo
    if (!isAdAvailable) {
      loadAd();
      return;
    }

    // 2. Agar koi ad pehle se screen par open hai, to dobara trigger mat karo
    if (_isShowingAd) {
      return;
    }

    // Full screen callbacks set karna taake states manage ho sakein
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd(); // Agli dafa ke liye naya ad cache mein preload kar lo
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
