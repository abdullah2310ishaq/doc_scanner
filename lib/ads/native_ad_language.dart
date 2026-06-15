import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Native ad for the language picker — uses Android factory [listTileLanguage].
class NativeAdLanguage extends StatefulWidget {
  const NativeAdLanguage({super.key});

  @override
  State<NativeAdLanguage> createState() => _NativeAdLanguageState();
}

class _NativeAdLanguageState extends State<NativeAdLanguage> {
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
    if (!_isLoaded || _nativeAd == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 118.h,
      width: double.infinity,
      child: AdWidget(ad: _nativeAd!),
    );
  }
}
