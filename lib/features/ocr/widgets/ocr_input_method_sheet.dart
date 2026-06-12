import 'package:flutter/material.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';

Future<void> showOcrInputMethodSheet(
  BuildContext context, {
  VoidCallback? onLiveCamera,
  VoidCallback? onUploadImage,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Color(0xFFF5F6FB),
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppColors.ocrInputSheetRadius),
      ),
    ),
    builder: (sheetContext) {
      return OcrInputMethodSheet(
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

class OcrInputMethodSheet extends StatelessWidget {
  const OcrInputMethodSheet({
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
            l10n.ocrInputMethodTitle,
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
            l10n.ocrInputMethodSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 24),
          _OcrInputOptionCard(
            backgroundColor: AppColors.ocrInputLiveBg,
            iconAsset: HomeAssets.bottomSheetCamera,
            title: l10n.ocrInputLiveCameraTitle,
            description: l10n.ocrInputLiveCameraDescription,
            onTap: onLiveCamera,
          ),
          const SizedBox(height: 12),
          _OcrInputOptionCard(
            backgroundColor: AppColors.ocrInputUploadBg,
            iconAsset: HomeAssets.uploadImageBottom,
            title: l10n.ocrInputUploadImageTitle,
            description: l10n.ocrInputUploadImageDescription,
            onTap: onUploadImage,
          ),
        ],
      ),
    );
  }
}

class _OcrInputOptionCard extends StatelessWidget {
  const _OcrInputOptionCard({
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
      color: AppColors
          .white, // ADJUSTMENT: Fixed unused background color parameter
      elevation: 4, // ADJUSTMENT: Added elevation for the raised look
      shadowColor: Colors.black.withValues(
        alpha: 0.15,
      ), // ADJUSTMENT: Added a soft shadow to make the elevation look cleaner
      borderRadius: BorderRadius.circular(AppColors.ocrInputOptionRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppColors.ocrInputOptionRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: OcrInputMethodSheet._iconCircleSize,
                height: OcrInputMethodSheet._iconCircleSize,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  iconAsset,
                  width: OcrInputMethodSheet._iconSize,
                  height: OcrInputMethodSheet._iconSize,
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
