import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/utils/l10n_extension.dart';

/// Single-photo review layout (bordered preview + action buttons) per design mock.
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

  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color frameBorderColor = Color(0xFF5D5FEF);
  static const Color addButtonBackground = Color(0xFFEEEEFF);
  static const Color addButtonBorder = Color(0xFFDCDDFF);
  static const Color addButtonText = Color(0xFF4343FF);
  static const Color cropButtonColor = Color(0xFF5D5FEF);
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
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
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
                  color: Color(0xFF333333),
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
          const SizedBox(height: 32),
          if (widget.showAddAnother && widget.onAddAnother != null) ...[
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: widget.onAddAnother,
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      SmartCropSinglePhotoReviewBody.addButtonBackground,
                  foregroundColor: SmartCropSinglePhotoReviewBody.addButtonText,
                  side: const BorderSide(
                    color: SmartCropSinglePhotoReviewBody.addButtonBorder,
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
                backgroundColor: SmartCropSinglePhotoReviewBody.cropButtonColor,
                foregroundColor: Colors.white,
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
    this.borderColor = SmartCropSinglePhotoReviewBody.frameBorderColor,
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
        color: Colors.white,
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
