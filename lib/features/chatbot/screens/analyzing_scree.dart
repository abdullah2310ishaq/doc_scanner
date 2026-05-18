import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';

enum StepStatus { pending, loading, completed }

class AnalyzeScreen extends StatefulWidget {
  const AnalyzeScreen({super.key, this.pdfPath});

  final String? pdfPath;

  static Future<void> open(BuildContext context, {required String pdfPath}) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => AnalyzeScreen(pdfPath: pdfPath)),
    );
  }

  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  static const Duration _totalDuration = Duration(minutes: 10);
  static const int _stepCount = 4;

  late final List<StepStatus> _stepStatuses;
  Timer? _timer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _stepStatuses = List<StepStatus>.filled(_stepCount, StepStatus.pending);
    _stepStatuses[0] = StepStatus.loading;
    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onTick(Timer timer) {
    if (!mounted) {
      return;
    }

    _elapsedSeconds++;
    final secondsPerStep = _totalDuration.inSeconds ~/ _stepCount;

    setState(() {
      for (var i = 0; i < _stepCount; i++) {
        final stepEndSecond = (i + 1) * secondsPerStep;
        if (_elapsedSeconds >= stepEndSecond) {
          _stepStatuses[i] = StepStatus.completed;
        } else if (_elapsedSeconds >= i * secondsPerStep) {
          _stepStatuses[i] = StepStatus.loading;
        } else {
          _stepStatuses[i] = StepStatus.pending;
        }
      }
    });

    if (_elapsedSeconds >= _totalDuration.inSeconds) {
      timer.cancel();
    }
  }

  double get _progressFraction {
    final completed = _stepStatuses
        .where((s) => s == StepStatus.completed)
        .length;
    return completed / _stepCount;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final stepTitles = [
      l10n.chatbotStepReadingPdf,
      l10n.chatbotStepExtractingText,
      l10n.chatbotStepUnderstandingContent,
      l10n.chatbotStepPreparingChat,
    ];
    final progressPercentage = (_progressFraction * 100).round();

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
              SizedBox(height: 25),
              Column(
                children: List.generate(_stepCount, (index) {
                  return _StepItemRow(
                    title: stepTitles[index],
                    status: _stepStatuses[index],
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
                        value: _progressFraction,
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
