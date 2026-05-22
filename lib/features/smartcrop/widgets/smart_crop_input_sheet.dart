import 'package:flutter/material.dart';
import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';

Future<void> showSmartCropInputSheet(
  BuildContext context, {
  VoidCallback? onLiveCamera,
  VoidCallback? onUploadImage,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppColors.ocrInputSheetRadius),
      ),
    ),
    builder: (sheetContext) {
      return SmartCropInputSheet(
        onLiveCamera: () {
          Navigator.of(sheetContext).pop();
          onLiveCamera?.call();
        },
        onUploadImage: () {
          Navigator.of(sheetContext).pop();
          onUploadImage?.call();
        },
      );
    },
  );
}

/// Step 0 — home bottom sheet: live camera or upload.
class SmartCropInputSheet extends StatelessWidget {
  const SmartCropInputSheet({
    super.key,
    required this.onLiveCamera,
    required this.onUploadImage,
  });

  final VoidCallback onLiveCamera;
  final VoidCallback onUploadImage;

  static const double _horizontalPadding = 24;
  static const double _iconCircleSize = 52;
  static const double _iconSize = 45;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        _horizontalPadding,
        8,
        _horizontalPadding,
        24 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.smartCropInputMethodTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.smartCropInputMethodSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 24),
          _CropInputOptionCard(
            backgroundColor: AppColors.ocrInputLiveBg,
            iconAsset: HomeAssets.bottomSheetCamera,
            title: l10n.smartCropInputLiveCameraTitle,
            description: l10n.smartCropInputLiveCameraDescription,
            onTap: onLiveCamera,
          ),
          const SizedBox(height: 12),
          _CropInputOptionCard(
            backgroundColor: AppColors.ocrInputUploadBg,
            iconAsset: HomeAssets.uploadImageBottom,
            title: l10n.smartCropInputUploadImageTitle,
            description: l10n.smartCropInputUploadImageDescription,
            onTap: onUploadImage,
          ),
        ],
      ),
    );
  }
}

class _CropInputOptionCard extends StatelessWidget {
  const _CropInputOptionCard({
    required this.backgroundColor,
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final Color backgroundColor;
  final String iconAsset;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppColors.ocrInputOptionRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppColors.ocrInputOptionRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: SmartCropInputSheet._iconCircleSize,
                height: SmartCropInputSheet._iconCircleSize,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  iconAsset,
                  width: SmartCropInputSheet._iconSize,
                  height: SmartCropInputSheet._iconSize,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
