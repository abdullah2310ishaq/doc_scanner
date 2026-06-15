import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../navigation/app_navigator.dart';
import '../providers/connectivity_provider.dart';
import '../utils/l10n_extension.dart';
import '../widgets/toast.dart';

/// Shows the no-internet toast when the user lands on home shell while offline.
abstract final class HomeOfflineToast {
  static Future<void> showIfOffline(BuildContext context) async {
    if (!context.mounted) {
      return;
    }

    final message = context.l10n.errorNoInternetFeatures;
    final connectivity = context.read<ConnectivityProvider>();
    if (!connectivity.isInitialized) {
      return;
    }

    final isOnline = await connectivity.refresh();
    if (isOnline) {
      return;
    }

    for (var attempt = 0; attempt < 5; attempt++) {
      if (attempt > 0) {
        await Future<void>.delayed(const Duration(milliseconds: 250));
      }

      final overlay = appNavigatorKey.currentState?.overlay;
      if (overlay != null && overlay.mounted) {
        AppToast.showGlobal(message, backgroundColor: AppToast.errorBackground);
        return;
      }
    }

    AppToast.showGlobal(message, backgroundColor: AppToast.errorBackground);
  }
}
