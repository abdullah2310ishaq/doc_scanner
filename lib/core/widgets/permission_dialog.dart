import 'package:flutter/material.dart';

import '../services/permission_service.dart';
import '../utils/l10n_extension.dart';

Future<bool?> showAppPermissionDialog(
  BuildContext context, {
  required String title,
  required String message,
}) {
  final l10n = context.l10n;

  return showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.permissionOpenSettings),
          ),
        ],
      );
    },
  );
}

Future<bool> ensureStoragePermission(BuildContext context) async {
  final l10n = context.l10n;
  final service = PermissionService();

  if (await service.hasStoragePermission()) {
    return true;
  }

  final granted = await service.requestStoragePermission();
  if (granted) {
    return true;
  }

  if (!context.mounted) {
    return false;
  }

  final openSettings = await showAppPermissionDialog(
    context,
    title: l10n.permissionStorageTitle,
    message: l10n.permissionStorageMessage,
  );

  if (openSettings == true) {
    await service.openSettings();
  }

  return service.hasStoragePermission();
}
