import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../providers/smart_crop_session_provider.dart';
import '../smart_crop_flow.dart';
import '../widgets/smart_crop_multi_preview_body.dart';
import '../smart_crop_navigation.dart';

/// Step 3 — full preview when user taps a thumbnail (2+ photos only).
class SmartCropPhotoPreviewScreen extends StatefulWidget {
  const SmartCropPhotoPreviewScreen({
    super.key,
    required this.initialIndex,
  });

  final int initialIndex;

  static Future<void> open(
    BuildContext context, {
    required int initialIndex,
  }) {
    final session = context.read<SmartCropSessionProvider>();
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SmartCropFlow.wrapSession(
          session: session,
          child: SmartCropPhotoPreviewScreen(initialIndex: initialIndex),
        ),
      ),
    );
  }

  @override
  State<SmartCropPhotoPreviewScreen> createState() =>
      _SmartCropPhotoPreviewScreenState();
}

class _SmartCropPhotoPreviewScreenState
    extends State<SmartCropPhotoPreviewScreen> {
  void _onCrop(SmartCropSessionProvider session) {
    if (session.isEmpty) return;
    SmartCropNavigation.goToCropOrFilters(context, session: session);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Consumer<SmartCropSessionProvider>(
      builder: (context, session, _) {
        final pages = session.pages;
        if (pages.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.smartCropPreviewTitle)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final paths = pages.map((p) => p.imagePath).toList();

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            leading: const BackButton(color: Colors.black),
            title: Text(
              l10n.smartCropPreviewTitle,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            backgroundColor: AppColors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: SafeArea(
            child: SmartCropMultiPreviewBody(
              imagePaths: paths,
              initialIndex: widget.initialIndex,
              onCrop: () => _onCrop(session),
            ),
          ),
        );
      },
    );
  }
}
