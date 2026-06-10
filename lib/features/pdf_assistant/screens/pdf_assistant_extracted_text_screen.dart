import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/toast.dart';
import '../services/pdf_assistant_file_actions_service.dart';

class PdfAssistantExtractedTextScreen extends StatefulWidget {
  const PdfAssistantExtractedTextScreen({
    super.key,
    required this.title,
    required this.pdfPath, // Still pass pdfPath in case .txt is missing (old sessions)
    required this.onDelete,
  });

  final String title;
  final String pdfPath;
  final VoidCallback onDelete;

  @override
  State<PdfAssistantExtractedTextScreen> createState() =>
      _PdfAssistantExtractedTextScreenState();
}

class _PdfAssistantExtractedTextScreenState
    extends State<PdfAssistantExtractedTextScreen> {
  String? _content;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadText();
  }

  Future<void> _loadText() async {
    try {
      final txtPath = p.setExtension(widget.pdfPath, '.txt');
      final file = File(txtPath);
      
      if (await file.exists()) {
        final text = await file.readAsString();
        setState(() {
          _content = text;
          _isLoading = false;
        });
      } else {
        // Fallback for older sessions: extract from PDF directly
        final pdfFile = File(widget.pdfPath);
        if (await pdfFile.exists()) {
          final bytes = await pdfFile.readAsBytes();
          final doc = PdfDocument(inputBytes: bytes);
          final extractor = PdfTextExtractor(doc);
          final pages = <String>[];
          for (var i = 0; i < doc.pages.count; i++) {
            pages.add(extractor.extractText(startPageIndex: i, endPageIndex: i));
          }
          doc.dispose();
          setState(() {
            _content = pages.join('\n\n').trim();
            _isLoading = false;
          });
        } else {
          setState(() {
            _content = '';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _content = context.l10n.errorPdfTextLoad;
        _isLoading = false;
      });
    }
  }

  void _copyToClipboard() {
    if (_content != null && _content!.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _content!));
      AppToast.show(context, context.l10n.commonCopy);
    }
  }

  Future<void> _shareText() async {
    if (_content != null && _content!.isNotEmpty) {
      try {
        await PdfAssistantFileActionsService().shareFile(
          p.setExtension(widget.pdfPath, '.txt'),
          subject: widget.title,
        );
      } catch (_) {
        // If file share fails, try sharing raw text (optional, but package share_plus usually prefers files)
        AppToast.show(context, context.l10n.exportFailed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB), // Very light gray background like screenshot
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xffF9FAFB),
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black45),
            onSelected: (value) {
              if (value == 'copy') {
                _copyToClipboard();
              } else if (value == 'share') {
                _shareText();
              } else if (value == 'delete') {
                widget.onDelete();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'copy',
                child: Text(l10n.commonCopy),
              ),
              PopupMenuItem(
                value: 'share',
                child: Text(l10n.commonShare),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text(l10n.commonDelete, style:  TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Text(
                  _content ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5, // Good line height for readability
                    color: Color(0xff4B5563), // Dark gray text
                  ),
                ),
              ),
      ),
    );
  }
}
