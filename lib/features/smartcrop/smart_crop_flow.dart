import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/smart_crop_limits.dart';
import '../../core/utils/l10n_extension.dart';
import '../../core/widgets/toast.dart';
import '../home/providers/recent_documents_provider.dart';
import '../home/services/recent_documents_service.dart';
import '../ocr/services/image_picker_service.dart';
import 'pages/multiple_images_first_page.dart';
import 'pages/smart_crop_captured_screen.dart';
import 'providers/smart_crop_session_provider.dart';
import 'services/smart_crop_mlkit_scan_service.dart';

/// Smart Crop — **Android only**.
///
/// - **Live camera** → Google ML Kit scanner (`google_mlkit_document_scanner`)
/// - **Upload** → system gallery → auto edge detect + crop → filters → PDF
///
/// Do not use `cunning_document_scanner` here — it launches the same ML Kit UI
/// natively and crashes when `google_mlkit_document_scanner` is also installed.
abstract final class SmartCropFlow {
  static final _mlKitScan = SmartCropMlKitScanService();

  static SmartCropSessionProvider _newSession() => SmartCropSessionProvider();

  static bool _guardAndroid(BuildContext context) {
    if (Platform.isAndroid) return true;
    AppToast.show(context, context.l10n.smartCropAndroidOnly);
    return false;
  }

  /// Google ML Kit scanner — camera only (no gallery import).
  static Future<void> startLiveCamera(BuildContext context) async {
    if (!_guardAndroid(context)) return;

    await _scanWithMlKit(
      context,
      pageLimit: SmartCropLimits.maxPages,
      isGalleryImport: false,
    );
  }

  static Future<void> captureAnotherPage(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) async {
    if (!_guardAndroid(context) || !session.canAddMore) return;

    final remaining = SmartCropLimits.maxPages - session.pageCount;
    try {
      final paths = await _mlKitScan.scanPages(
        limit: remaining,
        isGalleryImport: false,
      );
      if (paths == null || paths.isEmpty || !context.mounted) return;

      final recentDocs = RecentDocumentsService();
      for (final path in paths) {
        if (!session.canAddMore) break;
        await recentDocs.registerImage(path);
        session.addPage(path, isMlKitProcessed: true);
      }
      await RecentDocumentsProvider.refreshGlobal();
    } catch (e) {
      if (context.mounted) {
        AppToast.show(
          context,
          e.toString().contains('Permission')
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

  /// Opens device gallery — auto edge detect + crop on continue (same as camera).
  static Future<void> pickGalleryImages(BuildContext context) async {
    if (!_guardAndroid(context)) return;

    try {
      final paths = await ImagePickerService().pickMultipleImagesFromGallery(
        max: SmartCropLimits.maxPages,
      );
      if (paths.isEmpty || !context.mounted) return;

      final recentDocs = RecentDocumentsService();
      for (final path in paths) {
        await recentDocs.registerImage(path);
      }
      await RecentDocumentsProvider.refreshGlobal();

      final session = _newSession();
      session.setFromPaths(paths);
      if (!context.mounted) return;
      await SmartCropCapturedScreen.open(context, session: session);
    } catch (e) {
      if (context.mounted) {
        AppToast.show(context, context.l10n.commonError);
      }
    }
  }

  static Future<void> _scanWithMlKit(
    BuildContext context, {
    required int pageLimit,
    required bool isGalleryImport,
  }) async {
    try {
      final paths = await _mlKitScan.scanPages(
        limit: pageLimit,
        isGalleryImport: isGalleryImport,
      );
      if (paths == null || paths.isEmpty || !context.mounted) return;

      final recentDocs = RecentDocumentsService();
      for (final path in paths) {
        await recentDocs.registerImage(path);
      }
      await RecentDocumentsProvider.refreshGlobal();

      final session = _newSession();
      session.setFromPaths(paths, isMlKitProcessed: true);
      if (!context.mounted) return;
      await SmartCropCapturedScreen.open(context, session: session);
    } catch (e) {
      if (context.mounted) {
        AppToast.show(
          context,
          e.toString().contains('Permission')
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
