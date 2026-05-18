import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../constants/dummy_languages.dart';
import '../providers/translate_result_provider.dart';
import '../widgets/translate_language_dropdown.dart';
import '../widgets/translate_save_buttons.dart';
import '../widgets/translate_text_card.dart';

class TranslateResultScreen extends StatelessWidget {
  const TranslateResultScreen({super.key, required this.sourceText});

  final String sourceText;

  static Future<void> open(BuildContext context, {required String sourceText}) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => TranslateResultProvider(sourceText: sourceText),
          child: TranslateResultScreen(sourceText: sourceText),
        ),
      ),
    );
  }

  Future<void> _copyText(
    BuildContext context,
    String text,
    String message,
  ) async {
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showComingSoon(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          l10n.translateResultTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.scaffoldBackground,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: Consumer<TranslateResultProvider>(
        builder: (context, provider, _) {
          final translatedDisplay = provider.isTranslating
              ? ''
              : provider.hasTranslation
              ? provider.translatedText
              : '';

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.translateResultSubtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                TranslateTextCard(
                  title: l10n.translateSelectedText,
                  text: sourceText,
                  placeholder: l10n.translatePasteHint,
                  seeMoreLabel: l10n.translateSeeMore,
                  copySemanticsLabel: l10n.commonCopy,
                  onCopy: () =>
                      _copyText(context, sourceText, l10n.ocrCopySuccess),
                ),
                const SizedBox(height: 16),
                TranslateLanguageDropdown(
                  key: ValueKey(provider.selectedLanguage?.code ?? 'none'),
                  label: l10n.translateSelectedLanguage,
                  hint: l10n.translateSelectLanguage,
                  languages: DummyLanguages.all,
                  value: provider.selectedLanguage,
                  onChanged: provider.selectLanguage,
                ),
                const SizedBox(height: 16),
                TranslateTextCard(
                  title: l10n.translateTranslatedText,
                  text: translatedDisplay,
                  placeholder: l10n.translatePlaceholder,
                  seeMoreLabel: l10n.translateSeeMore,
                  copySemanticsLabel: l10n.commonCopy,
                  readAloudSemanticsLabel: l10n.translateReadAloud,
                  isLoading: provider.isTranslating,
                  onCopy: provider.hasTranslation
                      ? () => _copyText(
                          context,
                          provider.translatedText,
                          l10n.translateCopyResult,
                        )
                      : null,
                  onReadAloud: provider.hasTranslation
                      ? () => _showComingSoon(
                          context,
                          l10n.translateSaveComingSoon,
                        )
                      : null,
                ),
                if (provider.errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.errorTranslateFailed,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  TextButton(
                    onPressed: provider.retryTranslation,
                    child: Text(l10n.commonRetry),
                  ),
                ],
                const Spacer(),
                TranslateSaveButtons(
                  savePdfLabel: l10n.translateSavePdf,
                  savePngLabel: l10n.translateSavePng,
                  onSavePdf: () =>
                      _showComingSoon(context, l10n.translateSaveComingSoon),
                  onSavePng: () =>
                      _showComingSoon(context, l10n.translateSaveComingSoon),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
