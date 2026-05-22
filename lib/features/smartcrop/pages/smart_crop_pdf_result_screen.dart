import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/delete_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../../pdf_assistant/services/pdf_assistant_file_actions_service.dart';
import '../../home/providers/recent_documents_provider.dart';
import '../../home/services/recent_documents_service.dart';
import '../services/smart_crop_pdf_file_service.dart';
import 'smart_crop_pdf_view_screen.dart';

/// PDF created — View / Save; ⋮ rename or delete.
class SmartCropPdfResultScreen extends StatefulWidget {
  const SmartCropPdfResultScreen({
    super.key,
    required this.pdfPath,
    required this.pageCount,
  });

  final String pdfPath;
  final int pageCount;

  @override
  State<SmartCropPdfResultScreen> createState() =>
      _SmartCropPdfResultScreenState();
}

class _SmartCropPdfResultScreenState extends State<SmartCropPdfResultScreen> {
  final _fileService = SmartCropPdfFileService();
  final _fileActions = PdfAssistantFileActionsService();

  late String _pdfPath;
  late String _displayName;

  @override
  void initState() {
    super.initState();
    _pdfPath = widget.pdfPath;
    _displayName = _baseNameFromPath(_pdfPath);
  }

  String _baseNameFromPath(String path) {
    final name = p.basenameWithoutExtension(path);
    return name.isNotEmpty ? name : 'document';
  }

  String get _fileSizeLabel {
    final file = File(_pdfPath);
    if (!file.existsSync()) return '—';
    return _fileService.formatFileSize(file.lengthSync());
  }

  Future<void> _rename() async {
    final l10n = context.l10n;
    final controller = TextEditingController(text: _displayName);

    final newName = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.smartCropRenamePdf),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: l10n.smartCropRenamePdfHint,
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(controller.text.trim()),
              child: Text(l10n.commonContinue),
            ),
          ],
        );
      },
    );

    if (newName == null || newName.isEmpty || !mounted) return;

    try {
      final newPath = await _fileService.renamePdf(
        pdfPath: _pdfPath,
        newBaseName: newName,
      );
      if (!mounted) return;
      setState(() {
        _pdfPath = newPath;
        _displayName = newName;
      });
      AppToast.show(context, l10n.smartCropPdfRenamed);
    } catch (_) {
      if (!mounted) return;
      AppToast.show(context, l10n.commonError);
    }
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await DeleteDialog.show(
      context: context,
      title: l10n.commonDelete,
      message: l10n.smartCropDeletePdfConfirm,
    );

    if (confirmed != true || !mounted) return;

    try {
      await _fileService.deletePdf(_pdfPath);
      if (!mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (_) {
      if (!mounted) return;
      AppToast.show(context, l10n.commonError);
    }
  }

  void _openView() {
    SmartCropPdfViewScreen.open(
      context,
      pdfPath: _pdfPath,
      displayName: _displayName,
      onRenamed: (newPath, newName) {
        if (!mounted) return;
        setState(() {
          _pdfPath = newPath;
          _displayName = newName;
        });
      },
      onDeleted: () {
        if (!mounted) return;
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> _savePdf() async {
    final l10n = context.l10n;
    try {
      final fileName = '$_displayName.pdf';
      await _fileActions.saveToDownloads(_pdfPath, fileName);
      await RecentDocumentsService().registerPdf(
        _pdfPath,
        displayName: _displayName,
      );
      await RecentDocumentsProvider.refreshGlobal();
      if (!mounted) return;
      AppToast.show(context, l10n.pdfAssistantDownloadSuccess);
    } catch (_) {
      if (!mounted) return;
      AppToast.show(context, l10n.commonError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pagesValue = widget.pageCount > 1
        ? '${widget.pageCount} ${l10n.smartCropPdfPagesLabel}'
        : l10n.smartCropPdfSinglePageLabel;

    return Scaffold(
      backgroundColor: AppColors.smartCropSoftBackground,
      appBar: AppBar(
        backgroundColor: AppColors.smartCropSoftBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        title: Text(
          l10n.smartCropTitle,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onSelected: (value) {
              if (value == 'rename') {
                _rename();
              } else if (value == 'delete') {
                _delete();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'rename',
                child: Text(l10n.smartCropRenamePdf),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  l10n.commonDelete,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Image.asset(
                'assets/pdf_created.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.picture_as_pdf_outlined,
                  size: 120,
                  color: AppColors.smartCropPrimary,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                l10n.smartCropPdfSuccess,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              const Spacer(flex: 2),
              _buildMetadataRow(
                label: l10n.smartCropPdfFileName,
                value: '$_displayName.pdf',
              ),
              _buildMetadataRow(
                label: l10n.smartCropPdfPagesLabel,
                value: pagesValue,
              ),
              _buildMetadataRow(
                label: l10n.smartCropPdfFileSize,
                value: _fileSizeLabel,
              ),
              const Spacer(flex: 4),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: File(_pdfPath).existsSync() ? _openView : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.smartCropPrimary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    l10n.smartCropViewPdf,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: File(_pdfPath).existsSync() ? _savePdf : null,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.smartCropRetakeBackground,
                    side: const BorderSide(color: AppColors.smartCropRetakeBorder),
                    foregroundColor: AppColors.smartCropPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    l10n.smartCropSavePdf,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(
              Icons.circle,
              size: 6,
              color: AppColors.smartCropPrimary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 11,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 14,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
