import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../in_app/paywall_routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/widgets/toast.dart';
import '../../subscription/providers/subscription_provider.dart';
import '../../translate/models/translate_language.dart';
import '../providers/pdf_assistant_process_provider.dart';
import 'pdf_assistant_result_screen.dart';

class PdfAssistantProcessingScreen extends StatefulWidget {
  const PdfAssistantProcessingScreen({
    super.key,
    required this.originalPath,
    required this.displayName,
    required this.targetLanguage,
  });

  final String originalPath;
  final String displayName;
  final TranslateLanguage targetLanguage;

  static Future<void> open(
    BuildContext context, {
    required String originalPath,
    required String displayName,
    required TranslateLanguage targetLanguage,
  }) async {
    final l10n = AppLocalizations.of(context);
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => PdfAssistantProcessProvider(
            originalPath: originalPath,
            displayName: displayName,
            targetLanguage: targetLanguage,
            pageLabelFor: l10n.pdfAssistantPageLabel,
          )..start(),
          child: PdfAssistantProcessingScreen(
            originalPath: originalPath,
            displayName: displayName,
            targetLanguage: targetLanguage,
          ),
        ),
      ),
    );
  }

  @override
  State<PdfAssistantProcessingScreen> createState() =>
      _PdfAssistantProcessingScreenState();
}

class _PdfAssistantProcessingScreenState
    extends State<PdfAssistantProcessingScreen> {
  bool _navigated = false;

  void _handleState(PdfAssistantProcessProvider provider) {
    if (_navigated) return;

    if (provider.status == PdfAssistantProcessStatus.success &&
        provider.session != null) {
      _navigated = true;
      final session = provider.session!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        final resultScreen = PdfAssistantResultScreen(session: session);
        final isPro = context.read<SubscriptionProvider>().isPro;

        if (isPro) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(builder: (_) => resultScreen),
          );
          return;
        }

        PaywallRoutes.replaceWithPostProcessGate(
          context,
          nextScreen: resultScreen,
        );
      });
    }

    if (provider.status == PdfAssistantProcessStatus.failed) {
      _navigated = true;
      final l10n = context.l10n;
      final message = provider.errorCode == 'empty_pdf'
          ? l10n.errorPdfAssistantPdfEmpty
          : l10n.pdfAssistantProcessFailed;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        AppToast.show(context, message);
        Navigator.of(context).pop();
      });
    }
  }

  String _stepLabel(
    PdfAssistantProcessProvider provider,
    AppLocalizations l10n,
  ) {
    return switch (provider.currentStep) {
      PdfAssistantProcessStep.extracting => l10n.pdfAssistantStepExtracting,
      PdfAssistantProcessStep.translating => l10n.pdfAssistantStepTranslating,
      PdfAssistantProcessStep.generatingPdf =>
        l10n.pdfAssistantStepGeneratingPdf,
      PdfAssistantProcessStep.finalizing => l10n.pdfAssistantStepFinalizing,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Consumer<PdfAssistantProcessProvider>(
      builder: (context, provider, _) {
        _handleState(provider);
        final percent = (provider.progressFraction * 100).round();

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            title: Text(l10n.pdfAssistantTitle),
            backgroundColor: AppColors.scaffoldBackground,
            elevation: 0,
            foregroundColor: AppColors.textPrimary,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset(HomeAssets.pdf, width: 64, height: 64),
                  const SizedBox(height: 16),
                  Text(
                    widget.displayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${l10n.pdfAssistantTranslateTo}: ${widget.targetLanguage.name}',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    l10n.pdfAssistantProcessingTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.pdfAssistantProcessingSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _stepLabel(provider, l10n),
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.chatbotAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: provider.progressFraction,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                    backgroundColor: AppColors.searchBorder,
                    color: AppColors.navbarGradientStart,
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.commonProgressPercent(percent)),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
