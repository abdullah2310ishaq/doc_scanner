import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../l10n/app_localizations.dart';
import '../models/ocr_text_block.dart';
import '../providers/ocr_analyze_provider.dart';
import '../utils/ocr_image_layout.dart';
import '../../translate/screens/translate_result_screen.dart';
import 'ocr_no_text_screen.dart';
import '../widgets/ocr_analyze_action_bar.dart';
import '../widgets/ocr_text_highlight_overlay.dart';

class OcrAnalyzeScreen extends StatelessWidget {
  const OcrAnalyzeScreen({super.key});

  static Future<void> open(
    BuildContext context, {
    required String imagePath,
    bool replaceCurrentRoute = false,
  }) {
    final route = MaterialPageRoute<void>(
      builder: (_) => ChangeNotifierProvider(
        create: (_) => OcrAnalyzeProvider(imagePath: imagePath)..analyze(),
        child: const OcrAnalyzeScreen(),
      ),
    );

    final navigator = Navigator.of(context);
    if (replaceCurrentRoute) {
      return navigator.pushReplacement(route);
    }
    return navigator.push(route);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Consumer<OcrAnalyzeProvider>(
      builder: (context, provider, _) {
        if (provider.status == OcrAnalyzeStatus.empty) {
          return const OcrNoTextScreen();
        }

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            title: Text(l10n.ocrAnalyzeTitle),
            backgroundColor: AppColors.scaffoldBackground,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
          ),
          body: _buildBody(context, provider, l10n),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    OcrAnalyzeProvider provider,
    AppLocalizations l10n,
  ) {
    switch (provider.status) {
      case OcrAnalyzeStatus.loading:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                l10n.ocrAnalyzeProcessing,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        );
      case OcrAnalyzeStatus.empty:
        return const SizedBox.shrink();
      case OcrAnalyzeStatus.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.errorOcrFailed,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: provider.analyze,
                  child: Text(l10n.commonRetry),
                ),
              ],
            ),
          ),
        );
      case OcrAnalyzeStatus.ready:
        final result = provider.result;
        if (result == null) {
          return Center(child: Text(l10n.ocrEmpty));
        }
        return _OcrAnalyzeBody(
          imagePath: result.imagePath,
          fullText: result.fullText,
          blocks: result.blocks,
          imageSize: result.imageSize,
          copyLabel: l10n.ocrAnalyzeCopy,
          translateLabel: l10n.ocrAnalyzeTranslate,
          copySuccessMessage: l10n.ocrCopySuccess,
          emptyMessage: l10n.ocrEmpty,
        );
    }
  }
}

class _OcrAnalyzeBody extends StatelessWidget {
  const _OcrAnalyzeBody({
    required this.imagePath,
    required this.fullText,
    required this.blocks,
    required this.imageSize,
    required this.copyLabel,
    required this.translateLabel,
    required this.copySuccessMessage,
    required this.emptyMessage,
  });

  final String imagePath;
  final String fullText;
  final List<OcrTextBlock> blocks;
  final Size imageSize;
  final String copyLabel;
  final String translateLabel;
  final String copySuccessMessage;
  final String emptyMessage;

  Future<void> _copyText(BuildContext context) async {
    if (fullText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(emptyMessage)));
      return;
    }

    await Clipboard.setData(ClipboardData(text: fullText));
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(copySuccessMessage)));
  }

  void _onTranslate(BuildContext context) {
    if (fullText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(emptyMessage)));
      return;
    }

    TranslateResultScreen.open(context, sourceText: fullText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: OcrAnalyzeActionBar(
            copyLabel: copyLabel,
            translateLabel: translateLabel,
            onCopy: () => _copyText(context),
            onTranslate: () => _onTranslate(context),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final layout = OcrImageLayout.fromContainer(
                imageSize: imageSize,
                containerSize: constraints.biggest,
              );

              return Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: layout.offset.dx,
                    top: layout.offset.dy,
                    width: layout.displaySize.width,
                    height: layout.displaySize.height,
                    child: Image.file(File(imagePath), fit: BoxFit.fill),
                  ),
                  Positioned(
                    left: layout.offset.dx,
                    top: layout.offset.dy,
                    width: layout.displaySize.width,
                    height: layout.displaySize.height,
                    child: OcrTextHighlightOverlay(
                      blocks: blocks,
                      layout: layout,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
