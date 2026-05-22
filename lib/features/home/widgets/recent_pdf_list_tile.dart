import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/recent_file_model.dart';
import '../services/recent_documents_service.dart';

/// One PDF row in [RecentPdfsScreen] — star when favorited, ⋮ menu.
class RecentPdfListTile extends StatelessWidget {
  const RecentPdfListTile({
    super.key,
    required this.file,
    required this.onTap,
    required this.onMenu,
  });

  final RecentFileModel file;
  final VoidCallback onTap;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    final meta = RecentDocumentsService.formatMeta(
      file.modifiedAt,
      file.sizeBytes,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.documentCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.documentCardBorder),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.pdfIconBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.picture_as_pdf,
            color: AppColors.pdfIconColor,
            size: 24,
          ),
        ),
        title: Text(
          file.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            meta,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (file.isFavorite)
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.star,
                  color: Color(0xFFFFC107),
                  size: 22,
                ),
              ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
              onPressed: onMenu,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
