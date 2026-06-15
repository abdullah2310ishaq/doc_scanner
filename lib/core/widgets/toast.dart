import 'package:flutter/material.dart';

import '../navigation/app_navigator.dart';

class AppToast {
  static const Color successBackground = Colors.green;
  static const Color errorBackground = Color(0xFFDC2626);

  static void showGlobal(
    String message, {
    Color backgroundColor = successBackground,
  }) {
    final overlay = _resolveOverlay();
    if (overlay == null) {
      return;
    }
    _insert(overlay, message, backgroundColor: backgroundColor);
  }

  static void show(
    BuildContext context,
    String message, {
    Color backgroundColor = successBackground,
  }) {
    final overlay = _resolveOverlay(context: context);
    if (overlay == null) {
      return;
    }
    _insert(overlay, message, backgroundColor: backgroundColor);
  }

  static OverlayState? _resolveOverlay({BuildContext? context}) {
    final navigatorOverlay = appNavigatorKey.currentState?.overlay;
    if (navigatorOverlay != null && navigatorOverlay.mounted) {
      return navigatorOverlay;
    }

    final navigatorContext = appNavigatorKey.currentContext;
    if (navigatorContext != null && navigatorContext.mounted) {
      final rootOverlay = Overlay.maybeOf(navigatorContext, rootOverlay: true);
      if (rootOverlay != null && rootOverlay.mounted) {
        return rootOverlay;
      }
    }

    if (context != null && context.mounted) {
      final localOverlay = Overlay.maybeOf(context, rootOverlay: true);
      if (localOverlay != null && localOverlay.mounted) {
        return localOverlay;
      }
    }

    return null;
  }

  static void _insert(
    OverlayState overlay,
    String message, {
    required Color backgroundColor,
  }) {
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (overlayContext) => Positioned(
        top: MediaQuery.paddingOf(overlayContext).top + 130,
        left: 16,
        right: 16,
        child: _ToastWidget(
          message: message,
          backgroundColor: backgroundColor,
        ),
      ),
    );

    overlay.insert(entry);

    Future<void>.delayed(const Duration(seconds: 2), () {
      if (entry.mounted) {
        entry.remove();
      }
    });
  }
}

class _ToastWidget extends StatelessWidget {
  const _ToastWidget({
    required this.message,
    required this.backgroundColor,
  });

  final String message;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
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
