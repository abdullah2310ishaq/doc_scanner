import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/toast.dart';
import '../../pdf_assistant/screens/pdf_assistant_detail_screen.dart';
import '../../pdf_assistant/services/pdf_assistant_file_actions_service.dart';

/// Step 7 — PDF ready: preview, save, share.
class SmartCropPdfResultScreen extends StatefulWidget {
  const SmartCropPdfResultScreen({
    super.key,
    required this.pdfPath,
    required this.imagePath,
    this.pageCount = 1,
  });

  final String pdfPath;
  final String imagePath;
  final int pageCount;

  @override
  State<SmartCropPdfResultScreen> createState() =>
      _SmartCropPdfResultScreenState();
}

class _SmartCropPdfResultScreenState extends State<SmartCropPdfResultScreen> {
  final _fileActions = PdfAssistantFileActionsService();
  bool _isSaving = false;

  String _getFileName() => widget.pdfPath.split(Platform.pathSeparator).last;

  String _getFileSize() {
    try {
      final file = File(widget.pdfPath);
      if (file.existsSync()) {
        final bytes = file.lengthSync();
        if (bytes < 1024) return '$bytes B';
        final kb = bytes / 1024;
        if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
        return '${(kb / 1024).toStringAsFixed(1)} MB';
      }
    } catch (_) {}
    return '';
  }

  Future<void> _handleSave() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    try {
      await _fileActions.saveToDownloads(
        widget.pdfPath,
        _getFileName(),
      );
      if (mounted) {
        AppToast.show(context, context.l10n.pdfAssistantDownloadSuccess);
      }
    } catch (_) {
      if (mounted) AppToast.show(context, context.l10n.exportFailed);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _handleShare() async {
    try {
      await _fileActions.shareFile(
        widget.pdfPath,
        subject: 'Smart Crop Document',
      );
    } catch (_) {
      if (mounted) AppToast.show(context, context.l10n.exportFailed);
    }
  }

  void _handleViewPdf() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PdfAssistantDetailScreen(
          title: context.l10n.smartCropCroppedTitle,
          pdfPath: widget.pdfPath,
          onShare: _handleShare,
          onDownload: _handleSave,
          onDelete: () async {
            try {
              await File(widget.pdfPath).delete();
            } catch (_) {}
            if (mounted) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
        ),
      ),
    );
  }

  void _handleDone() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pageLabel = widget.pageCount > 1
        ? '${widget.pageCount} ${l10n.smartCropPdfPagesLabel}'
        : l10n.smartCropPdfSinglePageLabel;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.white),
          onPressed: _handleDone,
        ),
        title: Text(
          l10n.smartCropTitle,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00FF66).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFF00FF66),
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.smartCropPdfSuccess,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade900),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 64,
                        height: 80,
                        child: Image.file(
                          File(widget.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getFileName(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _getFileSize(),
                            style: TextStyle(
                              color: AppColors.white.withValues(alpha: 0.5),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            pageLabel,
                            style: TextStyle(
                              color: AppColors.white.withValues(alpha: 0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _isSaving ? null : _handleSave,
                icon: _isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : const Icon(Icons.download, size: 20),
                label: Text(
                  _isSaving ? l10n.commonSaving : l10n.commonSave,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B61FF),
                  foregroundColor: AppColors.white,
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _handleViewPdf,
                icon: const Icon(Icons.picture_as_pdf, size: 20),
                label: Text(l10n.pdfAssistantActionOpen),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.white,
                  side: BorderSide(color: Colors.grey.shade800),
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: _handleShare,
                icon: const Icon(Icons.share, color: Color(0xFF9E8AFF)),
                label: Text(
                  l10n.commonShare,
                  style: const TextStyle(color: Color(0xFF9E8AFF)),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _handleDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade900,
                  foregroundColor: AppColors.white,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text(l10n.scanDone),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
