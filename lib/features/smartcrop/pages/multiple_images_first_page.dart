import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../smart_crop_flow.dart';

/// Upload intro — then gallery picker → captured → crop → PDF.
class MultipleImagesFirstPage extends StatelessWidget {
  const MultipleImagesFirstPage({super.key});

  static const Color _primaryColor = Color(0xFF4D5FEF);
  static const Color _iconBgColor = Color(0xFFEEF0FF);

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const MultipleImagesFirstPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.smartCropTitle,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Center(
                child: Image.asset(
                  'assets/multiple_image_one.png',
                  height: MediaQuery.sizeOf(context).height * 0.28,
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(flex: 1),
              Text(
                l10n.smartCropUploadIntroHeadline,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  l10n.smartCropUploadIntroSubtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildStepRow(
                      assetPath: 'assets/first.svg',
                      title: l10n.smartCropUploadIntroStepSelect,
                    ),
                    const SizedBox(height: 16),
                    _buildStepRow(
                      assetPath: 'assets/second.svg',
                      title: l10n.smartCropUploadIntroStepCrop,
                    ),
                    const SizedBox(height: 16),
                    _buildStepRow(
                      assetPath: 'assets/third.svg',
                      title: l10n.smartCropUploadIntroStepPdf,
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => SmartCropFlow.pickGalleryImages(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  child: Text(l10n.smartCropUploadIntroSelectImages),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepRow({required String assetPath, required String title}) {
    return Row(
      children: [
        Container(child: SvgPicture.asset(assetPath, fit: BoxFit.contain)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
