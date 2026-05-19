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
            fontSize: 18,
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _ChatbotBadge(label: l10n.chatbotBadge),
                    const SizedBox(height: 30),
                    _ChatbotHeadline(
                      chatLabel: l10n.chatbotHeadlineChat,
                      middleLabel: l10n.chatbotHeadlineMiddle,
                      pdfLabel: l10n.chatbotHeadlinePdf,
                    ),
                    const SizedBox(height: 30),
                    Image.asset(
                      ChatbotAssets.illustration,
                      fit: BoxFit.contain,
                      height: 240,
                    ),
                    const SizedBox(height: 24),
                    _TryAskingDivider(label: l10n.chatbotTryAsking),
                    const SizedBox(height: 16),

                    // Unbounded constraints error fix karne ke liye explicitly SizedBox diya hai
                    SizedBox(
                      // Parent padding (20 + 20 = 40) ko double kar ke compensation di hai taake cards bahar nikal saken
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        // Left aur Right par screen ke edge se halka sa (8px) gap rakhne ke liye padding adjust ki hai
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _SuggestionCardsGrid(
                          items: [
                            _SuggestionItem(
                              iconAsset: ChatbotAssets.suggestSummarize,
                              label: l10n.chatbotSuggestSummarize,
                            ),
                            _SuggestionItem(
                              iconAsset: ChatbotAssets.suggestKeyPoints,
                              label: l10n.chatbotSuggestKeyPoints,
                            ),
                            _SuggestionItem(
                              iconAsset: ChatbotAssets.suggestExplain,
                              label: l10n.chatbotSuggestExplain,
                            ),
                            _SuggestionItem(
                              iconAsset: ChatbotAssets.suggestTranslate,
                              label: l10n.chatbotSuggestTranslate,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: _UploadPdfBar(
                hint: l10n.chatbotUploadHint,
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
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.chatbotAccent,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
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
          fontSize: 28,
          fontWeight: FontWeight.w500,
          height: 1.2,
          color: AppColors.textPrimary,
        ),
        children: [
          TextSpan(
            text: chatLabel,
            style: const TextStyle(color: AppColors.chatbotAccent),
          ),
          TextSpan(text: middleLabel),
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

class _TryAskingDivider extends StatelessWidget {
  const _TryAskingDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.searchBorder)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.searchBorder)),
      ],
    );
  }
}

class _SuggestionItem {
  const _SuggestionItem({required this.iconAsset, required this.label});

  final String iconAsset;
  final String label;
}

// ListView ko Wrap se replace kiya taake scroll khatam ho aur aik hi dafa show ho saken
class _SuggestionCardsGrid extends StatelessWidget {
  const _SuggestionCardsGrid({required this.items});

  final List<_SuggestionItem> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.map((item) {
        return Expanded(
          child: Padding(
            // Cards ke aapas ka gap handle karne ke liye
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: _SuggestionCard(
              iconAsset: item.iconAsset,
              label: item.label,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.iconAsset, required this.label});

  final String iconAsset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height:
              110, // Width badhne ke sath height ko 110 kiya taake card square aur perfect dikhe
          // Internal padding kam ki taake content ko zyada jagah mile
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconAsset,
                width:
                    32, // Card bada hone ki wajah se icon size thoda increase kiya
                height: 32,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11, // Font thoda clear kiya
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UploadPdfBar extends StatelessWidget {
  const _UploadPdfBar({required this.hint, required this.onTap});

  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.searchBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.cardChatbotBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.attach_file_rounded,
                    color: AppColors.chatbotAccent,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    hint,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
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
