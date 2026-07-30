import 'dart:io';
import 'dart:async';
import 'package:doc_scanner/ads/app_open.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:provider/provider.dart';

import 'ads/app_open_ad_manager.dart';
import 'app.dart';
import 'core/constants/debug_flags.dart';
import 'core/providers/connectivity_provider.dart';
import 'core/services/locale_service.dart';
import 'core/services/remote_config_service.dart';
import 'features/home/providers/recent_documents_provider.dart';
import 'features/subscription/providers/subscription_provider.dart';
import 'features/credits/providers/credit_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
Future<void> requestConsentAndShowForm(VoidCallback onConsentHandled) async {
  ConsentRequestParameters params = ConsentRequestParameters();
  ConsentInformation consentInfo = ConsentInformation.instance;

  consentInfo.requestConsentInfoUpdate(
    params,
        () async {
      final status = await consentInfo.getConsentStatus();
      final isConsentRequired = await consentInfo.isConsentFormAvailable();

      if (isConsentRequired && status == ConsentStatus.required) {
        // Show consent form and wait for user action
        ConsentForm.loadConsentForm(
              (ConsentForm consentForm) {
            consentForm.show((FormError? formError) {
              // User has accepted or rejected, or form error
              onConsentHandled();
            });
          },
              (formError) {
            // Failed to load form, proceed but log error
            print('Consent form load error: ${formError.message}');
            onConsentHandled();
          },
        );
      } else {
        // Consent not required (non-EEA), or already handled
        onConsentHandled();
      }
    },
        (FormError error) {
      // Handle consent info update error if needed
      print('Consent info update error: \\${error.message}');
      onConsentHandled();
    },
  );
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await RemoteConfigService.initialize();
  await MobileAds.instance.initialize();
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  final completer = Completer<void>();
  requestConsentAndShowForm(() {
    completer.complete();
  });
  await completer.future;
  final connectivityProvider = ConnectivityProvider();
  await connectivityProvider.initialize();

  final localeService = LocaleService();
  await localeService.initialize();

  final subscriptionProvider = SubscriptionProvider();
  await subscriptionProvider.initialize();

  final creditProvider = CreditProvider(
    subscriptionProvider: subscriptionProvider,
  );
  await creditProvider.initialize();

  if (!kReleaseMode && kDebugForcePro) {
    await subscriptionProvider.debugSetPro(true);
  }

  // AppOpenAdService.instance.configure(
  //   shouldShowAds: () => !subscriptionProvider.isPro,
  // );

  if(!subscriptionProvider.isPro){
    AppOpenAdManager.instance.loadAd();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppOpenAdManager.instance.startListening();
    });
  }

  if (Platform.isAndroid) {
    await MediaStore.ensureInitialized();
    MediaStore.appFolder = 'DocScanner';
    // if (!subscriptionProvider.isPro) {
    //   NativeAdLanguageCache.instance.ensureLoaded(
    //     isOnline: connectivityProvider.isOnline,
    //   );
    // }
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
        ChangeNotifierProvider.value(value: creditProvider),
      ],
      // Root par fuzool MediaQuery hata kar AppLifecycleObserver ko clean wrap kiya
      child: DocScannerApp(),
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
