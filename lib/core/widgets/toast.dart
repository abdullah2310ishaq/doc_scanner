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
    final isErrorToast = backgroundColor == errorBackground;

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (overlayContext) => Positioned(
        top:
            MediaQuery.paddingOf(overlayContext).top +
            (isErrorToast ? 72 : 130),
        left: 16,
        right: 16,
        child: _ToastWidget(
          message: message,
          backgroundColor: backgroundColor,
          borderRadius: isErrorToast ? 8 : 24,
          fontSize: isErrorToast ? 13 : 14,
          verticalPadding: isErrorToast ? 8 : 10,
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
    required this.borderRadius,
    required this.fontSize,
    required this.verticalPadding,
  });

  final String message;
  final Color backgroundColor;
  final double borderRadius;
  final double fontSize;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}
