import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/delete_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../services/smart_crop_pdf_file_service.dart';

/// In-app PDF viewer — rename / delete from ⋮ menu.
class SmartCropPdfViewScreen extends StatefulWidget {
  const SmartCropPdfViewScreen({
    super.key,
    required this.pdfPath,
    required this.displayName,
    this.onRenamed,
    this.onDeleted,
  });

  final String pdfPath;
  final String displayName;
  final void Function(String newPath, String newDisplayName)? onRenamed;
  final VoidCallback? onDeleted;

  static Future<void> open(
    BuildContext context, {
    required String pdfPath,
    required String displayName,
    void Function(String newPath, String newDisplayName)? onRenamed,
    VoidCallback? onDeleted,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SmartCropPdfViewScreen(
          pdfPath: pdfPath,
          displayName: displayName,
          onRenamed: onRenamed,
          onDeleted: onDeleted,
        ),
      ),
    );
  }

  @override
  State<SmartCropPdfViewScreen> createState() => _SmartCropPdfViewScreenState();
}

class _SmartCropPdfViewScreenState extends State<SmartCropPdfViewScreen> {
  final _fileService = SmartCropPdfFileService();
  late String _pdfPath;
  late String _displayName;

  @override
  void initState() {
    super.initState();
    _pdfPath = widget.pdfPath;
    _displayName = widget.displayName;
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
            decoration: InputDecoration(hintText: l10n.smartCropRenamePdfHint),
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
      widget.onRenamed?.call(newPath, newName);
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
      title: l10n.smartCropDeletePdfTitle,
      message: l10n.smartCropDeletePdfMessage,
    );

    if (confirmed != true || !mounted) return;

    try {
      await _fileService.deletePdf(_pdfPath);
      if (!mounted) return;
      widget.onDeleted?.call();
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      AppToast.show(context, l10n.commonError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final file = File(_pdfPath);

    return Scaffold(
      backgroundColor: AppColors.smartCropSoftBackground,
      appBar: AppBar(
        backgroundColor: AppColors.smartCropSoftBackground,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text(
          _displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
        top: false,
        child: file.existsSync()
            ? SfPdfViewer.file(file, canShowScrollHead: false)
            : Center(
                child: Text(
                  l10n.commonError,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),
      ),
    );
  }
}
