import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/toast.dart';
import '../services/smart_crop_pdf_service.dart';
import 'smart_crop_pdf_result_screen.dart';

/// Step 6 — building PDF (loading UI).
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
      );
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => SmartCropPdfResultScreen(
            pdfPath: pdfPath,
            imagePath: widget.imagePaths.first,
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
    final message = count > 1
        ? l10n.smartCropProcessingPdfMultiple(count)
        : l10n.smartCropProcessingPdf;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(HomeAssets.pdf, width: 72, height: 72),
              const SizedBox(height: 28),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              const LinearProgressIndicator(
                minHeight: 6,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                backgroundColor: AppColors.searchBorder,
                color: Color(0xFF7B61FF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
