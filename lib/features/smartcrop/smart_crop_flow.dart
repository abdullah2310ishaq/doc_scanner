import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/smart_crop_limits.dart';
import '../../core/widgets/toast.dart';
import '../../core/utils/l10n_extension.dart';
import '../ocr/services/image_picker_service.dart';
import 'pages/multiple_images_first_page.dart';
import 'pages/smart_crop_captured_screen.dart';
import '../home/services/recent_documents_service.dart';
import 'providers/smart_crop_session_provider.dart';
import 'services/smart_crop_mlkit_scan_service.dart';

/// Smart Crop — **Android only**.
///
/// - **Live camera** → Google ML Kit document scanner (auto edges, crop, filters)
/// - **Upload** → intro → gallery → captured → corner adjust → crop → filters → PDF
abstract final class SmartCropFlow {
  static final _mlKitScan = SmartCropMlKitScanService();

  static SmartCropSessionProvider _newSession() => SmartCropSessionProvider();

  static bool _guardAndroid(BuildContext context) {
    if (Platform.isAndroid) return true;
    AppToast.show(context, context.l10n.smartCropAndroidOnly);
    return false;
  }

  /// Opens ML Kit scanner — dewarped pages go straight to captured review.
  static Future<void> startLiveCamera(BuildContext context) async {
    if (!_guardAndroid(context)) return;

    final paths = await _mlKitScan.scanPages(
      limit: SmartCropLimits.maxPages,
    );
    if (paths == null || paths.isEmpty || !context.mounted) return;

    final session = _newSession();
    session.setFromPaths(paths, isMlKitProcessed: true);
    if (!context.mounted) return;
    await SmartCropCapturedScreen.open(context, session: session);
  }

  static Future<void> captureAnotherPage(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) async {
    if (!_guardAndroid(context) || !session.canAddMore) return;

    final remaining = SmartCropLimits.maxPages - session.pageCount;
    final paths = await _mlKitScan.scanPages(limit: remaining);
    if (paths == null || paths.isEmpty || !context.mounted) return;

    for (final path in paths) {
      if (!session.canAddMore) break;
      session.addPage(path, isMlKitProcessed: true);
    }
  }

  static Future<void> pickFromGallery(BuildContext context) async {
    if (!_guardAndroid(context)) return;
    await MultipleImagesFirstPage.open(context);
  }

  static Future<void> pickGalleryImages(BuildContext context) async {
    if (!_guardAndroid(context)) return;

    final paths = await ImagePickerService().pickMultipleImagesFromGallery(
      max: SmartCropLimits.maxPages,
    );
    if (paths.isEmpty || !context.mounted) return;

    final recentDocs = RecentDocumentsService();
    for (final path in paths) {
      await recentDocs.registerImage(path);
    }

    final session = _newSession();
    session.setFromPaths(paths);
    if (!context.mounted) return;
    await SmartCropCapturedScreen.open(context, session: session);
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
