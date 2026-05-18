import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';

Future<void> showTranslateDownloadOptionSheet(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String selectedTextTitle,
  required String selectedTextDescription,
  required String completeFileTitle,
  required String completeFileDescription,
  required VoidCallback onSelectedText,
  required VoidCallback onCompleteFile,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppColors.translateDownloadSheetRadius),
      ),
    ),
    builder: (sheetContext) {
      return TranslateDownloadOptionSheet(
        title: title,
        subtitle: subtitle,
        selectedTextTitle: selectedTextTitle,
        selectedTextDescription: selectedTextDescription,
        completeFileTitle: completeFileTitle,
        completeFileDescription: completeFileDescription,
        onSelectedText: () {
          Navigator.of(sheetContext).pop();
          onSelectedText();
        },
        onCompleteFile: () {
          Navigator.of(sheetContext).pop();
          onCompleteFile();
        },
      );
    },
  );
}

class TranslateDownloadOptionSheet extends StatelessWidget {
  const TranslateDownloadOptionSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selectedTextTitle,
    required this.selectedTextDescription,
    required this.completeFileTitle,
    required this.completeFileDescription,
    required this.onSelectedText,
    required this.onCompleteFile,
  });

  final String title;
  final String subtitle;
  final String selectedTextTitle;
  final String selectedTextDescription;
  final String completeFileTitle;
  final String completeFileDescription;
  final VoidCallback onSelectedText;
  final VoidCallback onCompleteFile;

  static const double _horizontalPadding = 24;
  static const double _iconCircleSize = 52;
  static const double _iconSize = 31;
  static const String _selectedIcon = 'assets/selected.svg';
  static const String _folderIcon = 'assets/folder.svg';

  @override
  Widget build(BuildContext context) {
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
            title,
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
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 24),
          _DownloadOptionCard(
            backgroundColor: AppColors.translateDownloadSelectedBg,
            iconAsset: _selectedIcon,
            title: selectedTextTitle,
            description: selectedTextDescription,
            onTap: onSelectedText,
          ),
          const SizedBox(height: 12),
          _DownloadOptionCard(
            backgroundColor: AppColors.translateDownloadCompleteBg,
            iconAsset: _folderIcon,
            title: completeFileTitle,
            description: completeFileDescription,
            onTap: onCompleteFile,
          ),
        ],
      ),
    );
  }
}

class _DownloadOptionCard extends StatelessWidget {
  const _DownloadOptionCard({
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
      borderRadius: BorderRadius.circular(AppColors.translateDownloadOptionRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppColors.translateDownloadOptionRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: TranslateDownloadOptionSheet._iconCircleSize,
                height: TranslateDownloadOptionSheet._iconCircleSize,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  iconAsset,
                  width: TranslateDownloadOptionSheet._iconSize,
                  height: TranslateDownloadOptionSheet._iconSize,
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
