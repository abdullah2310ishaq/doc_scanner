import 'package:flutter/material.dart';

import '../utils/l10n_extension.dart';

class ExitAppDialog {
  ExitAppDialog._();

  static bool _isShowing = false;

  static Future<bool?> show(BuildContext context) async {
    if (_isShowing) return false;

    _isShowing = true;
    final l10n = context.l10n;

    try {
      return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(l10n.exitAppTitle),
            content: Text(l10n.exitAppMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.commonCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(l10n.exitAppConfirm),
              ),
            ],
          );
        },
      );
    } finally {
      _isShowing = false;
    }
  }
}
