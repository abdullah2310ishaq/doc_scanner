import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../screens/start_processing_screen.dart';
import '../services/pdf_assistant_download_service.dart';
import '../services/pdf_assistant_picker_service.dart';
import '../services/pdf_assistant_storage_service.dart';

Future<void> showPdfAssistantSourceSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppColors.chatbotSheetRadius),
      ),
    ),
    builder: (sheetContext) => _PdfAssistantSourceSheet(
      parentContext: context,
    ),
  );
}

class _PdfAssistantSourceSheet extends StatefulWidget {
  const _PdfAssistantSourceSheet({required this.parentContext});

  final BuildContext parentContext;

  @override
  State<_PdfAssistantSourceSheet> createState() =>
      _PdfAssistantSourceSheetState();
}

class _PdfAssistantSourceSheetState extends State<_PdfAssistantSourceSheet> {
  final TextEditingController _urlController = TextEditingController();
  final PdfAssistantPickerService _picker = PdfAssistantPickerService();
  final PdfAssistantDownloadService _download = PdfAssistantDownloadService();
  final PdfAssistantStorageService _storage = PdfAssistantStorageService();
  bool _isDownloading = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _pickPdf() async {
    try {
      final file = await _picker.pickPdf();
      if (!mounted || file == null) return;

      Navigator.of(context).pop();
      if (!widget.parentContext.mounted) return;

      StartProcessingScreen.open(
        widget.parentContext,
        pdfPath: file.path,
        displayName: _storage.displayNameFromPath(file.path),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.errorPdfAssistantPickFailed)),
      );
    }
  }

  Future<void> _downloadFromLink() async {
    final url = _urlController.text.trim();
    if (url.isEmpty || _isDownloading) return;

    setState(() => _isDownloading = true);

    try {
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      final dir = await _storage.sessionDirectory(tempId);
      final fileName = _download.fileNameFromUrl(url);
      final savePath = '${dir.path}/$fileName';

      final file = await _download.downloadPdf(url, savePath);
      if (!mounted) return;

      Navigator.of(context).pop();
      if (!widget.parentContext.mounted) return;

      StartProcessingScreen.open(
        widget.parentContext,
        pdfPath: file.path,
        displayName: _storage.displayNameFromPath(file.path),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.errorPdfAssistantLinkFailed)),
      );
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        8,
        24,
        24 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.pdfAssistantSheetTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.pdfAssistantSheetSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 20),
          _OptionCard(
            backgroundColor: AppColors.chatbotSheetPdfBg,
            iconAsset: HomeAssets.pdf,
            title: l10n.pdfAssistantChoosePdfTitle,
            description: l10n.pdfAssistantChoosePdfDescription,
            onTap: _pickPdf,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.pdfAssistantLinkTitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _urlController,
            decoration: InputDecoration(
              hintText: l10n.pdfAssistantLinkHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: _isDownloading ? null : _downloadFromLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.chatbotAccent,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isDownloading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    )
                  : Text(l10n.pdfAssistantLinkButton),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.backgroundColor,
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final Color backgroundColor;
  final String iconAsset;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(iconAsset, width: 28, height: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
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
