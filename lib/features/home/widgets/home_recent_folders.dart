import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../models/recent_file_model.dart';
import '../providers/recent_documents_provider.dart';
import '../screens/recent_images_screen.dart';
import '../screens/recent_pdfs_screen.dart';
import '../services/recent_documents_service.dart';

/// Home — PDFs and Images folder cards (listens to global [RecentDocumentsProvider]).
class HomeRecentFolders extends StatelessWidget {
  const HomeRecentFolders({super.key});

  int _totalBytes(List<RecentFileModel> files) {
    return files.fold(0, (sum, f) => sum + f.sizeBytes);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Consumer<RecentDocumentsProvider>(
      builder: (context, provider, _) {
        final pdfs = provider.pdfFiles;
        final images = provider.imageFiles;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.homeRecentDocuments,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            if (provider.isLoadingSummary)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else ...[
              _FolderCard(
                iconAsset: HomeAssets.folderPdf,
                title: l10n.homeRecentPdfsFolder,
                meta: l10n.homeRecentFolderMeta(
                  pdfs.length,
                  RecentDocumentsService.formatSize(_totalBytes(pdfs), l10n),
                ),
                onTap: () => RecentPdfsScreen.open(context),
              ),
              const SizedBox(height: 10),
              _FolderCard(
                iconAsset: HomeAssets.folderImage,
                title: l10n.homeRecentImagesFolder,
                meta: l10n.homeRecentFolderMeta(
                  images.length,
                  RecentDocumentsService.formatSize(_totalBytes(images), l10n),
                ),
                onTap: () => RecentImagesScreen.open(context),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _FolderCard extends StatelessWidget {
  const _FolderCard({
    required this.iconAsset,
    required this.title,
    required this.meta,
    required this.onTap,
  });

  final String iconAsset;
  final String title;
  final String meta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.documentCardBg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.documentCardBorder),
          ),
          child: Row(
            children: [
              SvgPicture.asset(iconAsset, width: 44, height: 44),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      meta,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
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
