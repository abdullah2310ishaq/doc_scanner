import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'exit_app_dialog.dart';

class AppExitGuard extends StatelessWidget {
  const AppExitGuard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldExit = await ExitAppDialog.show(context);
        if (shouldExit == true) {
          SystemNavigator.pop();
        }
      },
      child: child,
    );
  }
}
