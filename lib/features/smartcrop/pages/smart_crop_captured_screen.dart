import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/smart_crop_limits.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../providers/smart_crop_session_provider.dart';
import '../services/smart_crop_edge_detect_service.dart';
import '../smart_crop_flow.dart';
import '../widgets/smart_crop_multi_preview_body.dart';
import '../widgets/smart_crop_single_photo_review_body.dart';
import 'smart_crop_photo_preview_screen.dart';
import '../smart_crop_navigation.dart';

/// Step 2 — review captures (1 photo = bordered layout, 2+ = grid).
class SmartCropCapturedScreen extends StatefulWidget {
  const SmartCropCapturedScreen({super.key});

  static Future<void> open(
    BuildContext context, {
    required SmartCropSessionProvider session,
    bool replaceCurrentRoute = false,
  }) {
    final route = MaterialPageRoute<void>(
      builder: (_) => SmartCropFlow.wrapSession(
        session: session,
        child: const SmartCropCapturedScreen(),
      ),
    );

    if (replaceCurrentRoute) {
      return Navigator.of(context).pushReplacement(route);
    }
    return Navigator.of(context).push(route);
  }

  @override
  State<SmartCropCapturedScreen> createState() =>
      _SmartCropCapturedScreenState();
}

class _SmartCropCapturedScreenState extends State<SmartCropCapturedScreen> {
  final _edgeDetect = SmartCropEdgeDetectService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preDetectGalleryCornersInBackground();
    });
  }

  /// Runs after UI is visible so gallery pick does not block navigation.
  Future<void> _preDetectGalleryCornersInBackground() async {
    if (!mounted) return;

    final session = context.read<SmartCropSessionProvider>();
    if (session.allPagesAlreadyScanned) return;

    for (var i = 0; i < session.pageCount; i++) {
      if (!mounted) return;

      final page = session.pages[i];
      if (page.cornersLocked) continue;

      final result =
          await _edgeDetect.detectCornersWithConfidence(page.imagePath);
      session.updatePage(
        i,
        page.copyWith(
          topLeft: result.corners.topLeft,
          topRight: result.corners.topRight,
          bottomRight: result.corners.bottomRight,
          bottomLeft: result.corners.bottomLeft,
          cornersLocked: result.confidence >= 0.7 && !result.isFallback,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Consumer<SmartCropSessionProvider>(
      builder: (context, session, _) {
        final pages = session.pages;

        if (pages.length == 1) {
          return _SingleCapturedScreen(session: session);
        }

        return Scaffold(
          backgroundColor: AppColors.smartCropSoftBackground,
          appBar: AppBar(
            backgroundColor: AppColors.smartCropSoftBackground,
            elevation: 0,
            foregroundColor: AppColors.textPrimary,
            title: Text(
              l10n.smartCropCapturedTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                  child: Text(
                    l10n.smartCropPageIndicator(
                      pages.length,
                      SmartCropLimits.maxPages,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: _CapturedGrid(
                    onRemove: session.removeAt,
                    onTap: (index) => SmartCropPhotoPreviewScreen.open(
                      context,
                      initialIndex: index,
                    ),
                    onAddPhoto: session.canAddMore
                        ? () => SmartCropFlow.captureAnotherPage(
                              context,
                              session: session,
                            )
                        : null,
                  ),
                ),
                _CapturedActions(session: session),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// One photo — bordered preview layout from design mock (not full-screen cover).
class _SingleCapturedScreen extends StatelessWidget {
  const _SingleCapturedScreen({required this.session});

  final SmartCropSessionProvider session;

  @override
  Widget build(BuildContext context) {
    final path = session.pages.first.imagePath;

    return Scaffold(
      backgroundColor: AppColors.smartCropSoftBackground,
      appBar: AppBar(
        leading: const BackButton(color: AppColors.textPrimary),
        title: Text(
          smartCropPhotoReviewTitle([path], 0),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.smartCropSoftBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SmartCropSinglePhotoReviewBody(
        imagePaths: [path],
        showAddAnother: session.canAddMore,
        onAddAnother: () => SmartCropFlow.captureAnotherPage(
          context,
          session: session,
        ),
        onCrop: () => SmartCropNavigation.goToCropProcessing(
          context,
          session: session,
        ),
      ),
    );
  }
}

class _CapturedGrid extends StatelessWidget {
  const _CapturedGrid({
    required this.onRemove,
    required this.onTap,
    this.onAddPhoto,
  });

  final void Function(int index) onRemove;
  final void Function(int index) onTap;
  final VoidCallback? onAddPhoto;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final session = context.watch<SmartCropSessionProvider>();
    final pages = session.pages;
    final showAddTile = onAddPhoto != null;
    final itemCount = pages.length + (showAddTile ? 1 : 0);

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (showAddTile && index == pages.length) {
          return GestureDetector(
            onTap: onAddPhoto,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.smartCropPrimary,
                  width: 1.5,
                ),
                color: AppColors.smartCropRetakeBackground,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 32,
                    color: AppColors.smartCropPrimary,
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      l10n.smartCropCapturedAnotherPhoto,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.smartCropPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final page = pages[index];
        return GestureDetector(
          onTap: () => onTap(index),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: SmartCropMultiPreviewBody.previewBorderColor,
                    width: 2,
                  ),
                  color: Colors.white,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.file(
                  File(page.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Material(
                  color: Colors.black54,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => onRemove(index),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CapturedActions extends StatelessWidget {
  const _CapturedActions({required this.session});

  final SmartCropSessionProvider session;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 24 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (session.canAddMore) ...[
            OutlinedButton(
              onPressed: () => SmartCropFlow.captureAnotherPage(
                context,
                session: context.read<SmartCropSessionProvider>(),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.smartCropRetakeBackground,
                foregroundColor: AppColors.smartCropRetakeText,
                side: const BorderSide(color: AppColors.smartCropRetakeBorder),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                l10n.smartCropCapturedAnotherPhoto,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          ElevatedButton(
            onPressed: session.isEmpty
                ? null
                : () {
                    SmartCropNavigation.goToCropProcessing(
                      context,
                      session: session,
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.smartCropPrimary,
              foregroundColor: AppColors.white,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              l10n.smartCropCapturedCrop,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (!session.canAddMore) ...[
            const SizedBox(height: 8),
            Text(
              l10n.smartCropMaxPagesReached(SmartCropLimits.maxPages),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
