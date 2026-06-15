import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/smart_crop_limits.dart';
import '../../core/services/permission_service.dart';
import '../../core/utils/l10n_extension.dart';
import '../../core/widgets/toast.dart';
import '../home/providers/recent_documents_provider.dart';
import '../home/services/recent_documents_service.dart';
import '../ocr/services/image_picker_service.dart';
import 'models/smart_crop_gallery_import_result.dart';
import 'pages/multiple_images_first_page.dart';
import 'pages/smart_crop_captured_screen.dart';
import 'providers/smart_crop_session_provider.dart';
import 'services/smart_crop_gallery_import_service.dart';
import 'services/smart_crop_mlkit_scan_service.dart';
import 'widgets/smart_crop_input_sheet.dart';

abstract final class SmartCropFlow {
  static final _mlKitScan = SmartCropMlKitScanService();
  static final _galleryImport = SmartCropGalleryImportService();
  static final _permissions = PermissionService();
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

  /// Google ML Kit scanner with gallery import — best auto-crop quality.
  static Future<void> startMlKitGalleryScan(BuildContext context) async {
    if (!_guardAndroid(context)) return;

    await _scanWithMlKit(
      context,
      pageLimit: SmartCropLimits.maxPages,
      isGalleryImport: true,
    );
  }

  /// Retake / add another page — gallery sessions reopen gallery; camera shows pick sheet.
  static Future<void> addAnotherPage(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) async {
    if (!_guardAndroid(context) || !session.canAddMore) return;

    if (session.source == SmartCropSessionSource.gallery) {
      await _addPagesFromGallery(context, session: session);
      return;
    }

    await showSmartCropInputSheet(
      context,
      onLiveCamera: () => _addPagesFromCamera(context, session: session),
      onUploadImage: () => _addPagesFromGallery(context, session: session),
    );
  }

  /// Swap one gallery page (retake) without adding a new slot.
  static Future<void> replacePageAt(
    BuildContext context, {
    required SmartCropSessionProvider session,
    required int index,
  }) async {
    if (!_guardAndroid(context)) return;
    if (index < 0 || index >= session.pageCount) return;

    final hasPermission =
        await _permissions.hasGalleryPermission() ||
        await _permissions.requestGalleryPermission();
    if (!hasPermission) {
      if (context.mounted) {
        AppToast.show(context, context.l10n.permissionStorageMessage);
      }
      return;
    }

    try {
      final picked = await ImagePickerService().pickMultipleImagesFromGallery(
        max: 1,
      );
      if (picked.isEmpty || !context.mounted) return;

      final result = await _importWithLoadingDialog(
        context,
        sourcePaths: picked,
      );
      if (!context.mounted) return;

      _showImportResultToast(context, result, picked.length);

      if (result.paths.isEmpty) return;

      final path = result.paths.first;
      await RecentDocumentsService().registerImage(path);
      session.replacePage(index, path);
      session.source = SmartCropSessionSource.gallery;
      await RecentDocumentsProvider.refreshGlobal();
    } catch (e) {
      if (context.mounted) {
        AppToast.show(context, context.l10n.commonError);
      }
    }
  }

  static Future<void> _addPagesFromCamera(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) async {
    if (!session.canAddMore) return;

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
      session.source = SmartCropSessionSource.camera;
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

  static Future<void> _addPagesFromGallery(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) async {
    if (!session.canAddMore) return;

    final hasPermission =
        await _permissions.hasGalleryPermission() ||
        await _permissions.requestGalleryPermission();
    if (!hasPermission) {
      if (context.mounted) {
        AppToast.show(context, context.l10n.permissionStorageMessage);
      }
      return;
    }

    final remaining = SmartCropLimits.maxPages - session.pageCount;

    try {
      final picked = await ImagePickerService().pickMultipleImagesFromGallery(
        max: remaining,
      );
      if (picked.isEmpty || !context.mounted) return;

      final result = await _importWithLoadingDialog(
        context,
        sourcePaths: picked,
      );
      if (!context.mounted) return;

      _showImportResultToast(context, result, picked.length);

      if (result.paths.isEmpty) return;

      final recentDocs = RecentDocumentsService();
      for (final path in result.paths) {
        if (!session.canAddMore) break;
        await recentDocs.registerImage(path);
        session.addPage(path);
      }
      session.source = SmartCropSessionSource.gallery;
      await RecentDocumentsProvider.refreshGlobal();
    } catch (e) {
      if (context.mounted) {
        AppToast.show(context, context.l10n.commonError);
      }
    }
  }

  static Future<SmartCropGalleryImportResult> _importWithLoadingDialog(
    BuildContext context, {
    required List<String> sourcePaths,
  }) async {
    var loadingShown = false;
    final progressLabel = ValueNotifier<String>(
      context.l10n.smartCropStepReadingImages,
    );

    void showLoading() {
      if (!context.mounted || loadingShown) return;
      loadingShown = true;
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return PopScope(
            canPop: false,
            child: Center(
              child: ValueListenableBuilder<String>(
                valueListenable: progressLabel,
                builder: (_, label, __) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          Text(
                            label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }

    void hideLoading() {
      if (!context.mounted || !loadingShown) return;
      loadingShown = false;
      Navigator.of(context, rootNavigator: true).pop();
    }

    showLoading();

    try {
      final result = await _galleryImport.importImages(
        sourcePaths,
        onProgress: (done, total) {
          progressLabel.value = context.l10n.smartCropImportReadingProgress(
            done,
            total,
          );
        },
      );
      hideLoading();
      return result;
    } catch (e) {
      hideLoading();
      rethrow;
    } finally {
      progressLabel.dispose();
    }
  }

  static void _showImportResultToast(
    BuildContext context,
    SmartCropGalleryImportResult result,
    int pickedCount,
  ) {
    if (result.totalSkipped <= 0) return;

    AppToast.show(
      context,
      context.l10n.smartCropImportPartialFailure(
        result.totalSkipped,
        pickedCount,
      ),
    );
  }

  static Future<void> pickFromGallery(BuildContext context) async {
    if (!_guardAndroid(context)) return;
    await MultipleImagesFirstPage.open(context);
  }

  /// Opens device gallery → stable JPEG copies → captured review.
  static Future<void> pickGalleryImages(
    BuildContext context, {
    bool replaceCurrentRoute = false,
  }) async {
    if (!_guardAndroid(context)) return;

    final hasPermission =
        await _permissions.hasGalleryPermission() ||
        await _permissions.requestGalleryPermission();
    if (!hasPermission) {
      if (context.mounted) {
        AppToast.show(context, context.l10n.permissionStorageMessage);
      }
      return;
    }

    try {
      final picked = await ImagePickerService().pickMultipleImagesFromGallery(
        max: SmartCropLimits.maxPages,
      );
      if (picked.isEmpty || !context.mounted) return;

      final result = await _importWithLoadingDialog(
        context,
        sourcePaths: picked,
      );
      if (!context.mounted) return;

      _showImportResultToast(context, result, picked.length);

      if (result.paths.isEmpty) {
        AppToast.show(context, context.l10n.commonError);
        return;
      }

      final recentDocs = RecentDocumentsService();
      for (final path in result.paths) {
        await recentDocs.registerImage(path);
      }
      await RecentDocumentsProvider.refreshGlobal();

      final session = _newSession()
        ..source = SmartCropSessionSource.gallery
        ..setFromPaths(result.paths);

      if (!context.mounted) return;

      await SmartCropCapturedScreen.open(
        context,
        session: session,
        replaceCurrentRoute: replaceCurrentRoute,
      );
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

      final session = _newSession()
        ..source = SmartCropSessionSource.camera
        ..setFromPaths(paths, isMlKitProcessed: true);
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
