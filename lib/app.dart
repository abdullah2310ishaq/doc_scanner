import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'ads/back_inter_ad_navigator_observer.dart';
import 'core/navigation/app_navigator.dart';
import 'core/services/locale_service.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/connectivity_listener.dart';
import 'features/launch/screens/splash_screen.dart';
import 'l10n/app_localizations.dart';

class DocScannerApp extends StatelessWidget {
  const DocScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleService>(
      builder: (context, localeService, _) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: appNavigatorKey,
              navigatorObservers: [
                appRouteObserver,
                backInterAdNavigatorObserver,
              ],
              locale: localeService.locale,
              onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
              theme: AppTheme.light,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) {
                final mediaQuery = MediaQuery.of(context);
                return MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaler: TextScaler.noScaling,
                    padding: mediaQuery.viewPadding,
                  ),
                  child: ConnectivityListener(
                    child: child ?? const SizedBox.shrink(),
                  ),
                );
              },
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
