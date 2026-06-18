import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../core/providers/connectivity_provider.dart';
import 'ad_unit_ids.dart';
import 'native_ad_sizes.dart';

/// Native ad for the home screen — same compact layout as language screen.
class NativeAdHome extends StatefulWidget {
  const NativeAdHome({super.key});

  @override
  State<NativeAdHome> createState() => _NativeAdHomeState();
}

class _NativeAdHomeState extends State<NativeAdHome> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;

  static final String _androidTestAdUnitId = AdUnitIds.native;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _loadAd();
    }
  }

  void _loadAd() {
    _nativeAd = NativeAd(
      adUnitId: _androidTestAdUnitId,
      factoryId: 'listTileLanguage',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() => _isLoaded = true);
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = context.watch<ConnectivityProvider>().isOnline;
    if (!isOnline || !_isLoaded || _nativeAd == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        height: NativeAdSizes.bannerHeight,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AdWidget(ad: _nativeAd!),
        ),
      ),
    );
  }
}
