/// Google official demo ad unit IDs for development and testing.
/// Replace with production IDs before release.
abstract final class AdUnitIds {
  static const String _androidAppOpen =
      'ca-app-pub-3940256099942544/9257395921';
  static const String _androidBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const String _androidInterstitial =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _androidNative = 'ca-app-pub-3940256099942544/2247696110';

  static String get appOpen => _androidAppOpen;

  static String get banner => _androidBanner;

  static String get interstitial => _androidInterstitial;

  static String get native => _androidNative;
}
