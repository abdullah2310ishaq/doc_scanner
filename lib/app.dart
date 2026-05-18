import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/navigation/app_navigator.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/app_exit_guard.dart';
import 'core/widgets/connectivity_listener.dart';
import 'features/home/screens/main_shell_screen.dart';
import 'l10n/app_localizations.dart';

class DocScannerApp extends StatelessWidget {
  const DocScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: appNavigatorKey,
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
        return ConnectivityListener(
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const AppExitGuard(
        child: MainShellScreen(),
      ),
    );
  }
}
