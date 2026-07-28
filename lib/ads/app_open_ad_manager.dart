import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/services/remote_config_service.dart';
import 'ad_unit_ids.dart';



class AppOpenAdManager with WidgetsBindingObserver {
  static final AppOpenAdManager instance = AppOpenAdManager._internal();
  AppOpenAdManager._internal();

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  DateTime? _loadTime;

  // --- NEW: route & background guards ---
  final Set<String> blockedRoutes = {
    '/paywall',
    '/camera',
    '/video_fullscreen',
    '/checkout',
  };
  final Duration minBackground = const Duration(seconds: 2);
  bool _sawPause = false;
  DateTime? _pausedAt;

  final String adUnitId = AdIds.testAppOpenId; // test ID

  Future<void> loadAd() async {
    if (isAdAvailable) return;

    await AppOpenAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _loadTime = DateTime.now();
          debugPrint("✅ App Open Ad loaded");
        },
        onAdFailedToLoad: (error) {
          debugPrint("❌ Failed to load App Open Ad: $error");
        },
      ),
    );
  }

  bool get isAdAvailable {
    return _appOpenAd != null &&
        DateTime.now().difference(_loadTime ?? DateTime(2000)).inHours < 4;
  }

  void showAdIfAvailable() async{
    // if (PremiumStatus.isPremium) return;

    if (!isAdAvailable || _isShowingAd) {
      loadAd();
      return;
    }

    // Get.dialog(
    //    Center(
    //     child: Container(
    //       height: 120,
    //       width: 120,
    //
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(16),
    //       ),
    //       child:  Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           SizedBox(
    //             height: 28,
    //             width: 28,
    //             child: CircularProgressIndicator(
    //               color: Color(0xff4973FE),
    //               strokeWidth: 3,
    //             ),
    //           ),
    //           SizedBox(height: 14),
    //           Text(
    //             'Loading Ad...'.tr,
    //             textAlign: TextAlign.center,
    //             style: TextStyle(fontSize: 14,color: AppColors.blackClr,
    //               fontWeight: FontWeight.w500,
    //               fontFamily: 'Tirra',
    //               decoration: TextDecoration.none,
    //
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   barrierDismissible: false,
    // );
    //
    // await Future.delayed(const Duration(seconds: 2));
    //
    // if (Get.isDialogOpen ?? false) {
    //   Get.back();
    // }





    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        debugPrint("✅ App Open Ad showing");
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        _appOpenAd = null;
        ad.dispose();
        loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        _appOpenAd = null;
        ad.dispose();
        loadAd();
      },
    );

    _appOpenAd!.show();
  }

  // Attach / detach lifecycle observer
  void startListening() {
    WidgetsBinding.instance.addObserver(this);
  }

  void stopListening() {
    WidgetsBinding.instance.removeObserver(this);
  }

  // bool _isRouteBlocked() {
  //   final route = Get.currentRoute; // requires GetMaterialApp
  //   final blocked = blockedRoutes.contains(route);
  //   if (blocked) {
  //     debugPrint("⛔️ App Open Ad blocked on route: $route");
  //   }
  //   return blocked;
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Track a REAL background via 'paused'
    if (state == AppLifecycleState.paused) {
      _sawPause = true;
      _pausedAt = DateTime.now();
      return;
    }



    // final premium2Controller =   Get.find<PremiumScreen2Controller>();
    // final premium1Controller =   Get.find<PremiumScreen1Controller>();
    // final bool showAppOpen = RemoteConfigService.instance.cacheAppOpenAd;
    // if (PremiumStatus.isPremium) return;

      // if(showAppOpen){
        if (state == AppLifecycleState.resumed) {
          // 1) Skip if we didn't see a 'paused' state (e.g., notification shade is inactive→resumed)
          if (!_sawPause) {
            debugPrint("🪟 Resumed without pause (likely notification shade) → skip ad");
            return;
          }
          //
          // // 2) Enforce minimum time in background
          // final pausedFor = DateTime.now().difference(_pausedAt ?? DateTime.now());
          // if (pausedFor < minBackground) {
          //   debugPrint("⏱️ Background too short (${pausedFor.inMilliseconds}ms) → skip ad");
          //   _resetPauseFlags();
          //   return;
          // }

          // // 3) Route-level blocking
          // if (_isRouteBlocked()) {
          //   _resetPauseFlags();
          //   return;
          // }

          debugPrint("🔄 App resumed from real background → try showing App Open Ad");
          showAdIfAvailable();
          _resetPauseFlags();
        // }
      // }

    }







  }

  void _resetPauseFlags() {
    _sawPause = false;
    _pausedAt = null;
  }
}