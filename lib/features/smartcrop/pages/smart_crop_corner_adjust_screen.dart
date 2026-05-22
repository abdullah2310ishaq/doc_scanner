import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../providers/smart_crop_session_provider.dart';
import '../services/smart_crop_edge_detect_service.dart';
import '../smart_crop_flow.dart';
import '../widgets/smart_crop_corner_editor.dart';
import 'smart_crop_crop_processing_screen.dart';

/// Step 3 — drag 4 corners, then perspective crop (CamScanner-style).
class SmartCropCornerAdjustScreen extends StatefulWidget {
  const SmartCropCornerAdjustScreen({super.key});

  static Future<void> open(
    BuildContext context, {
    required SmartCropSessionProvider session,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SmartCropFlow.wrapSession(
          session: session,
          child: const SmartCropCornerAdjustScreen(),
        ),
      ),
    );
  }

  @override
  State<SmartCropCornerAdjustScreen> createState() =>
      _SmartCropCornerAdjustScreenState();
}

class _SmartCropCornerAdjustScreenState
    extends State<SmartCropCornerAdjustScreen> {
  final _edgeDetect = SmartCropEdgeDetectService();
  final Set<int> _detectedPageIndexes = {};
  int _pageIndex = 0;
  bool _isDetectingCurrent = false;
  int? _detectingIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _detectPageIfNeeded(_pageIndex);
    });
  }

  Future<void> _detectPageIfNeeded(int index) async {
    if (_detectedPageIndexes.contains(index) || _detectingIndex == index) {
      return;
    }

    final session = context.read<SmartCropSessionProvider>();
    if (index < 0 || index >= session.pageCount) return;

    setState(() {
      _isDetectingCurrent = true;
      _detectingIndex = index;
    });

    try {
      final detected = await _edgeDetect.detectCorners(session.pages[index]);
      if (!mounted) return;
      session.updatePage(index, detected);
      _detectedPageIndexes.add(index);
    } finally {
      if (mounted) {
        setState(() {
          _isDetectingCurrent = false;
          _detectingIndex = null;
        });
      }
    }
  }

  void _goToPage(int index) {
    setState(() => _pageIndex = index);
    _detectPageIfNeeded(index);
  }

  void _onConfirm() {
    final session = context.read<SmartCropSessionProvider>();
    session.lockAllCorners();
    SmartCropCropProcessingScreen.open(context, pages: session.pages);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Consumer<SmartCropSessionProvider>(
      builder: (context, session, _) {
        final pages = session.pages;
        if (pages.isEmpty) {
          return Scaffold(
            backgroundColor: AppColors.smartCropSoftBackground,
            appBar: AppBar(
              backgroundColor: AppColors.smartCropSoftBackground,
              foregroundColor: AppColors.textPrimary,
              title: Text(l10n.smartCropAdjustCornersTitle),
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: AppColors.smartCropPrimary,
              ),
            ),
          );
        }

        final index = _pageIndex.clamp(0, pages.length - 1);
        final page = pages[index];
        final bottomInset = MediaQuery.paddingOf(context).bottom;
        final showDetectingOverlay =
            _isDetectingCurrent && _detectingIndex == index;

        return Scaffold(
          backgroundColor: AppColors.smartCropSoftBackground,
          appBar: AppBar(
            backgroundColor: AppColors.smartCropSoftBackground,
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: AppColors.textPrimary,
            title: Text(
              l10n.smartCropAdjustCornersTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          body: Column(
            children: [
              if (pages.length > 1)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Text(
                    l10n.smartCropPageIndicator(index + 1, pages.length),
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Text(
                  l10n.smartCropAdjustCornersHint,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.smartCropCanvas,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.smartCropFrameBorder,
                            width: 2,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: SmartCropCornerEditor(
                        key: ValueKey('${page.imagePath}_$index'),
                        imagePath: page.imagePath,
                        topLeft: page.topLeft,
                        topRight: page.topRight,
                        bottomRight: page.bottomRight,
                        bottomLeft: page.bottomLeft,
                        onSwipeToPrevious:
                            index > 0 ? () => _goToPage(index - 1) : null,
                        onSwipeToNext: index < pages.length - 1
                            ? () => _goToPage(index + 1)
                            : null,
                        onCornersChanged:
                            ({
                              required topLeft,
                              required topRight,
                              required bottomRight,
                              required bottomLeft,
                            }) {
                              session.updatePage(
                                index,
                                page.copyWith(
                                  topLeft: topLeft,
                                  topRight: topRight,
                                  bottomRight: bottomRight,
                                  bottomLeft: bottomLeft,
                                ),
                              );
                            },
                        ),
                      ),
                      if (pages.length > 1) ...[
                        if (index > 0)
                          Positioned(
                            left: 4,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: _CornerPageNavButton(
                                icon: Icons.chevron_left,
                                onPressed: () => _goToPage(index - 1),
                              ),
                            ),
                          ),
                        if (index < pages.length - 1)
                          Positioned(
                            right: 4,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: _CornerPageNavButton(
                                icon: Icons.chevron_right,
                                onPressed: () => _goToPage(index + 1),
                              ),
                            ),
                          ),
                      ],
                      if (showDetectingOverlay)
                        Positioned(
                          left: 20,
                          right: 20,
                          top: 12,
                          child: Material(
                            color: AppColors.white,
                            elevation: 2,
                            shadowColor: AppColors.cardShadow,
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.smartCropPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      l10n.smartCropDetectingEdges,
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 8, 24, 24 + bottomInset),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.smartCropPrimary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      l10n.smartCropAdjustCornersConfirm,
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
      },
    );
  }
}

/// Circular prev/next control on the sides of the corner editor.
class _CornerPageNavButton extends StatelessWidget {
  const _CornerPageNavButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  static const double _size = 52;
  static const double _iconSize = 32;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 4,
      shadowColor: AppColors.cardShadow,
      shape: CircleBorder(
        side: BorderSide(color: AppColors.smartCropRetakeBorder.withValues(alpha: 0.9)),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: _size,
          height: _size,
          child: Icon(icon, color: AppColors.smartCropPrimary, size: _iconSize),
        ),
      ),
    );
  }
}
