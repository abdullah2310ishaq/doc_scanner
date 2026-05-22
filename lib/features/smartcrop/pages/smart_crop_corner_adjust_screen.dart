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
  bool _isDetecting = true;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _autoDetectEdges());
  }

  Future<void> _autoDetectEdges() async {
    final session = context.read<SmartCropSessionProvider>();
    for (var i = 0; i < session.pageCount; i++) {
      final detected = await _edgeDetect.detectCorners(session.pages[i]);
      if (!mounted) return;
      session.updatePage(i, detected);
    }
    if (mounted) setState(() => _isDetecting = false);
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
            appBar: AppBar(title: Text(l10n.smartCropAdjustCornersTitle)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final index = _pageIndex.clamp(0, pages.length - 1);
        final page = pages[index];
        final bottomInset = MediaQuery.paddingOf(context).bottom;

        return Scaffold(
          backgroundColor: const Color(0xFF121212),
          appBar: AppBar(
            backgroundColor: const Color(0xFF121212),
            foregroundColor: AppColors.white,
            title: Text(
              l10n.smartCropAdjustCornersTitle,
              style: const TextStyle(fontWeight: FontWeight.w600),
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
                      color: AppColors.white,
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
                    color: Color(0xFFB0B0B0),
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: _isDetecting
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(
                              color: Color(0xFF7B61FF),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.smartCropDetectingEdges,
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                      )
                    : SmartCropCornerEditor(
                        key: ValueKey(page.imagePath),
                        imagePath: page.imagePath,
                        topLeft: page.topLeft,
                        topRight: page.topRight,
                        bottomRight: page.bottomRight,
                        bottomLeft: page.bottomLeft,
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
              if (pages.length > 1 && !_isDetecting)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: index > 0
                            ? () => setState(() => _pageIndex = index - 1)
                            : null,
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        l10n.smartCropPageIndicator(index + 1, pages.length),
                        style: const TextStyle(color: AppColors.white),
                      ),
                      IconButton(
                        onPressed: index < pages.length - 1
                            ? () => setState(() => _pageIndex = index + 1)
                            : null,
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 8, 24, 24 + bottomInset),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isDetecting ? null : _onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5D5FEF),
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
