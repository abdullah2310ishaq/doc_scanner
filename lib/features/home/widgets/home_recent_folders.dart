import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../models/recent_file_model.dart';
import '../screens/recent_images_screen.dart';
import '../screens/recent_pdfs_screen.dart';
import '../services/recent_documents_service.dart';

/// Home — PDFs and Images folder cards (vertical list, design mock).
class HomeRecentFolders extends StatefulWidget {
  const HomeRecentFolders({super.key});

  @override
  State<HomeRecentFolders> createState() => _HomeRecentFoldersState();
}

class _HomeRecentFoldersState extends State<HomeRecentFolders> {
  final _service = RecentDocumentsService();
  List<RecentFileModel> _pdfs = [];
  List<RecentFileModel> _images = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final pdfs = await _service.loadPdfs();
    final images = await _service.loadImages();
    if (!mounted) return;
    setState(() {
      _pdfs = pdfs;
      _images = images;
      _loading = false;
    });
  }

  int _totalBytes(List<RecentFileModel> files) {
    return files.fold(0, (sum, f) => sum + f.sizeBytes);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
        if (_loading)
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
              _pdfs.length,
              RecentDocumentsService.formatSize(_totalBytes(_pdfs)),
            ),
            onTap: () async {
              await RecentPdfsScreen.open(context);
              _load();
            },
          ),
          const SizedBox(height: 10),
          _FolderCard(
            iconAsset: HomeAssets.folderImage,
            title: l10n.homeRecentImagesFolder,
            meta: l10n.homeRecentFolderMeta(
              _images.length,
              RecentDocumentsService.formatSize(_totalBytes(_images)),
            ),
            onTap: () async {
              await RecentImagesScreen.open(context);
              _load();
            },
          ),
        ],
      ],
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
              const Icon(
                Icons.more_vert,
                color: AppColors.textSecondary,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
