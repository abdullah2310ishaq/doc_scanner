import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/toast.dart';
import '../models/pdf_assistant_session_model.dart';
import '../services/pdf_assistant_file_actions_service.dart';
import '../services/pdf_assistant_storage_service.dart';

class PdfAssistantResultScreen extends StatelessWidget {
  const PdfAssistantResultScreen({super.key, required this.session});

  final PdfAssistantSessionModel session;

  Future<void> _open(BuildContext context, String path) async {
    try {
      await PdfAssistantFileActionsService().openFile(path);
    } catch (_) {
      if (!context.mounted) return;
      AppToast.show(context, context.l10n.pdfAssistantOpenFailed);
    }
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.pdfAssistantDeleteTitle),
        content: Text(l10n.pdfAssistantDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
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
                fallbackIcon: const Icon(
                  Icons.picture_as_pdf,
                  color: Color(0xff4A55E7),
                  size: 32,
                ),
                onOpen: () => _open(context, session.translatedPdfPath),
                onShare: () => _share(context, session.translatedPdfPath),
                onDownload: () => _download(
                  context,
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
                fallbackIcon: const Icon(
                  Icons.text_fields,
                  color: Color(0xff2E7D32),
                  size: 32,
                ),
                onOpen: () => _open(context, session.extractedTextPdfPath),
                onShare: () => _share(context, session.extractedTextPdfPath),
                onDownload: () => _download(
                  context,
                  session.extractedTextPdfPath,
                  '${session.displayName}_text.pdf',
                ),
              ),
              const Spacer(),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.redAccent),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _deleteSession(context),
                child: Text(l10n.commonDelete),
              ),
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
    required this.fallbackIcon,
    required this.onOpen,
    required this.onShare,
    required this.onDownload,
  });

  final String title;
  final String subtitle;
  final Color backgroundColor;
  final String iconAsset;
  final Widget fallbackIcon;
  final VoidCallback onOpen;
  final VoidCallback onShare;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // You can substitute this with SvgPicture.asset(iconAsset) from flutter_svg
              fallbackIcon,
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
          const SizedBox(height: 16),
          // Action Buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ActionChip(label: l10n.pdfAssistantActionOpen, onTap: onOpen),
              _ActionChip(label: l10n.commonShare, onTap: onShare),
              _ActionChip(
                label: l10n.pdfAssistantActionDownload,
                onTap: onDownload,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: Colors.white.withOpacity(0.8),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      onPressed: onTap,
    );
  }
}
