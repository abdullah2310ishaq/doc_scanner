import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';

/// Single-photo review — white background, blue frame + buttons (design mock).
class SmartCropSinglePhotoReviewBody extends StatefulWidget {
  const SmartCropSinglePhotoReviewBody({
    super.key,
    required this.imagePaths,
    this.initialIndex = 0,
    required this.onCrop,
    this.onAddAnother,
    this.showAddAnother = false,
    this.onPageChanged,
  });

  final List<String> imagePaths;
  final int initialIndex;
  final VoidCallback onCrop;
  final VoidCallback? onAddAnother;
  final bool showAddAnother;
  final ValueChanged<int>? onPageChanged;

  static const double frameBorderWidth = 2;

  @override
  State<SmartCropSinglePhotoReviewBody> createState() =>
      _SmartCropSinglePhotoReviewBodyState();
}

class _SmartCropSinglePhotoReviewBodyState
    extends State<SmartCropSinglePhotoReviewBody> {
  late final PageController? _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.imagePaths.length - 1);
    if (widget.imagePaths.length > 1) {
      _pageController = PageController(initialPage: _currentIndex);
    } else {
      _pageController = null;
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final paths = widget.imagePaths;
    if (paths.isEmpty) {
      return const SizedBox.shrink();
    }

    final index = _currentIndex.clamp(0, paths.length - 1);
    final hasMultiple = paths.length > 1;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16 + bottomInset),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hasMultiple)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                l10n.smartCropPageIndicator(index + 1, paths.length),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          Expanded(
            child: hasMultiple
                ? PageView.builder(
                    controller: _pageController,
                    itemCount: paths.length,
                    onPageChanged: (i) {
                      setState(() => _currentIndex = i);
                      widget.onPageChanged?.call(i);
                    },
                    itemBuilder: (context, i) =>
                        SmartCropFramedImage(path: paths[i]),
                  )
                : SmartCropFramedImage(path: paths[index]),
          ),
          const SizedBox(height: 24),
          if (widget.showAddAnother && widget.onAddAnother != null) ...[
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: widget.onAddAnother,
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.smartCropRetakeBackground,
                  foregroundColor: AppColors.smartCropRetakeText,
                  side: const BorderSide(
                    color: AppColors.smartCropRetakeBorder,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  l10n.smartCropCapturedRetakeAnotherPhoto,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.onCrop,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.smartCropPrimary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                l10n.smartCropCapturedCrop,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bordered document preview (contain — does not fill full screen).
class SmartCropFramedImage extends StatelessWidget {
  const SmartCropFramedImage({
    super.key,
    required this.path,
    this.borderColor = AppColors.smartCropFrameBorder,
    this.borderWidth = SmartCropSinglePhotoReviewBody.frameBorderWidth,
  });

  final String path;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.smartCropCanvas,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: Image.file(File(path), fit: BoxFit.contain),
    );
  }
}

/// App bar title from the current image file name.
String smartCropPhotoReviewTitle(List<String> imagePaths, int index) {
  if (imagePaths.isEmpty) return '';
  final safeIndex = index.clamp(0, imagePaths.length - 1);
  final path = imagePaths[safeIndex];
  final parts = path.split(Platform.pathSeparator);
  return parts.isNotEmpty ? parts.last : path;
}
