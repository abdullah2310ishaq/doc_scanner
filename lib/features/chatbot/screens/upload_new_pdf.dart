import 'dart:io';

import 'package:doc_scanner/features/chatbot/screens/chats_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/chatbot_assets.dart';
import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../services/chatbot_pdf_picker_service.dart';
import '../widgets/chatbot_upload_options_sheet.dart';
import 'analyzing_scree.dart';

class UploadNewPdfScreen extends StatefulWidget {
  const UploadNewPdfScreen({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const UploadNewPdfScreen()));
  }

  @override
  State<UploadNewPdfScreen> createState() => _UploadNewPdfScreenState();
}

class _UploadNewPdfScreenState extends State<UploadNewPdfScreen> {
  final ChatbotPdfPickerService _pdfPickerService = ChatbotPdfPickerService();

  void _openUploadSheet() {
    showChatbotUploadOptionsSheet(
      context,
      onChoosePdf: _pickPdfFromDevice,
      onRecentFiles: () => HistoryScreen.open(context),
    );
  }

  Future<void> _pickPdfFromDevice() async {
    try {
      final file = await _pdfPickerService.pickPdf();
      if (!mounted || file == null) {
        return;
      }
      _onPdfSelected(file);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.errorChatbotPdfPickFailed)),
      );
    }
  }

  void _onPdfSelected(File file) {
    AnalyzeScreen.open(context, pdfPath: file.path);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          l10n.chatbotTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final openUploadSheet = await HistoryScreen.open(context);
              if (!mounted || openUploadSheet != true) {
                return;
              }
              _openUploadSheet();
            },
            tooltip: l10n.chatbotHistoryButton,
            icon: const Icon(Icons.history_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _ChatbotBadge(label: l10n.chatbotBadge),
                    const SizedBox(height: 24),
                    _ChatbotHeadline(
                      chatLabel: l10n.chatbotHeadlineChat,
                      middleLabel: l10n.chatbotHeadlineMiddle,
                      pdfLabel: l10n.chatbotHeadlinePdf,
                    ),
                    const SizedBox(height: 24),
                    Image.asset(
                      ChatbotAssets.illustration,
                      fit: BoxFit.contain,
                      height: 190,
                    ),
                    const SizedBox(height: 24),
                    const _TipsDivider(),
                    const SizedBox(height: 16),
                    _TipsList(
                      tips: [
                        l10n.chatbotSuggestSummarize,
                        l10n.chatbotSuggestKeyPoints,
                        l10n.chatbotSuggestExplain,
                        l10n.chatbotSuggestTranslate,
                        l10n.chatbotAskQuestions, // Make sure this key exists or map your relevant l10n string
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: _UploadPdfButton(
                label: l10n.chatbotUploadHint, // E.g., "Upload a PDF"
                onTap: _openUploadSheet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatbotBadge extends StatelessWidget {
  const _ChatbotBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardChatbotBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            HomeAssets.sparkles,
            width: 14,
            height: 14,
            colorFilter: const ColorFilter.mode(
              AppColors.chatbotAccent,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.chatbotAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatbotHeadline extends StatelessWidget {
  const _ChatbotHeadline({
    required this.chatLabel,
    required this.middleLabel,
    required this.pdfLabel,
  });

  final String chatLabel;
  final String middleLabel;
  final String pdfLabel;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 1.2,
          color: AppColors.textPrimary,
        ),
        children: [
          TextSpan(
            text: '$chatLabel ',
            style: const TextStyle(color: AppColors.chatbotAccent),
          ),
          TextSpan(text: '$middleLabel '),
          TextSpan(
            text: pdfLabel,
            style: const TextStyle(color: AppColors.chatbotAccent),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _TipsDivider extends StatelessWidget {
  const _TipsDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.searchBorder)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Tips',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.searchBorder)),
      ],
    );
  }
}

class _TipsList extends StatelessWidget {
  const _TipsList({required this.tips});

  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tips.map((tip) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.circle, size: 6, color: AppColors.chatbotAccent),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  tip,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _UploadPdfButton extends StatelessWidget {
  const _UploadPdfButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2F69FF), Color(0xFF6B58FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.attach_file_rounded,
                  color: AppColors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
