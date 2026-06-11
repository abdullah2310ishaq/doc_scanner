import 'dart:io';

import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/delete_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../constants/smart_crop_color_filters.dart';
import '../widgets/smart_crop_preview_nav_button.dart';
import 'smart_crop_pdf_processing_screen.dart';

/// Cropped image + filters + Create PDF (#F9FAFD white / blue theme).
class SmartCropFiltersScreen extends StatefulWidget {
  const SmartCropFiltersScreen({super.key, required this.imagePaths});

  final List<String> imagePaths;

  @override
  State<SmartCropFiltersScreen> createState() => _SmartCropFiltersScreenState();
}

class _SmartCropFiltersScreenState extends State<SmartCropFiltersScreen> {
  late List<String> _paths;
  late final PageController _pageController;
  int _currentIndex = 0;
  int _selectedFilterIndex = 0;

  final List<ColorFilterGenerator> _filters = SmartCropColorFilters.filters;

  @override
  void initState() {
    super.initState();
    _paths = List<String>.from(widget.imagePaths);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _filterLabel(BuildContext context, String name) {
    final l10n = context.l10n;
    switch (name) {
      case 'No Filter':
      case 'Original':
        return l10n.smartCropFilterOriginal;
      case 'Lighten':
        return l10n.smartCropFilterLighten;
      case 'Clarendon':
        return l10n.smartCropFilterMagic;
      case 'Grayscale':
        return l10n.smartCropFilterGrayscale;
      case 'Inkwell':
        return l10n.smartCropFilterMono;
      case 'Reyes':
        return l10n.smartCropFilterWarm;
      default:
        return name;
    }
  }

  void _copyCurrentImage() {
    if (_paths.isEmpty) return;
    final path = _paths[_currentIndex.clamp(0, _paths.length - 1)];
    Clipboard.setData(ClipboardData(text: path));
    AppToast.show(context, context.l10n.smartCropImageCopied);
  }

  Future<void> _confirmDeleteCurrent() async {
    if (_paths.isEmpty) return;

    final l10n = context.l10n;
    final confirmed = await DeleteDialog.show(
      context: context,
      title: l10n.smartCropDeleteDocumentTitle,
      message: l10n.smartCropDeleteDocumentMessage,
    );

    if (confirmed == true && mounted) {
      _deleteCurrentImage();
    }
  }

  void _goToPage(int index) {
    if (!_pageController.hasClients) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  void _deleteCurrentImage() {
    if (_paths.isEmpty) return;
    setState(() {
      _paths.removeAt(_currentIndex.clamp(0, _paths.length - 1));
      if (_currentIndex >= _paths.length && _paths.isNotEmpty) {
        _currentIndex = _paths.length - 1;
      }
    });
    if (_paths.isEmpty) {
      Navigator.of(context).pop();
      return;
    }
    if (_pageController.hasClients) {
      _pageController.jumpToPage(_currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (_paths.isEmpty) {
      return const SizedBox.shrink();
    }

    final index = _currentIndex.clamp(0, _paths.length - 1);
    final hasMultiple = _paths.length > 1;
    final canGoBack = hasMultiple && index > 0;
    final canGoForward = hasMultiple && index < _paths.length - 1;
    final currentFilter = _filters[_selectedFilterIndex];
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.smartCropSoftBackground,
      appBar: AppBar(
        backgroundColor: AppColors.smartCropSoftBackground,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.smartCropCroppedTitle,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onSelected: (value) {
              if (value == 'copy') {
                _copyCurrentImage();
              } else if (value == 'delete') {
                _confirmDeleteCurrent();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'copy', child: Text(l10n.commonCopy)),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  l10n.commonDelete,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (_paths.length > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                l10n.smartCropPageIndicator(index + 1, _paths.length),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _BlueBorderCroppedPreview(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _paths.length,
                        onPageChanged: (i) => setState(() => _currentIndex = i),
                        itemBuilder: (context, i) {
                          return ColorFiltered(
                            colorFilter:
                                ColorFilter.matrix(currentFilter.matrix),
                            child: Image.file(
                              File(_paths[i]),
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  if (canGoBack)
                    Positioned(
                      left: 0,
                      child: SmartCropPreviewNavButton(
                        icon: Icons.chevron_left,
                        onPressed: () => _goToPage(index - 1),
                      ),
                    ),
                  if (canGoForward)
                    Positioned(
                      right: 0,
                      child: SmartCropPreviewNavButton(
                        icon: Icons.chevron_right,
                        onPressed: () => _goToPage(index + 1),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filters.length,
              itemBuilder: (context, filterIndex) {
                final filter = _filters[filterIndex];
                final isSelected = filterIndex == _selectedFilterIndex;
                final label = _filterLabel(context, filter.name);

                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedFilterIndex = filterIndex),
                  child: Container(
                    width: 72,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.smartCropPrimary
                                      : AppColors.searchBorder,
                                  width: isSelected ? 2.5 : 1,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.matrix(filter.matrix),
                                child: Image.file(
                                  File(_paths[index]),
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: AppColors.smartCropPrimary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: AppColors.white,
                                  size: 18,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.1,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected
                                ? AppColors.smartCropPrimary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16 + bottomInset),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  SmartCropPdfProcessingScreen.open(
                    context,
                    imagePaths: _paths,
                    matrix: currentFilter.matrix,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.smartCropPrimary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.smartCropActionCreatePdf,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Cropped preview with theme blue frame (#5D5FEF).
class _BlueBorderCroppedPreview extends StatelessWidget {
  const _BlueBorderCroppedPreview({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.smartCropPrimary, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.smartCropPrimary.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
