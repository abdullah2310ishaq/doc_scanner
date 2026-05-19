import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../translate/models/translate_language.dart';
import '../../translate/widgets/translate_language_sheet.dart';
import '../constants/pdf_assistant_languages.dart';
import '../services/pdf_assistant_storage_service.dart';
import 'pdf_assistant_processing_screen.dart';

class StartProcessingScreen extends StatefulWidget {
  const StartProcessingScreen({
    super.key,
    this.pdfPath,
    this.displayName,
  });

  final String? pdfPath;
  final String? displayName;

  static Future<void> open(
    BuildContext context, {
    String? pdfPath,
    String? displayName,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StartProcessingScreen(
          pdfPath: pdfPath,
          displayName: displayName,
        ),
      ),
    );
  }

  @override
  State<StartProcessingScreen> createState() => _StartProcessingScreenState();
}

class _StartProcessingScreenState extends State<StartProcessingScreen> {
  final PdfAssistantStorageService _storage = PdfAssistantStorageService();

  String? _pdfPath;
  String? _displayName;
  int? _fileSizeBytes;
  TranslateLanguage? _targetLanguage;

  @override
  void initState() {
    super.initState();
    _pdfPath = widget.pdfPath;
    _displayName = widget.displayName;
    _loadFileMeta();
  }

  Future<void> _loadFileMeta() async {
    final path = _pdfPath;
    if (path == null) return;
    final size = await _storage.fileSizeBytes(path);
    if (!mounted) return;
    setState(() => _fileSizeBytes = size);
  }

  void _clearFile() {
    setState(() {
      _pdfPath = null;
      _displayName = null;
      _fileSizeBytes = null;
    });
  }

  void _openLanguageSheet() {
    final l10n = context.l10n;
    showTranslateLanguageSheet(
      context,
      title: l10n.pdfAssistantTranslateTo,
      searchHint: l10n.translateSearchLanguage,
      recentLabel: l10n.translateRecentLanguages,
      emptyLabel: l10n.translateNoLanguagesFound,
      languages: PdfAssistantLanguages.all,
      selected: _targetLanguage,
      onSelected: (language) => setState(() => _targetLanguage = language),
    );
  }

  void _startProcessing() {
    final path = _pdfPath;
    final language = _targetLanguage;
    final l10n = context.l10n;

    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pdfAssistantNoFileSelected)),
      );
      return;
    }

    if (language == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pdfAssistantSelectLanguage)),
      );
      return;
    }

    PdfAssistantProcessingScreen.open(
      context,
      originalPath: path,
      displayName: _displayName ?? _storage.displayNameFromPath(path),
      targetLanguage: language,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasFile = _pdfPath != null;

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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PdfPreviewCard(
                hasFile: hasFile,
                displayName: _displayName,
                fileSizeLabel: _storage.formatFileSize(_fileSizeBytes),
                noFileLabel: l10n.pdfAssistantNoFileSelected,
                onClear: hasFile ? _clearFile : null,
              ),
              const SizedBox(height: 24),
              Text(
                l10n.pdfAssistantTranslateTo,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _openLanguageSheet,
                borderRadius: BorderRadius.circular(12),
                child: Ink(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.searchBorder),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _targetLanguage?.name ??
                                l10n.translateSelectLanguage,
                            style: TextStyle(
                              fontSize: 16,
                              color: _targetLanguage == null
                                  ? AppColors.textSecondary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _startProcessing,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.chatbotAccent,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    l10n.pdfAssistantStartProcessing,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PdfPreviewCard extends StatelessWidget {
  const _PdfPreviewCard({
    required this.hasFile,
    required this.displayName,
    required this.fileSizeLabel,
    required this.noFileLabel,
    this.onClear,
  });

  final bool hasFile;
  final String? displayName;
  final String fileSizeLabel;
  final String noFileLabel;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.searchBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.cardPdfBg,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(HomeAssets.pdf, width: 28, height: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasFile ? (displayName ?? 'PDF') : noFileLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (hasFile && fileSizeLabel.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    fileSizeLabel,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onClear != null)
            IconButton(
              onPressed: onClear,
              icon: const Icon(Icons.close_rounded),
              tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            ),
        ],
      ),
    );
  }
}
