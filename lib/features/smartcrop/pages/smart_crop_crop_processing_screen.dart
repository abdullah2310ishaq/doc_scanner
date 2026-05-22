import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/toast.dart';
import '../models/smart_crop_page_model.dart';
import '../services/smart_crop_crop_service.dart';
import 'smart_crop_filters_screen.dart';

/// Step 4 — ML Kit / edge detect + perspective crop (loading UI).
class SmartCropCropProcessingScreen extends StatefulWidget {
  const SmartCropCropProcessingScreen({super.key, required this.pages});

  final List<SmartCropPageModel> pages;

  static void open(
    BuildContext context, {
    required List<SmartCropPageModel> pages,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SmartCropCropProcessingScreen(pages: pages),
      ),
    );
  }

  @override
  State<SmartCropCropProcessingScreen> createState() =>
      _SmartCropCropProcessingScreenState();
}

class _SmartCropCropProcessingScreenState
    extends State<SmartCropCropProcessingScreen> {
  final _cropService = SmartCropCropService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _runCrop());
  }

  Future<void> _runCrop() async {
    if (widget.pages.isEmpty) {
      if (mounted) Navigator.of(context).pop();
      return;
    }

    try {
      final croppedPaths = await _cropService.cropAllPages(widget.pages);
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => SmartCropFiltersScreen(imagePaths: croppedPaths),
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
    final count = widget.pages.length;
    final message = count > 1
        ? l10n.smartCropProcessingCropMultiple(count)
        : l10n.smartCropProcessingCrop;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7B61FF)),
                strokeWidth: 4,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
