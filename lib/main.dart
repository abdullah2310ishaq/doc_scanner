import 'dart:io';

import 'package:doc_scanner/ads/app_open.dart';
import 'package:doc_scanner/ads/native_ad_language.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/constants/debug_flags.dart';
import 'core/providers/connectivity_provider.dart';
import 'core/services/locale_service.dart';
import 'features/home/providers/recent_documents_provider.dart';
import 'features/subscription/providers/subscription_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();

  final connectivityProvider = ConnectivityProvider();
  await connectivityProvider.initialize();

  final localeService = LocaleService();
  await localeService.initialize();

  final subscriptionProvider = SubscriptionProvider();
  await subscriptionProvider.initialize();

  if (!kReleaseMode && kDebugForcePro) {
    await subscriptionProvider.debugSetPro(true);
  }

  AppOpenAdService.instance.configure(
    shouldShowAds: () => !subscriptionProvider.isPro,
  );

  if (Platform.isAndroid) {
    await MediaStore.ensureInitialized();
    MediaStore.appFolder = 'DocScanner';
    if (!subscriptionProvider.isPro) {
      NativeAdLanguageCache.instance.ensureLoaded(
        isOnline: connectivityProvider.isOnline,
      );
    }
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: connectivityProvider),
        ChangeNotifierProvider.value(value: localeService),
        ChangeNotifierProvider(
          create: (_) => RecentDocumentsProvider()..loadSummary(),
        ),
        ChangeNotifierProvider.value(value: subscriptionProvider),
      ],
      // Root par fuzool MediaQuery hata kar AppLifecycleObserver ko clean wrap kiya
      child: const AppLifecycleObserver(child: DocScannerApp()),
    ),
  );
}

/// Global Lifecycle Observer Component jo App Open Ads ko trigger karega
class AppLifecycleObserver extends StatefulWidget {
  final Widget child;
  const AppLifecycleObserver({super.key, required this.child});

  @override
  State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver> {
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    AppOpenAdService.instance.loadAd();

    _lifecycleListener = AppLifecycleListener(
      onHide: AppOpenAdService.instance.onAppHidden,
      onShow: AppOpenAdService.instance.onAppShown,
    );
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
