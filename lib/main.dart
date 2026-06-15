import 'dart:io';

import 'package:doc_scanner/ads/app_open.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/providers/connectivity_provider.dart';
import 'core/services/locale_service.dart';
import 'features/home/providers/recent_documents_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  if (Platform.isAndroid) {
    await MediaStore.ensureInitialized();
    MediaStore.appFolder = 'DocScanner';
  }

  final connectivityProvider = ConnectivityProvider();
  await connectivityProvider.initialize();

  final localeService = LocaleService();
  await localeService.initialize();

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
      ],
      // Yahan DocScannerApp ko AppLifecycleObserver ke andar wrap kar diya hai
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
  late final AppOpenAdService _adService;
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    // App ke start hote hi pehla ad background cache mein load hona shuru ho jayega
    _adService = AppOpenAdService()..loadAd();

    // Modern Flutter Lifecycle Listener Setup
    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        // User jab bhi camera, gallery ya background se wapas screen par aayega, instant ad chalega
        _adService.showAdIfAvailable();
      },
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
