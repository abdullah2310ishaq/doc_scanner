import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/toast.dart';
import '../../home/services/recent_documents_service.dart';
import '../services/smart_crop_pdf_service.dart';
import 'smart_crop_pdf_result_screen.dart';

/// PDF building — white/blue loading (#F9FAFD).
class SmartCropPdfProcessingScreen extends StatefulWidget {
  const SmartCropPdfProcessingScreen({
    super.key,
    required this.imagePaths,
    required this.matrix,
  });

  final List<String> imagePaths;
  final List<double>? matrix;

  static void open(
    BuildContext context, {
    required List<String> imagePaths,
    required List<double>? matrix,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SmartCropPdfProcessingScreen(
          imagePaths: imagePaths,
          matrix: matrix,
        ),
      ),
    );
  }

  @override
  State<SmartCropPdfProcessingScreen> createState() =>
      _SmartCropPdfProcessingScreenState();
}

class _SmartCropPdfProcessingScreenState
    extends State<SmartCropPdfProcessingScreen> {
  final _pdfService = SmartCropPdfService();

  double _currentProgress = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _runPdf());
  }

  Future<void> _runPdf() async {
    if (widget.imagePaths.isEmpty) {
      if (mounted) Navigator.of(context).pop();
      return;
    }

    try {
      final pdfPath = await _pdfService.createPdf(
        imagePaths: widget.imagePaths,
        colorMatrix: widget.matrix,
        onProgress: (progress) {
          if (!mounted) return;
          setState(() => _currentProgress = progress);
        },
      );
      await RecentDocumentsService().registerPdf(pdfPath);
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => SmartCropPdfResultScreen(
            pdfPath: pdfPath,
            pageCount: widget.imagePaths.length,
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      AppToast.show(context, context.l10n.commonError);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final count = widget.imagePaths.length;

    // Fallback static text if localization maps aren't fully configured yet
    final headingMessage = count > 1
        ? l10n.smartCropProcessingPdfMultiple(count)
        : "Creating Your PDF";

    const subheadingMessage =
        "We are organizing your cropped images\ninto a high quality PDF";

    return Scaffold(
      backgroundColor: AppColors.smartCropSoftBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 3),

              // New centralized image asset matching UI design
              Image.asset(
                'assets/creating_pdf.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),

              // Primary Heading Text
              Text(
                headingMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 12),

              // Secondary Descriptive Subtitle Text
              const Text(
                subheadingMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors
                      .grey, // Replace with your AppColors.textSecondary if applicable
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),

              const Spacer(flex: 4),

              // Linear Indicator bound side-by-side with Percentage text
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: _currentProgress,
                      minHeight: 6,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      backgroundColor: AppColors.searchBorder,
                      color: AppColors.smartCropPrimary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    "${(_currentProgress * 100).toInt()}%",
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
