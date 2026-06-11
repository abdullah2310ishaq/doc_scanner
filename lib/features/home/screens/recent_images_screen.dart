import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/delete_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../../smartcrop/smart_crop_flow.dart';
import '../models/recent_file_model.dart';
import '../providers/recent_documents_provider.dart';
import '../widgets/recent_documents_empty_state.dart';
import '../widgets/recent_file_grid_tile.dart';

/// Recent images — grid cards with star, meta, and popup menu like PDFs.
class RecentImagesScreen extends StatefulWidget {
  const RecentImagesScreen({super.key});

  static Future<void> open(BuildContext context) {
    final provider = context.read<RecentDocumentsProvider>();
    if (!provider.isLoadingImages && provider.imageFiles.isEmpty) {
      provider.loadImages();
    }
    return Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const RecentImagesScreen()));
  }

  @override
  State<RecentImagesScreen> createState() => _RecentImagesScreenState();
}

class _RecentImagesScreenState extends State<RecentImagesScreen> {
  final _searchController = TextEditingController();
  bool _selectMode = false;
  final Set<String> _selectedIds = {};

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
    if (q.isEmpty) return provider.imageFiles;
    return provider.imageFiles
        .where((f) => f.fileName.toLowerCase().contains(q))
        .toList();
  }

  Future<void> _uploadImages() async {
    await SmartCropFlow.pickGalleryImages(context);
    if (!mounted) return;
    await context.read<RecentDocumentsProvider>().loadImages();
  }

  Future<void> _scanDocument() async {
    await SmartCropFlow.startLiveCamera(context);
    if (!mounted) return;
    await context.read<RecentDocumentsProvider>().loadImages();
  }

  void _previewImage(RecentFileModel file) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: AppColors.white,
            title: Text(file.fileName),
          ),
          body: Center(
            child: InteractiveViewer(child: Image.file(File(file.path))),
          ),
        ),
      ),
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
    final wasFavorite = file.isFavorite;
    try {
      await context.read<RecentDocumentsProvider>().toggleFavorite(file);
      if (!mounted) return;
      AppToast.show(
        context,
        wasFavorite
            ? l10n.homeRecentFavoriteRemoved
            : l10n.homeRecentFavoriteAdded,
      );
    } catch (_) {
      if (mounted) AppToast.show(context, l10n.commonError);
    }
  }

  Future<void> _deleteSingle(RecentFileModel file) async {
    final l10n = context.l10n;
    final ok = await DeleteDialog.show(
      context: context,
      title: l10n.commonDelete,
      message: l10n.smartCropDeleteImageConfirm,
    );
    if (ok != true || !mounted) return;
    try {
      await context.read<RecentDocumentsProvider>().deleteFile(file);
    } catch (_) {
      if (mounted) AppToast.show(context, l10n.commonError);
    }
  }

  bool _isAllSelected(List<RecentFileModel> files) {
    if (files.isEmpty) return false;
    return files.every((f) => _selectedIds.contains(f.id));
  }

  void _toggleSelectAll(List<RecentFileModel> files) {
    setState(() {
      if (_isAllSelected(files)) {
        _selectedIds.clear();
      } else {
        _selectedIds
          ..clear()
          ..addAll(files.map((f) => f.id));
      }
    });
  }

  Future<void> _deleteSelected() async {
    if (_selectedIds.isEmpty) return;
    final l10n = context.l10n;
    final provider = context.read<RecentDocumentsProvider>();

    final ok = await DeleteDialog.show(
      context: context,
      title: l10n.commonDelete,
      message: l10n.smartCropDeleteImageConfirm,
    );
    if (ok != true || !mounted) return;

    try {
      for (final id in List<String>.from(_selectedIds)) {
        final target = provider.imageFiles.firstWhere((f) => f.id == id);
        await provider.deleteFile(target);
      }
      setState(() {
        _selectedIds.clear();
        _selectMode = false;
      });
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
          backgroundColor: AppColors.smartCropSoftBackground,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: AppColors.textPrimary,
            title: Text(
              l10n.homeRecentImagesTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          body: provider.isLoadingImages
              ? const Center(child: CircularProgressIndicator())
              : provider.imageFiles.isEmpty
              ? RecentDocumentsEmptyState(
                  imageAsset: 'assets/no_image.png',
                  title: l10n.homeRecentImageEmptyTitle,
                  subtitle: l10n.homeRecentImageEmptySubtitle,
                  primaryLabel: l10n.homeRecentUploadImages,
                  secondaryLabel: l10n.homeRecentScanDocument,
                  onPrimary: _uploadImages,
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
                          hintText: l10n.homeRecentSearchImages,
                          hintStyle: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.textSecondary,
                          ),
                          filled: true,
                          fillColor: AppColors.searchFill,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppColors.searchRadius,
                            ),
                            borderSide: const BorderSide(
                              color: AppColors.searchBorder,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppColors.searchRadius,
                            ),
                            borderSide: const BorderSide(
                              color: AppColors.searchBorder,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Row(
                        children: [
                          Text(
                            l10n.homeRecentAdded,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          if (_selectMode && files.isNotEmpty)
                            TextButton(
                              onPressed: () => _toggleSelectAll(files),
                              child: Text(
                                _isAllSelected(files)
                                    ? l10n.homeRecentDeselectAll
                                    : l10n.homeRecentSelectAll,
                                style: const TextStyle(
                                  color: AppColors.textLink,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectMode = !_selectMode;
                                _selectedIds.clear();
                              });
                            },
                            child: Text(
                              _selectMode
                                  ? l10n.commonCancel
                                  : l10n.homeRecentSelect,
                              style: const TextStyle(
                                color: AppColors.textLink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: files.isEmpty
                          ? Center(
                              child: Text(
                                l10n.homeRecentNoSearchResults,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 0.78,
                                  ),
                              itemCount: files.length,
                              itemBuilder: (context, index) {
                                final file = files[index];
                                final isSelected = _selectedIds.contains(
                                  file.id,
                                );

                                return RecentFileGridTile(
                                  file: file,
                                  isSelected: isSelected,
                                  onTap: () {
                                    if (_selectMode) {
                                      setState(() {
                                        if (isSelected) {
                                          _selectedIds.remove(file.id);
                                        } else {
                                          _selectedIds.add(file.id);
                                        }
                                      });
                                    } else {
                                      _previewImage(file);
                                    }
                                  },
                                  onShare: () => _share(file),
                                  onDelete: () => _deleteSingle(file),
                                  onToggleFavorite: () => _toggleFavorite(file),
                                  onToggleSelect: _selectMode
                                      ? () {
                                          setState(() {
                                            if (isSelected) {
                                              _selectedIds.remove(file.id);
                                            } else {
                                              _selectedIds.add(file.id);
                                            }
                                          });
                                        }
                                      : null,
                                );
                              },
                            ),
                    ),
                  ],
                ),
          bottomNavigationBar: _selectMode
              ? SafeArea(
                  child: Container(
                    height: 56,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.documentCardBorder),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.cardShadow,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${_selectedIds.length} ${l10n.homeRecentSelect}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                          ),
                          onPressed: _selectedIds.isEmpty
                              ? null
                              : _deleteSelected,
                        ),
                      ],
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
