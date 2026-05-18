import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../ocr_flow.dart';
import '../providers/live_ocr_camera_provider.dart';
import '../widgets/ocr_retry_action_buttons.dart';
import 'live_ocr_camera_screen.dart';

class OcrNoTextScreen extends StatelessWidget {
  const OcrNoTextScreen({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const OcrNoTextScreen(),
      ),
    );
  }

  static Future<void> openReplacing(BuildContext context) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const OcrNoTextScreen(),
      ),
    );
  }

  void _retakePhoto(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => ChangeNotifierProvider(
          create: (_) => LiveOcrCameraProvider()..initialize(),
          child: const LiveOcrCameraScreen(),
        ),
      ),
    );
  }

  Future<void> _chooseFromGallery(BuildContext context) async {
    await OcrFlow.pickImageAndAnalyze(context, replaceCurrentRoute: true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(l10n.ocrAnalyzeTitle),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              HomeAssets.noTextFound,
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.ocrNoTextTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.ocrNoTextHint,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            OcrRetryActionButtons(
              retakeLabel: l10n.ocrNoTextRetakePhoto,
              galleryLabel: l10n.ocrNoTextChooseGallery,
              onRetake: () => _retakePhoto(context),
              onChooseGallery: () => _chooseFromGallery(context),
            ),
          ],
        ),
      ),
    );
  }
}
