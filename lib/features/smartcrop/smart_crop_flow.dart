import 'dart:io';

import 'package:doc_scanner/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/smart_crop_limits.dart';
import '../../core/widgets/toast.dart';
import '../../core/utils/l10n_extension.dart';
import 'pages/multiple_images_first_page.dart';
import 'pages/smart_crop_captured_screen.dart';
import '../home/providers/recent_documents_provider.dart';
import '../home/services/recent_documents_service.dart';
import 'providers/smart_crop_session_provider.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';

/// Smart Crop — **Android only**.
///
/// - **Live camera** → Google ML Kit document scanner (auto edges, crop, filters)
/// - **Upload** → intro → gallery → captured → corner adjust → crop → filters → PDF
abstract final class SmartCropFlow {
  static SmartCropSessionProvider _newSession() => SmartCropSessionProvider();

  static bool _guardAndroid(BuildContext context) {
    if (Platform.isAndroid) return true;
    AppToast.show(context, context.l10n.smartCropAndroidOnly);
    return false;
  }

  /// Opens Cunning Document Scanner camera — dewarped pages go straight to captured review.
  static Future<void> startLiveCamera(BuildContext context) async {
    if (!_guardAndroid(context)) return;

    try {
      final paths = await CunningDocumentScanner.getPictures(
        noOfPages: SmartCropLimits.maxPages,
        isGalleryImportAllowed: false,
      );
      if (paths == null || paths.isEmpty || !context.mounted) return;

      final recentDocs = RecentDocumentsService();
      for (final path in paths) {
        await recentDocs.registerImage(path);
      }
      await RecentDocumentsProvider.refreshGlobal();

      final session = _newSession();
      session.setFromPaths(paths, isCameraScanned: true);
      if (!context.mounted) return;
      await SmartCropCapturedScreen.open(context, session: session);
    } catch (e) {
      if (context.mounted) {
        AppToast.show(
          context,
          e.toString().contains("Permission")
              ? context.l10n.permissionCameraMessage
              : context.l10n.commonError,
        );
      }
    }
  }

  static Future<void> captureAnotherPage(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) async {
    if (!_guardAndroid(context) || !session.canAddMore) return;

    final remaining = SmartCropLimits.maxPages - session.pageCount;
    try {
      final paths = await CunningDocumentScanner.getPictures(
        noOfPages: remaining,
        isGalleryImportAllowed: false,
      );
      if (paths == null || paths.isEmpty || !context.mounted) return;

      final recentDocs = RecentDocumentsService();
      for (final path in paths) {
        if (!session.canAddMore) break;
        await recentDocs.registerImage(path);
        session.addPage(path, isCameraScanned: true);
      }
      await RecentDocumentsProvider.refreshGlobal();
    } catch (e) {
      if (context.mounted) {
        AppToast.show(
          context,
          e.toString().contains("Permission")
              ? context.l10n.permissionCameraMessage
              : context.l10n.commonError,
        );
      }
    }
  }

  static Future<void> pickFromGallery(BuildContext context) async {
    if (!_guardAndroid(context)) return;
    await MultipleImagesFirstPage.open(context);
  }

  static Future<void> pickGalleryImages(BuildContext context) async {
    if (!_guardAndroid(context)) return;

    try {
      final paths = await CunningDocumentScanner.getPictures(
        noOfPages: SmartCropLimits.maxPages,
        isGalleryImportAllowed: true,
      );
      if (paths == null || paths.isEmpty || !context.mounted) return;

      final recentDocs = RecentDocumentsService();
      for (final path in paths) {
        await recentDocs.registerImage(path);
      }
      await RecentDocumentsProvider.refreshGlobal();

      final session = _newSession();
      session.setFromPaths(paths, isCameraScanned: true);
      if (!context.mounted) return;
      await SmartCropCapturedScreen.open(context, session: session);
    } catch (e) {
      if (context.mounted) {
        AppToast.show(
          context,
          e.toString().contains("Permission")
              ? context.l10n.permissionCameraMessage
              : context.l10n.commonError,
        );
      }
    }
  }

  static Widget wrapSession({
    required SmartCropSessionProvider session,
    required Widget child,
  }) {
    return ChangeNotifierProvider<SmartCropSessionProvider>.value(
      value: session,
      child: child,
    );
  }
}
