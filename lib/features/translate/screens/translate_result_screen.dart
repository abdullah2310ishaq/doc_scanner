import 'package:doc_scanner/ads/back_inter_ad_service.dart';
import 'package:doc_scanner/core/providers/connectivity_provider.dart';
import 'package:doc_scanner/core/services/permission_service.dart';
import 'package:doc_scanner/core/utils/network_guard.dart';
import 'package:doc_scanner/core/widgets/permission_dialog.dart';
import 'package:doc_scanner/core/widgets/toast.dart';
import 'package:doc_scanner/core/widgets/loading_dialog.dart';
import 'package:doc_scanner/features/home/screens/main_shell_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/credit_gate.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../l10n/app_localizations.dart';
import '../constants/dummy_languages.dart';
import '../../home/providers/recent_documents_provider.dart';
import '../../subscription/models/feature_type.dart';
import '../models/translate_export_data.dart';
import '../models/translate_export_scope.dart';
import '../models/translate_language.dart';
import '../providers/translate_result_provider.dart';
import '../services/translate_errors.dart';
import '../services/translate_save_pdf_service.dart';
import '../services/translate_save_png_service.dart';
import '../widgets/translate_download_option_sheet.dart';
import '../widgets/translate_language_sheet.dart';
import '../widgets/translate_save_buttons.dart';
import '../widgets/translate_select_language_button.dart';
import '../widgets/translate_text_card.dart';

enum _TranslateSaveFormat { pdf, png }

class TranslateResultScreen extends StatelessWidget {
  const TranslateResultScreen({super.key, required this.sourceText});

  final String sourceText;

  static Future<void> open(BuildContext context, {required String sourceText}) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (routeContext) {
          final connectivity = routeContext.read<ConnectivityProvider>();
          return ChangeNotifierProvider(
            create: (_) => TranslateResultProvider(
              sourceText: sourceText,
              ensureOnline: connectivity.refresh,
              onConnectivityChanged: connectivity.onStatusChanged,
            ),
            child: TranslateResultScreen(sourceText: sourceText),
          );
        },
      ),
    );
  }

  void _goHome(BuildContext context) {
    BackInterAdService.handleBackToHome(
      context,
      onComplete: () {
        if (!context.mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(builder: (_) => const MainShellScreen()),
          (route) => false,
        );
      },
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
    AppToast.show(context, message);
  }

  void _showComingSoon(BuildContext context, String message) {
    AppToast.show(context, message);
  }

  TranslateExportData _exportData(
    AppLocalizations l10n,
    TranslateResultProvider provider,
  ) {
    return TranslateExportData(
      sourceText: sourceText,
      selectedTextLabel: l10n.translateSelectedText,
      translatedTextLabel: l10n.translateTranslatedText,
      translatedText: provider.hasTranslation ? provider.translatedText : null,
      targetLanguageName: provider.selectedLanguage?.name,
    );
  }

  void _showDownloadOptionSheet(
    BuildContext context,
    TranslateResultProvider provider,
    _TranslateSaveFormat format,
  ) {
    if (sourceText.trim().isEmpty) return;

    final l10n = context.l10n;
    final isPng = format == _TranslateSaveFormat.png;

    showTranslateDownloadOptionSheet(
      context,
      title: l10n.translateDownloadOptionTitle,
      subtitle: l10n.translateDownloadOptionSubtitle,
      selectedTextTitle: l10n.translateDownloadSelectedTextTitle,
      selectedTextDescription: l10n.translateDownloadSelectedTextDescription,
      completeFileTitle: isPng
          ? l10n.translateDownloadTranslatedTextTitle
          : l10n.translateDownloadCompleteFileTitle,
      completeFileDescription: isPng
          ? l10n.translateDownloadTranslatedTextDescription
          : l10n.translateDownloadCompleteFileDescription,
      onSelectedText: () =>
          _export(context, provider, format, TranslateExportScope.selectedText),
      onCompleteFile: () => _export(
        context,
        provider,
        format,
        isPng
            ? TranslateExportScope.translatedText
            : TranslateExportScope.completeFile,
      ),
    );
  }

  Future<void> _export(
    BuildContext context,
    TranslateResultProvider provider,
    _TranslateSaveFormat format,
    TranslateExportScope scope,
  ) async {
    final l10n = context.l10n;
    final connectivity = context.read<ConnectivityProvider>();

    final isOnline = await NetworkGuard.ensureOnline(connectivity);
    if (!context.mounted) return;
    if (!isOnline) {
      AppToast.show(
        context,
        l10n.errorNoInternetFeatures,
        backgroundColor: AppToast.errorBackground,
      );
      return;
    }

    final needsTranslation =
        scope == TranslateExportScope.completeFile ||
        scope == TranslateExportScope.translatedText;
    if (needsTranslation && !provider.hasTranslation) {
      AppToast.show(context, l10n.translateExportNeedsTranslation);
      return;
    }

    final needsPermission = await PermissionService().needsStoragePermission();
    if (!context.mounted) return;

    if (needsPermission) {
      final hasPermission = await ensureStoragePermission(context);
      if (!hasPermission) {
        if (!context.mounted) return;
        AppToast.show(context, l10n.permissionDenied);
        return;
      }
    }

    if (!context.mounted) return;

    final data = _exportData(l10n, provider);

    // Show loading dialog
    LoadingDialog.show(context, message: l10n.commonSaving);

    try {
      switch (format) {
        case _TranslateSaveFormat.pdf:
          await TranslateSavePdfService().save(
            data: data,
            scope: scope,
            l10n: l10n,
          );
        case _TranslateSaveFormat.png:
          final savedPath = await TranslateSavePngService().save(
            data: data,
            scope: scope,
            l10n: l10n,
          );
          if (context.mounted) {
            await context
                .read<RecentDocumentsProvider>()
                .registerImage(savedPath);
          }
      }

      if (!context.mounted) return;
      LoadingDialog.hide(context);

      final successMessage = switch (format) {
        _TranslateSaveFormat.pdf => l10n.translateSavePdfSuccess,
        _TranslateSaveFormat.png => l10n.translateSavePngSuccess,
      };
      AppToast.show(context, successMessage);
    } catch (error, stack) {
      if (kDebugMode) {
        debugPrint('[TranslateExport] $error\n$stack');
      }
      if (!context.mounted) return;
      LoadingDialog.hide(context);
      AppToast.show(context, l10n.exportFailed);
    }
  }

  String _translateErrorMessage(
    AppLocalizations l10n,
    TranslateFailure? failure,
  ) {
    return switch (failure) {
      TranslateFailure.unsupportedLanguage =>
        l10n.errorTranslateUnsupportedLanguage,
      TranslateFailure.noInternet => l10n.errorNoInternetFeatures,
      TranslateFailure.modelDownloadFailed => l10n.errorTranslateModelDownload,
      TranslateFailure.translationFailed => l10n.errorTranslateFailed,
      null => l10n.errorTranslateFailed,
    };
  }

  void _openLanguageSheet(
    BuildContext context,
    TranslateResultProvider provider,
  ) async {
    final l10n = context.l10n;
    final connectivity = context.read<ConnectivityProvider>();
    await NetworkGuard.ensureOnline(connectivity);
    if (!context.mounted) return;

    showTranslateLanguageSheet(
      context,
      title: l10n.translateSelectLanguage,
      searchHint: l10n.translateSearchLanguage,
      recentLabel: l10n.translateRecentLanguages,
      emptyLabel: l10n.translateNoLanguagesFound,
      languages: DummyLanguages.all(l10n),
      selected: provider.selectedLanguage,
      onSelected: (language) => _onLanguageSelected(context, provider, language),
    );
  }

  Future<void> _onLanguageSelected(
    BuildContext context,
    TranslateResultProvider provider,
    TranslateLanguage language,
  ) async {
    await provider.selectLanguage(language);
    if (!context.mounted) return;
    if (!provider.hasTranslation || provider.translateFailure != null) return;
    await CreditGate.recordGeneration(context, feature: FeatureType.ocrScan);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        _goHome(context);
      },
      child: Scaffold(
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _goHome(context),
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

          return SafeArea(
            bottom: true,
            child: Padding(
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
                  TranslateSelectLanguageButton(
                    label: l10n.translateSelectedLanguage,
                    hint: l10n.translateSelectLanguage,
                    selectedLanguage: provider.selectedLanguage,
                    onTap: () => _openLanguageSheet(context, provider),
                  ),
                  const SizedBox(height: 16),
                  TranslateTextCard(
                    title: l10n.translateTranslatedText,
                    subtitle: provider.selectedLanguage?.name,
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
                  if (provider.translateFailure != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _translateErrorMessage(l10n, provider.translateFailure),
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
                    onSavePdf: () => _showDownloadOptionSheet(
                      context,
                      provider,
                      _TranslateSaveFormat.pdf,
                    ),
                    onSavePng: () => _showDownloadOptionSheet(
                      context,
                      provider,
                      _TranslateSaveFormat.png,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
    );
  }
}
