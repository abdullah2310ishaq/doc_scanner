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
import '../services/recent_documents_service.dart';
import '../widgets/recent_documents_empty_state.dart';

/// All recent images — Dynamic Selection Mode with unified bottom action controller.
class RecentImagesScreen extends StatefulWidget {
  const RecentImagesScreen({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => RecentDocumentsProvider()..loadImages(),
          child: const RecentImagesScreen(),
        ),
      ),
    );
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
            foregroundColor: Colors.white,
            title: Text(file.fileName),
          ),
          body: Center(
            child: InteractiveViewer(child: Image.file(File(file.path))),
          ),
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(RecentFileModel file) async {
    final l10n = context.l10n;
    try {
      await context.read<RecentDocumentsProvider>().toggleFavorite(file);
    } catch (_) {
      if (mounted) AppToast.show(context, l10n.commonError);
    }
  }

  /// Handles deleting multiple files at once during selection mode
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
      for (final id in _selectedIds) {
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

  void _showMenu(RecentFileModel file) {
    showThemeContextMenu(context, file);
  }

  void showThemeContextMenu(BuildContext context, RecentFileModel file) {
    final l10n = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.visibility_outlined),
              title: Text(l10n.smartCropCapturedPreview),
              onTap: () {
                Navigator.pop(sheetContext);
                _previewImage(file);
              },
            ),
            ListTile(
              leading: Icon(
                file.isFavorite ? Icons.star : Icons.star_border,
                color: file.isFavorite ? Colors.amber : null,
              ),
              title: Text(l10n.homeRecentToggleFavorite),
              onTap: () {
                Navigator.pop(sheetContext);
                _toggleFavorite(file);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
              ),
              title: Text(
                l10n.commonDelete,
                style: const TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Navigator.pop(sheetContext);
                _deleteSingle(file);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Consumer<RecentDocumentsProvider>(
      builder: (context, provider, _) {
        final files = _filtered(provider);

        return Scaffold(
          // Background Color exact as requested: #F9FAFD
          backgroundColor: const Color(0xFFF9FAFD),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: AppColors.textPrimary,
            title: const Text(
              'Images',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search your images...',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFEFEFEF),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFEFEFEF),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                      child: Row(
                        children: [
                          const Text(
                            'Recent Added',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),

                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectMode = !_selectMode;
                                _selectedIds.clear();
                              });
                            },
                            child: Text(
                              _selectMode ? l10n.commonCancel : 'Select',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.grid_view_rounded,
                            color: Colors.blueAccent,
                            size: 22,
                          ),
                        ],
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
                          : GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio:
                                        0.84, // Perfect aspect match for standard aspect ratios
                                  ),
                              itemCount: files.length,
                              itemBuilder: (context, index) {
                                final file = files[index];
                                final isSelected = _selectedIds.contains(
                                  file.id,
                                );

                                return GestureDetector(
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.blueAccent
                                            : const Color(0xFFEFEFEF),
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.vertical(
                                                        top: Radius.circular(
                                                          11,
                                                        ),
                                                      ),
                                                  child: Image.file(
                                                    File(file.path),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              if (file.isFavorite)
                                                const Positioned(
                                                  top: 6,
                                                  right: 6,
                                                  child: Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  ),
                                                ),
                                              if (_selectMode)
                                                Positioned(
                                                  top: 6,
                                                  left: 6,
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                    child: Icon(
                                                      isSelected
                                                          ? Icons.check_circle
                                                          : Icons
                                                                .radio_button_unchecked,
                                                      color: isSelected
                                                          ? Colors.blueAccent
                                                          : Colors.grey,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            8,
                                            6,
                                            4,
                                            6,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  file.displayName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                              if (!_selectMode)
                                                GestureDetector(
                                                  onTap: () => _showMenu(file),
                                                  child: const Icon(
                                                    Icons.more_vert,
                                                    color: Colors.grey,
                                                    size: 16,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
          // Hidden floating action button when selection layout mode is on

          // Persistent custom action layout footer bar specifically triggered inside selection step
          bottomNavigationBar: _selectMode
              ? SafeArea(
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${_selectedIds.length} Selected',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const VerticalDivider(indent: 16, endIndent: 16),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                            size: 26,
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
