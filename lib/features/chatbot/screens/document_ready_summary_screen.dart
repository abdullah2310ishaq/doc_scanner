import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import 'chatbot_chat_screen.dart';

class DocumentReadySummaryScreen extends StatelessWidget {
  const DocumentReadySummaryScreen({
    super.key,
    required this.sessionId,
    required this.displayName,
    required this.summary,
  });

  final String sessionId;
  final String displayName;
  final String summary;

  static Future<void> open(
    BuildContext context, {
    required String sessionId,
    required String displayName,
    required String summary,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DocumentReadySummaryScreen(
          sessionId: sessionId,
          displayName: displayName,
          summary: summary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text(
          displayName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF2ECC71),
                size: 56,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.chatbotDocumentReadyTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.chatbotDocumentReadySubtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.chatbotCurrentSummary,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.chatbotAccent,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.searchBorder),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      summary,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    ChatbotChatScreen.open(
                      context,
                      sessionId: sessionId,
                      displayName: displayName,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.chatbotAccent,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.chatbotStartChatting,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
