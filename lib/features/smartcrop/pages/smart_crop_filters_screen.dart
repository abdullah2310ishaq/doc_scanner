import 'dart:io';

import 'package:colorfilter_generator/addons.dart';
import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import 'smart_crop_pdf_processing_screen.dart';

/// Step 5 — cropped pages, filters, Create PDF button.
class SmartCropFiltersScreen extends StatefulWidget {
  const SmartCropFiltersScreen({super.key, required this.imagePaths});

  final List<String> imagePaths;

  @override
  State<SmartCropFiltersScreen> createState() => _SmartCropFiltersScreenState();
}

class _SmartCropFiltersScreenState extends State<SmartCropFiltersScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  late final List<ColorFilterGenerator> _filters = [
    ColorFilterGenerator(name: 'Original', filters: []),
    ColorFilterGenerator(
      name: 'Magic Color',
      filters: [
        ColorFilterAddons.contrast(0.2),
        ColorFilterAddons.brightness(0.15),
      ],
    ),
    ColorFilterGenerator(
      name: 'Grayscale',
      filters: [ColorFilterAddons.saturation(-1.0)],
    ),
    ColorFilterGenerator(
      name: 'B&W',
      filters: [
        ColorFilterAddons.saturation(-1.0),
        ColorFilterAddons.contrast(0.6),
      ],
    ),
    ColorFilterGenerator(
      name: 'Warm',
      filters: [ColorFilterAddons.sepia(0.35)],
    ),
  ];

  int _selectedFilterIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _getLocalizedFilterName(BuildContext context, String name) {
    final l10n = context.l10n;
    switch (name) {
      case 'Original':
        return l10n.smartCropFilterOriginal;
      case 'Magic Color':
        return l10n.smartCropFilterMagic;
      case 'Grayscale':
        return l10n.smartCropFilterGrayscale;
      case 'B&W':
        return l10n.smartCropFilterMono;
      case 'Warm':
        return l10n.smartCropFilterWarm;
      default:
        return name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final paths = widget.imagePaths;
    final currentFilter = _filters[_selectedFilterIndex];
    final index = _currentIndex.clamp(0, paths.length - 1);

    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.smartCropCroppedTitle,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.smartCropPageIndicator(index + 1, paths.length),
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.85),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: paths.length,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InteractiveViewer(
                            maxScale: 4.5,
                            child: Center(
                              child: ColorFiltered(
                                colorFilter: ColorFilter.matrix(
                                  currentFilter.matrix,
                                ),
                                child: Image.file(
                                  File(paths[i]),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  if (paths.length > 1 && index < paths.length - 1)
                    Positioned(
                      right: 8,
                      child: _NavCircle(
                        icon: Icons.chevron_right,
                        onTap: () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOut,
                        ),
                      ),
                    ),
                  if (paths.length > 1 && index > 0)
                    Positioned(
                      left: 8,
                      child: _NavCircle(
                        icon: Icons.chevron_left,
                        onTap: () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOut,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              color: const Color(0xFF1E1E1E),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 105,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filters.length,
                      itemBuilder: (context, filterIndex) {
                        final filter = _filters[filterIndex];
                        final isSelected = filterIndex == _selectedFilterIndex;
                        final displayName = _getLocalizedFilterName(
                          context,
                          filter.name,
                        );
                        final thumbPath = paths[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFilterIndex = filterIndex;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 14),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 62,
                                  height: 62,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF7B61FF)
                                          : Colors.grey.shade800,
                                      width: isSelected ? 3.0 : 1.5,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.matrix(
                                      filter.matrix,
                                    ),
                                    child: Image.file(
                                      File(thumbPath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  displayName,
                                  style: TextStyle(
                                    color: isSelected
                                        ? const Color(0xFF7B61FF)
                                        : AppColors.white.withValues(alpha: 0.7),
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        SmartCropPdfProcessingScreen.open(
                          context,
                          imagePaths: paths,
                          matrix: currentFilter.matrix,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7B61FF),
                        foregroundColor: AppColors.white,
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        l10n.smartCropActionCreatePdf,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
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

class _NavCircle extends StatelessWidget {
  const _NavCircle({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black45,
      shape: const CircleBorder(),
      child: IconButton(
        icon: Icon(icon, color: AppColors.white),
        onPressed: onTap,
      ),
    );
  }
}
