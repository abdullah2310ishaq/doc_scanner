import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/l10n_text.dart';
import '../models/recent_file_model.dart';
import '../services/recent_documents_service.dart';

class RecentFileGridTile extends StatelessWidget {
  const RecentFileGridTile({
    super.key,
    required this.file,
    required this.onTap,
    required this.onShare,
    required this.onDelete,
    required this.onToggleFavorite,
    this.isSelected = false,
    this.onToggleSelect,
  });

  final RecentFileModel file;
  final VoidCallback onTap;
  final VoidCallback onShare;
  final VoidCallback onDelete;
  final VoidCallback onToggleFavorite;
  final bool isSelected;
  final VoidCallback? onToggleSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final meta = RecentDocumentsService.formatMeta(
      file.modifiedAt,
      file.sizeBytes,
      l10n,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.smartCropPrimary
                : AppColors.documentCardBorder,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _Thumbnail(file: file),
                  if (file.isFavorite)
                    const Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        Icons.star,
                        size: 20,
                        color: Color(0xFFFFC107),
                      ),
                    ),
                  if (onToggleSelect != null)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: GestureDetector(
                        onTap: onToggleSelect,
                        child: Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: isSelected
                              ? AppColors.smartCropPrimary
                              : AppColors.white,
                          size: 22,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 4, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          file.fileName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          meta,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      popupMenuTheme: const PopupMenuThemeData(
                        color: Colors.white,
                        elevation: 4,
                        surfaceTintColor: Colors.white,
                      ),
                    ),
                    child: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSelected: (value) {
                        if (value == 'share') {
                          onShare();
                        } else if (value == 'delete') {
                          onDelete();
                        } else if (value == 'favorite') {
                          onToggleFavorite();
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'share',
                          height: 36,
                          child: L10nText(
                            l10n.commonShare,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          height: 36,
                          child: L10nText(
                            l10n.commonDelete,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'favorite',
                          height: 36,
                          child: L10nText(
                            file.isFavorite
                                ? l10n.homeRecentUnfavorite
                                : l10n.homeRecentToggleFavorite,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.file});

  final RecentFileModel file;

  @override
  Widget build(BuildContext context) {
    if (file.type == RecentFileType.image) {
      return Image.file(
        File(file.path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _pdfPlaceholder(),
      );
    }
    return _pdfPlaceholder();
  }

  Widget _pdfPlaceholder() {
    return Container(
      color: const Color(0xFFF2F4FF),
      child: const Center(
        child: Icon(
          Icons.picture_as_pdf,
          size: 40,
          color: AppColors.smartCropPrimary,
        ),
      ),
    );
  }
}
