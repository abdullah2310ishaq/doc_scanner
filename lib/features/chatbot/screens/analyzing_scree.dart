import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/toast.dart';
import '../providers/chatbot_analyze_provider.dart';
import 'document_ready_summary_screen.dart';

enum StepStatus { pending, loading, completed }

class AnalyzeScreen extends StatefulWidget {
  const AnalyzeScreen({super.key, required this.pdfPath});

  final String pdfPath;

  static Future<void> open(BuildContext context, {required String pdfPath}) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => ChatbotAnalyzeProvider(sourcePdfPath: pdfPath)..start(),
          child: AnalyzeScreen(pdfPath: pdfPath),
        ),
      ),
    );
  }

  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  bool _navigated = false;

  void _onAnalyzeUpdate(ChatbotAnalyzeProvider provider) {
    if (_navigated || provider.status != ChatbotAnalyzeStatus.success) {
      return;
    }

    final session = provider.session;
    if (session == null) return;

    _navigated = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => DocumentReadySummaryScreen(
            sessionId: session.id,
            displayName: session.displayName,
            summary: session.summary,
          ),
        ),
      );
    });
  }

  void _onAnalyzeFailed(ChatbotAnalyzeProvider provider) {
    if (_navigated || provider.status != ChatbotAnalyzeStatus.failed) {
      return;
    }

    _navigated = true;
    final l10n = context.l10n;
    final message = provider.errorCode == 'empty_pdf'
        ? l10n.errorChatbotPdfEmpty
        : l10n.chatbotAnalyzeFailed;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      AppToast.show(context, message);
      Navigator.of(context).pop();
    });
  }

  StepStatus _statusForStep(ChatbotAnalyzeProvider provider, int index) {
    if (provider.status == ChatbotAnalyzeStatus.success) {
      return StepStatus.completed;
    }

    if (index < provider.completedSteps) {
      return StepStatus.completed;
    }
    if (index == provider.completedSteps &&
        provider.status == ChatbotAnalyzeStatus.running) {
      return StepStatus.loading;
    }
    return StepStatus.pending;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Consumer<ChatbotAnalyzeProvider>(
      builder: (context, provider, _) {
        _onAnalyzeUpdate(provider);
        _onAnalyzeFailed(provider);

        final stepTitles = [
          l10n.chatbotStepReadingPdf,
          l10n.chatbotStepExtractingText,
          l10n.chatbotStepUnderstandingContent,
          l10n.chatbotStepPreparingChat,
        ];
        final progressPercentage = (provider.progressFraction * 100).round();

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackground,
            elevation: 0,
            foregroundColor: AppColors.textPrimary,
            title: Text(
              l10n.chatbotTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image.asset(
                    'assets/chatbot/analyze.png',
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    l10n.chatbotAnalyzingTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.chatbotAnalyzingSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: List.generate(stepTitles.length, (index) {
                      return _StepItemRow(
                        title: stepTitles[index],
                        status: _statusForStep(provider, index),
                      );
                    }),
                  ),
                  const Spacer(flex: 3),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: provider.progressFraction,
                            minHeight: 7,
                            backgroundColor: AppColors.searchBorder,
                            color: AppColors.navbarGradientStart,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '$progressPercentage%',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
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
      },
    );
  }
}

class _StepItemRow extends StatelessWidget {
  const _StepItemRow({required this.title, required this.status});

  final String title;
  final StepStatus status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: AppColors.chatbotAccent),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: status == StepStatus.pending
                    ? AppColors.textSecondary.withValues(alpha: 0.6)
                    : AppColors.textPrimary,
              ),
            ),
          ),
          _buildTrailingIndicator(),
        ],
      ),
    );
  }

  Widget _buildTrailingIndicator() {
    switch (status) {
      case StepStatus.completed:
        return const Icon(
          Icons.check_circle,
          color: Color(0xFF2ECC71),
          size: 22,
        );
      case StepStatus.loading:
        return const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.chatbotAccent,
          ),
        );
      case StepStatus.pending:
        return Icon(
          Icons.radio_button_unchecked,
          color: AppColors.textSecondary.withValues(alpha: 0.35),
          size: 22,
        );
    }
  }
}
