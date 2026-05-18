import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';

Future<void> showChatbotUploadOptionsSheet(
  BuildContext context, {
  required VoidCallback onChoosePdf,
  required VoidCallback onRecentFiles,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppColors.chatbotSheetRadius),
      ),
    ),
    builder: (sheetContext) {
      return ChatbotUploadOptionsSheet(
        onChoosePdf: () {
          Navigator.of(sheetContext).pop();
          onChoosePdf();
        },
        onRecentFiles: () {
          Navigator.of(sheetContext).pop();
          onRecentFiles();
        },
      );
    },
  );
}

class ChatbotUploadOptionsSheet extends StatelessWidget {
  const ChatbotUploadOptionsSheet({
    super.key,
    required this.onChoosePdf,
    required this.onRecentFiles,
  });

  final VoidCallback onChoosePdf;
  final VoidCallback onRecentFiles;

  static const double _horizontalPadding = 24;
  static const double _iconCircleSize = 52;
  static const double _iconSize = 31;

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
            l10n.chatbotSheetTitle,
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
            l10n.chatbotSheetSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 24),
          _ChatbotUploadOptionCard(
            backgroundColor: AppColors.chatbotSheetPdfBg,
            iconAsset: HomeAssets.pdf,
            title: l10n.chatbotChoosePdfTitle,
            description: l10n.chatbotChoosePdfDescription,
            onTap: onChoosePdf,
          ),
          const SizedBox(height: 12),
          _ChatbotUploadOptionCard(
            backgroundColor: AppColors.chatbotSheetRecentBg,
            iconAsset: 'assets/folder.svg',
            title: l10n.chatbotRecentFilesTitle,
            description: l10n.chatbotRecentFilesDescription,
            onTap: onRecentFiles,
          ),
        ],
      ),
    );
  }
}

class _ChatbotUploadOptionCard extends StatelessWidget {
  const _ChatbotUploadOptionCard({
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
      borderRadius: BorderRadius.circular(AppColors.chatbotSheetOptionRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppColors.chatbotSheetOptionRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: ChatbotUploadOptionsSheet._iconCircleSize,
                height: ChatbotUploadOptionsSheet._iconCircleSize,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  iconAsset,
                  width: ChatbotUploadOptionsSheet._iconSize,
                  height: ChatbotUploadOptionsSheet._iconSize,
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
