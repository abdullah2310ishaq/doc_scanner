import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/toast.dart';
import '../models/smart_crop_page_model.dart';
import '../../home/providers/recent_documents_provider.dart';
import '../../home/services/recent_documents_service.dart';
import '../services/smart_crop_crop_service.dart';
import 'smart_crop_filters_screen.dart';

enum ProcessingStep { reading, detecting, cropping, generating, completed }

enum _StepState { completed, active, pending }

/// Step 4 — ML Kit / edge detect + perspective crop (Premium Loading UI).
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

  // State states to mirror the premium design dynamically
  ProcessingStep _currentStep = ProcessingStep.reading;
  double _overallProgress = 0.0; // Circular progress value (0.0 to 1.0)
  double _bottomBarProgress = 0.0; // Bottom linear indicator progress

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _runCrop());
  }

  static const _minTotalDuration = Duration(milliseconds: 3500);

  Future<void> _runCrop() async {
    if (widget.pages.isEmpty) {
      if (mounted) Navigator.of(context).pop();
      return;
    }

    final started = DateTime.now();

    try {
      // Phase 1: Reading Images
      _updateProgress(ProcessingStep.reading, 0.25, 0.15);
      await Future<void>.delayed(const Duration(milliseconds: 700));

      // Phase 2: Detecting document edges
      _updateProgress(ProcessingStep.detecting, 0.50, 0.40);
      await Future<void>.delayed(const Duration(milliseconds: 900));

      // Phase 3: Cropping Images (actual work; ML Kit pages pass-through + trim)
      _updateProgress(ProcessingStep.cropping, 0.75, 0.65);
      final croppedPaths = await _cropService.cropAllPages(widget.pages);
      final recentDocs = RecentDocumentsService();
      for (final path in croppedPaths) {
        await recentDocs.registerImage(path);
      }
      await RecentDocumentsProvider.refreshGlobal();

      // Phase 4: Preparing for filters
      _updateProgress(ProcessingStep.generating, 0.95, 0.90);
      await Future<void>.delayed(const Duration(milliseconds: 600));

      _updateProgress(ProcessingStep.completed, 1.0, 1.0);

      final elapsed = DateTime.now().difference(started);
      if (elapsed < _minTotalDuration) {
        await Future.delayed(_minTotalDuration - elapsed);
      }

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

  void _updateProgress(ProcessingStep step, double circular, double linear) {
    if (mounted) {
      setState(() {
        _currentStep = step;
        _overallProgress = circular;
        _bottomBarProgress = linear;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Design Tokens matching your premium design
    const Color primaryColor = Color(0xFF4D5BFF);
    const Color textColorPrimary = Color(0xFF1A1A1A);
    const Color textColorSecondary = Color(0xFF707070);
    const Color trackColor = Color(0xFFEEF0FF);

    return Scaffold(
      backgroundColor: AppColors.smartCropSoftBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textColorPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.l10n.smartCropTitle,
          style: const TextStyle(
            color: textColorPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // 1. Large Circular Progress Indicator with text inside
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 140,
                      child: CircularProgressIndicator(
                        value: _overallProgress,
                        strokeWidth: 8,
                        backgroundColor: trackColor,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          primaryColor,
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      '${(_overallProgress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // 2. Center Headers
              Text(
                context.l10n.smartCropProcessingCrop,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: textColorPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  context.l10n.smartCropDetectingEdges,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: textColorSecondary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),

              const Spacer(flex: 3),

              // 3. Status Step Checklists
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildStatusRow(
                      label: 'Reading Images',
                      status: _getStepStatus(ProcessingStep.reading),
                    ),
                    const SizedBox(height: 16),
                    _buildStatusRow(
                      label: 'Detecting document edges',
                      status: _getStepStatus(ProcessingStep.detecting),
                    ),
                    const SizedBox(height: 16),
                    _buildStatusRow(
                      label: 'Cropping Images',
                      status: _getStepStatus(ProcessingStep.cropping),
                    ),
                    const SizedBox(height: 16),
                    _buildStatusRow(
                      label: 'Generating PDF',
                      status: _getStepStatus(ProcessingStep.generating),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 4),

              // 4. Fine Linear Bottom Progress Tracking Bar
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _bottomBarProgress,
                        minHeight: 6,
                        backgroundColor: const Color(0xFFE0E0E0),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${(_bottomBarProgress * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textColorPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Determines state condition for individual processing milestones
  _StepState _getStepStatus(ProcessingStep rowStep) {
    if (_currentStep.index > rowStep.index) {
      return _StepState.completed;
    } else if (_currentStep == rowStep) {
      return _StepState.active;
    } else {
      return _StepState.pending;
    }
  }

  // Row builder reflecting step progression
  Widget _buildStatusRow({required String label, required _StepState status}) {
    Widget trailingWidget;
    Color dotColor = const Color(0xFF4D5BFF);

    switch (status) {
      case _StepState.completed:
        trailingWidget = const Icon(
          Icons.check_circle,
          color: Color(0xFF2E7D32),
          size: 22,
        );
        break;
      case _StepState.active:
        trailingWidget = const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9E9E9E)),
          ),
        );
        break;
      case _StepState.pending:
        dotColor = const Color(0xFF4D5BFF).withOpacity(0.4);
        trailingWidget = Icon(
          Icons.radio_button_unchecked,
          color: const Color(0xFF1A1A1A).withOpacity(0.15),
          size: 22,
        );
        break;
    }

    return Row(
      children: [
        Icon(Icons.circle, size: 6, color: dotColor),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: const Color(
                0xFF1A1A1A,
              ).withOpacity(status == _StepState.pending ? 0.5 : 1.0),
              fontSize: 15,
              fontWeight: status == _StepState.active
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
        ),
        trailingWidget,
      ],
    );
  }
}
