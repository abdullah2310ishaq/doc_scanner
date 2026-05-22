import 'package:flutter/material.dart';

import '../../../core/utils/l10n_extension.dart';
import 'smart_crop_single_photo_review_body.dart';

/// Step 3b — multi-photo preview when user taps a grid thumbnail (1/N, chevrons).
class SmartCropMultiPreviewBody extends StatefulWidget {
  const SmartCropMultiPreviewBody({
    super.key,
    required this.imagePaths,
    this.initialIndex = 0,
    required this.onCrop,
  });

  final List<String> imagePaths;
  final int initialIndex;
  final VoidCallback onCrop;

  static const Color previewBorderColor = Color(0xFF2F80ED);
  static const Color cropButtonColor = Color(0xFF2F80ED);

  @override
  State<SmartCropMultiPreviewBody> createState() =>
      _SmartCropMultiPreviewBodyState();
}

class _SmartCropMultiPreviewBodyState extends State<SmartCropMultiPreviewBody> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex =
        widget.initialIndex.clamp(0, widget.imagePaths.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final paths = widget.imagePaths;
    if (paths.isEmpty) {
      return const SizedBox.shrink();
    }

    final index = _currentIndex.clamp(0, paths.length - 1);
    final canGoBack = index > 0;
    final canGoForward = index < paths.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.smartCropPageIndicator(index + 1, paths.length),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: paths.length,
                  onPageChanged: (i) => setState(() => _currentIndex = i),
                  itemBuilder: (context, i) {
                    return SmartCropFramedImage(
                      path: paths[i],
                      borderColor: SmartCropMultiPreviewBody.previewBorderColor,
                    );
                  },
                ),
                if (canGoBack)
                  Positioned(
                    left: 0,
                    child: _PreviewNavButton(
                      icon: Icons.chevron_left,
                      onPressed: () => _goToPage(index - 1),
                    ),
                  ),
                if (canGoForward)
                  Positioned(
                    right: 0,
                    child: _PreviewNavButton(
                      icon: Icons.chevron_right,
                      onPressed: () => _goToPage(index + 1),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            16,
            24,
            24 + MediaQuery.paddingOf(context).bottom,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: widget.onCrop,
              style: ElevatedButton.styleFrom(
                backgroundColor: SmartCropMultiPreviewBody.cropButtonColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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
        ),
      ],
    );
  }
}

class _PreviewNavButton extends StatelessWidget {
  const _PreviewNavButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black26,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: Colors.black87, size: 28),
        ),
      ),
    );
  }
}
