import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/smart_crop_limits.dart';
import '../../core/widgets/toast.dart';
import '../../core/utils/l10n_extension.dart';
import '../ocr/services/image_picker_service.dart';
import 'pages/multiple_images_first_page.dart';
import 'pages/smart_crop_captured_screen.dart';
import 'providers/smart_crop_session_provider.dart';
import 'services/smart_crop_mlkit_scan_service.dart';

/// Smart Crop — **Android only** (Google ML Kit document scanner).
///
/// - **Live camera** → ML Kit scanner UI (edge detect + perspective crop in-camera)
/// - **Upload** → intro screen → gallery picker → crop → PDF
abstract final class SmartCropFlow {
  static final _mlKit = SmartCropMlKitScanService();

  static SmartCropSessionProvider _newSession() => SmartCropSessionProvider();

  static bool _guardAndroid(BuildContext context) {
    if (Platform.isAndroid) return true;
    AppToast.show(context, context.l10n.smartCropAndroidOnly);
    return false;
  }

  static Future<void> startLiveCamera(BuildContext context) async {
    if (!_guardAndroid(context)) return;

    final session = _newSession();
    await _openMlKitScannerAndCaptured(context, session: session);
  }

  static Future<void> captureAnotherPage(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) async {
    if (!_guardAndroid(context) || !session.canAddMore) return;

    final remaining = SmartCropLimits.maxPages - session.pageCount;
    final paths = await _mlKit.scanPages(limit: remaining);
    if (paths == null || paths.isEmpty || !context.mounted) return;

    for (final path in paths) {
      if (!session.canAddMore) break;
      session.addPage(path, isMlKitProcessed: true);
    }
  }

  /// Step 0 for upload — intro UI before gallery.
  static Future<void> pickFromGallery(BuildContext context) async {
    if (!_guardAndroid(context)) return;
    await MultipleImagesFirstPage.open(context);
  }

  /// Gallery picker → captured review → crop → filters → PDF.
  static Future<void> pickGalleryImages(BuildContext context) async {
    if (!_guardAndroid(context)) return;

    final paths = await ImagePickerService().pickMultipleImagesFromGallery(
      max: SmartCropLimits.maxPages,
    );
    if (paths.isEmpty || !context.mounted) return;

    final session = _newSession();
    session.setFromPaths(paths);
    if (!context.mounted) return;
    await SmartCropCapturedScreen.open(context, session: session);
  }

  static Future<void> _openMlKitScannerAndCaptured(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) async {
    final paths = await _mlKit.scanPages();
    if (paths == null || paths.isEmpty || !context.mounted) return;

    session.setFromPaths(paths, isMlKitProcessed: true);
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
