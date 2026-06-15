import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Native ad for the home screen — uses Android factory [listTileMedium].
class NativeAdHome extends StatefulWidget {
  const NativeAdHome({super.key});

  @override
  State<NativeAdHome> createState() => _NativeAdHomeState();
}

class _NativeAdHomeState extends State<NativeAdHome> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;

  static const String _androidTestAdUnitId =
      'ca-app-pub-3940256099942544/2247696110';

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
      factoryId: 'listTileMedium',
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
    if (!_isLoaded || _nativeAd == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: AdWidget(ad: _nativeAd!),
      ),
    );
  }
}
