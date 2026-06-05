import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Svg render karne ke liye add kiya
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/l10n_text.dart';
import '../../../core/widgets/delete_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../../smartcrop/pages/smart_crop_pdf_view_screen.dart';
import '../../smartcrop/smart_crop_flow.dart';
import '../models/recent_file_model.dart';
import '../providers/recent_documents_provider.dart';
import '../services/recent_documents_service.dart';
import '../widgets/recent_documents_empty_state.dart';

/// All recent PDFs — search, favorite (provider), share / delete from PopupMenuButton.
class RecentPdfsScreen extends StatefulWidget {
  const RecentPdfsScreen({super.key});

  static Future<void> open(BuildContext context) {
    final provider = context.read<RecentDocumentsProvider>();
    if (!provider.isLoadingPdfs && provider.pdfFiles.isEmpty) {
      provider.loadPdfs();
    }
    return Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const RecentPdfsScreen()));
  }

  @override
  State<RecentPdfsScreen> createState() => _RecentPdfsScreenState();
}

class _RecentPdfsScreenState extends State<RecentPdfsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() => setState(() {});

  List<RecentFileModel> _filtered(RecentDocumentsProvider provider) {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return provider.pdfFiles;
    return provider.pdfFiles
        .where((f) => f.fileName.toLowerCase().contains(q))
        .toList();
  }

  Future<void> _uploadPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    final path = result?.files.single.path;
    if (path == null) return;
    if (!mounted) return;
    await context.read<RecentDocumentsProvider>().registerPdf(path);
  }

  Future<void> _scanDocument() async {
    await SmartCropFlow.startLiveCamera(context);
    if (!mounted) return;
    await context.read<RecentDocumentsProvider>().loadPdfs();
  }

  void _openPdf(RecentFileModel file) {
    SmartCropPdfViewScreen.open(
      context,
      pdfPath: file.path,
      displayName: file.displayName,
      onDeleted: () => context.read<RecentDocumentsProvider>().loadPdfs(),
    );
  }

  Future<void> _share(RecentFileModel file) async {
    final l10n = context.l10n;
    try {
      await context.read<RecentDocumentsProvider>().shareFile(file);
    } catch (_) {
      if (mounted) AppToast.show(context, l10n.commonError);
    }
  }

  Future<void> _toggleFavorite(RecentFileModel file) async {
    final l10n = context.l10n;
    try {
      await context.read<RecentDocumentsProvider>().toggleFavorite(file);
    } catch (_) {
      if (mounted) AppToast.show(context, l10n.commonError);
    }
  }

  Future<void> _delete(RecentFileModel file) async {
    final l10n = context.l10n;
    final ok = await DeleteDialog.show(
      context: context,
      title: l10n.commonDelete,
      message: l10n.smartCropDeletePdfConfirm,
    );
    if (ok != true || !mounted) return;
    try {
      await context.read<RecentDocumentsProvider>().deleteFile(file);
    } catch (_) {
      if (mounted) AppToast.show(context, l10n.commonError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Consumer<RecentDocumentsProvider>(
      builder: (context, provider, _) {
        final files = _filtered(provider);

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: AppColors.textPrimary,
            title: L10nText(
              l10n.homeRecentPdfsTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          body: provider.isLoadingPdfs
              ? const Center(child: CircularProgressIndicator())
              : provider.pdfFiles.isEmpty
              ? RecentDocumentsEmptyState(
                  imageAsset:
                      'assets/no_pdf.png', // Kuch nahi hai toh no_pdf.png
                  title: l10n.homeRecentPdfEmptyTitle,
                  subtitle: l10n.homeRecentPdfEmptySubtitle,
                  primaryLabel: l10n.homeRecentUploadPdf,
                  secondaryLabel: l10n.homeRecentScanDocument,
                  onPrimary: _uploadPdf,
                  onSecondary: _scanDocument,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: l10n.homeRecentSearchPdfs,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: files.isEmpty
                          ? Center(
                              child: Text(
                                l10n.homeRecentNoSearchResults,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: files.length,
                              itemBuilder: (context, index) {
                                final file = files[index];

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFFEFEFEF),
                                    ),
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.only(
                                      left: 12,
                                      right: 4,
                                    ),
                                    leading: Container(
                                      // Yahan card icon ki jagah aapka custom SVG laga diya hai:
                                      child: SvgPicture.asset(
                                        'assets/recent_pdf.svg',
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                    title: Text(
                                      file.displayName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        RecentDocumentsService.formatMeta(
                                          file.modifiedAt,
                                          file.sizeBytes,
                                          l10n,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (file.isFavorite)
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 20,
                                          ),
                                        Theme(
                                          data: Theme.of(context).copyWith(
                                            popupMenuTheme:
                                                const PopupMenuThemeData(
                                                  color: Colors.white,
                                                  elevation: 4,
                                                  surfaceTintColor:
                                                      Colors.white,
                                                ),
                                          ),
                                          child: PopupMenuButton<String>(
                                            icon: const Icon(
                                              Icons.more_vert,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            onSelected: (value) async {
                                              if (value == 'share') {
                                                _share(file);
                                              } else if (value == 'delete') {
                                                _delete(file);
                                              } else if (value == 'favorite') {
                                                _toggleFavorite(file);
                                              }
                                            },
                                            itemBuilder: (BuildContext context) => [
                                              PopupMenuItem<String>(
                                                value: 'share',
                                                height: 36,
                                                child: L10nText(
                                                  l10n.commonShare,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem<String>(
                                                value: 'delete',
                                                height: 36,
                                                child: L10nText(
                                                  l10n.commonDelete,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem<String>(
                                                value: 'favorite',
                                                height: 36,
                                                child: L10nText(
                                                  file.isFavorite
                                                      ? l10n.homeRecentUnfavorite
                                                      : l10n.homeRecentToggleFavorite,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () => _openPdf(file),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
