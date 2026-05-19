import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/delete_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../models/pdf_assistant_session_model.dart';
import '../services/pdf_assistant_file_actions_service.dart';
import '../services/pdf_assistant_storage_service.dart';
import 'pdf_assistant_detail_screen.dart';
import 'pdf_assistant_extracted_text_screen.dart';

class PdfAssistantResultScreen extends StatelessWidget {
  const PdfAssistantResultScreen({super.key, required this.session});

  final PdfAssistantSessionModel session;

  void _openDetailedView(
    BuildContext context,
    String title,
    String pdfPath,
    String downloadName,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfAssistantDetailScreen(
          title: title,
          pdfPath: pdfPath,
          onShare: () => _share(context, pdfPath),
          onDownload: () => _download(context, pdfPath, downloadName),
          onDelete: () => _deleteSession(context),
        ),
      ),
    );
  }

  void _openExtractedTextScreen(BuildContext context, String title, String pdfPath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfAssistantExtractedTextScreen(
          title: title,
          pdfPath: pdfPath,
          onDelete: () => _deleteSession(context),
        ),
      ),
    );
  }

  Future<void> _share(BuildContext context, String path) async {
    try {
      await PdfAssistantFileActionsService().shareFile(
        path,
        subject: session.displayName,
      );
    } catch (_) {
      if (!context.mounted) return;
      AppToast.show(context, context.l10n.exportFailed);
    }
  }

  Future<void> _download(BuildContext context, String path, String name) async {
    try {
      await PdfAssistantFileActionsService().saveToDownloads(path, name);
      if (!context.mounted) return;
      AppToast.show(context, context.l10n.pdfAssistantDownloadSuccess);
    } catch (_) {
      if (!context.mounted) return;
      AppToast.show(context, context.l10n.exportFailed);
    }
  }

  Future<void> _deleteSession(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await DeleteDialog.show(
      context: context,
      title: l10n.pdfAssistantDeleteTitle,
      message: l10n.pdfAssistantDeleteMessage,
    );

    if (confirmed != true || !context.mounted) return;

    await PdfAssistantStorageService().deleteSession(session.id);
    if (!context.mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor:
          AppColors.white, // Matches clean white background in screenshot
      appBar: AppBar(
        title: Text(
          l10n.pdfAssistantResultTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ResultCard(
                title: l10n.pdfAssistantTranslatedPdfTitle,
                subtitle:
                    '${l10n.pdfAssistantTranslatedPdfDescription} ${session.targetLanguageName}',
                backgroundColor: const Color(0xffF2F2FC),
                iconAsset: 'assets/translated_pdf.svg',
                onTap: () => _openDetailedView(
                  context,
                  l10n.pdfAssistantTranslatedPdfTitle,
                  session.translatedPdfPath,
                  '${session.displayName}_translated.pdf',
                ),
              ),
              const SizedBox(height: 16),
              _ResultCard(
                title: l10n.pdfAssistantExtractedTextTitle,
                subtitle: l10n.pdfAssistantExtractedTextDescription,
                backgroundColor: const Color(0xffDCF0E0),
                iconAsset: 'assets/extracted_text.svg',
                onTap: () => _openExtractedTextScreen(
                  context,
                  l10n.pdfAssistantExtractedTextTitle,
                  session.extractedTextPdfPath,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.iconAsset,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color backgroundColor;
  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconAsset,
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
