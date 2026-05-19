import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';

class PdfAssistantDetailScreen extends StatelessWidget {
  const PdfAssistantDetailScreen({
    super.key,
    required this.title,
    required this.pdfPath,
    required this.onShare,
    required this.onDownload,
    required this.onDelete,
  });

  final String title;
  final String pdfPath;
  final VoidCallback onShare;
  final VoidCallback onDownload;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'share') {
                onShare();
              } else if (value == 'download') {
                onDownload();
              } else if (value == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'share',
                child: Text(l10n.commonShare),
              ),
              PopupMenuItem(
                value: 'download',
                child: Text(l10n.pdfAssistantActionDownload),
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
      body: SfPdfViewer.file(
        File(pdfPath),
        canShowScrollHead: false,
      ),
    );
  }
}
