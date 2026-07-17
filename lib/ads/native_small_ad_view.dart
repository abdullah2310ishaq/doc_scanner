import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../features/subscription/providers/subscription_provider.dart';
import 'ad_unit_ids.dart';

class NativeMediumAdView extends StatefulWidget {
  const NativeMediumAdView({super.key});

  @override
  State<NativeMediumAdView> createState() => _NativeMediumAdViewState();
}

class _NativeMediumAdViewState extends State<NativeMediumAdView> {
  NativeAd? nativeAd;
  bool isLoadedNativeAd = false;

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
    if (nativeAd == null && !isLoadedNativeAd) {
      loadAds();
    }
  }

  void _disposeAd() {
    nativeAd?.dispose();
    nativeAd = null;
    isLoadedNativeAd = false;
  }

  Future<void> loadAds() async {
    nativeAd = NativeAd(
      adUnitId: AdIds.testNativeId,
      factoryId: 'listTileLanguage',
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (!mounted) return;
          setState(() {
            isLoadedNativeAd = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          if (!mounted) return;
          setState(() {
            isLoadedNativeAd = false;
          });
          debugPrint('err ${err.message}');
        },
      ),
      request: const AdRequest(),
    );
    await nativeAd!.load();
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

    final ad = nativeAd;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        // borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.navbarGradientStart.withValues(alpha: 0.07),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      width: double.infinity,
      height: isLoadedNativeAd && ad != null ? 120 : 120,
      child: isLoadedNativeAd && ad != null
          ? AdWidget(ad: ad)
          : const Center(
              child: CircularProgressIndicator(
                color: AppColors.navbarGradientStart,
              ),
            ),
    );
  }
}
