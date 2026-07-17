import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../features/subscription/providers/subscription_provider.dart';
import 'ad_unit_ids.dart';

class AdaptiveBannerAdView extends StatefulWidget {
  const AdaptiveBannerAdView({super.key});

  @override
  State<AdaptiveBannerAdView> createState() => _AdaptiveBannerAdViewState();
}

class _AdaptiveBannerAdViewState extends State<AdaptiveBannerAdView> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.read<SubscriptionProvider>().isPro) {
      _disposeAd();
      return;
    }
    if (_bannerAd == null && !_isLoaded) {
      _loadBanner();
    }
  }

  void _disposeAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _isLoaded = false;
  }

  Future<void> _loadBanner() async {
    final screenWidth = MediaQuery.of(context).size.width.truncate();

    final adSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      screenWidth,
    );

    if (adSize == null) {
      debugPrint('Unable to get adaptive banner size.');
      return;
    }

    final bannerAd = BannerAd(
      adUnitId: AdIds.testBannerId,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) return;

          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();

          if (!mounted) return;

          setState(() {
            _isLoaded = false;
          });

          debugPrint('Banner failed to load: ${error.message}');
        },
      ),
    );

    await bannerAd.load();
  }

  @override
  void dispose() {
    _disposeAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<SubscriptionProvider>().isPro) {
      return const SizedBox.shrink();
    }

    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.navbarGradientStart,
          ),
        ),
      );
    }

    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
