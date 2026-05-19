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
      backgroundColor: AppColors
          .scaffoldBackground, // Ensure this is a very light grey/white like the image
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Text(
          displayName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Success Message Box (Light Green Banner)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4FBF7), // Light green background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xEFE2F3EB)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF2ECC71), // Vibrant green check
                      size: 36,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.chatbotDocumentReadyTitle, // "Document Ready!"
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF27AE60),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.chatbotDocumentReadySubtitle, // "You can now chat with your PDF"
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF27AE60),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 2. Document Summary Card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.chatbotCurrentSummary, // "Document Summary"
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(
                            summary,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: AppColors.textPrimary.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 3. Start Chatting Button
              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    ChatbotChatScreen.open(
                      context,
                      sessionId: sessionId,
                      displayName: displayName,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors
                        .chatbotAccent, // Make sure this matches the blue/purple button color
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
                      letterSpacing: 0.5,
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
