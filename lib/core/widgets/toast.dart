import 'package:flutter/material.dart';

import '../navigation/app_navigator.dart';

class AppToast {
  static void showGlobal(String message) {
    final context = appNavigatorKey.currentContext;
    if (context == null || !context.mounted) return;
    show(context, message);
  }

  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (overlayContext) => Positioned(
        top: MediaQuery.paddingOf(overlayContext).top + 130,
        left: 16,
        right: 16,
        child: _ToastWidget(message: message),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 2), () => entry.remove());
  }
}

class _ToastWidget extends StatelessWidget {
  const _ToastWidget({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
