import 'package:flutter/material.dart';

import '../core/navigation/app_navigator.dart';
import '../features/home/screens/main_shell_screen.dart';
import 'back_inter_ad_service.dart';

/// Counts only full-screen page pops back to [MainShellScreen].
/// Ignores bottom sheets, dialogs, and other [PopupRoute]s.
final BackInterAdNavigatorObserver backInterAdNavigatorObserver =
    BackInterAdNavigatorObserver();

class BackInterAdNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    if (route is! PageRoute<dynamic>) {
      return;
    }

    if (!_isMainShellRoute(previousRoute)) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = appNavigatorKey.currentContext;
      if (context == null || !context.mounted) {
        return;
      }
      BackInterAdService.handleBackToHome(context);
    });
  }

  bool _isMainShellRoute(Route<dynamic>? route) {
    return route != null && identical(route, MainShellScreen.homeRoute);
  }
}
