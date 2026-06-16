import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../core/providers/connectivity_provider.dart';
import 'native_ad_sizes.dart';

/// Keeps one language-screen native ad in memory for the app session.
class NativeAdLanguageCache {
  NativeAdLanguageCache._();

  static final NativeAdLanguageCache instance = NativeAdLanguageCache._();

  static const String _androidTestAdUnitId =
      'ca-app-pub-7182112310194934/4683489221';

  NativeAd? _nativeAd;
  bool _isLoaded = false;
  bool _isLoading = false;
  final List<VoidCallback> _listeners = [];

  bool get isLoaded => _isLoaded && _nativeAd != null;

  NativeAd? get nativeAd => _nativeAd;

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
    if (isLoaded) {
      listener();
    }
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void ensureLoaded({required bool isOnline}) {
    if (!Platform.isAndroid || !isOnline || isLoaded || _isLoading) {
      return;
    }

    _isLoading = true;
    _nativeAd = NativeAd(
      adUnitId: _androidTestAdUnitId,
      factoryId: 'listTileLanguage',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          _isLoaded = true;
          _isLoading = false;
          _notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _nativeAd = null;
          _isLoaded = false;
          _isLoading = false;
        },
      ),
    )..load();
  }

  void _notifyListeners() {
    for (final listener in List<VoidCallback>.from(_listeners)) {
      listener();
    }
  }
}

/// Native ad for the language picker — uses Android factory [listTileLanguage].
class NativeAdLanguage extends StatefulWidget {
  const NativeAdLanguage({super.key});

  @override
  State<NativeAdLanguage> createState() => _NativeAdLanguageState();
}

class _NativeAdLanguageState extends State<NativeAdLanguage> {
  final NativeAdLanguageCache _cache = NativeAdLanguageCache.instance;

  @override
  void initState() {
    super.initState();
    _cache.addListener(_onCacheUpdated);
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryLoadAd());
  }

  void _tryLoadAd() {
    if (!mounted) {
      return;
    }

    final isOnline = context.read<ConnectivityProvider>().isOnline;
    _cache.ensureLoaded(isOnline: isOnline);
  }

  @override
  void dispose() {
    _cache.removeListener(_onCacheUpdated);
    super.dispose();
  }

  void _onCacheUpdated() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = context.watch<ConnectivityProvider>().isOnline;
    if (!isOnline) {
      return const SizedBox.shrink();
    }

    final ad = _cache.nativeAd;
    if (!_cache.isLoaded || ad == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: NativeAdSizes.bannerHeight,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AdWidget(ad: ad),
      ),
    );
  }
}
