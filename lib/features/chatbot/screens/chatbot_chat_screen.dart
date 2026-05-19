import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/delete_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../../../l10n/app_localizations.dart';
import '../models/chatbot_message_model.dart';
import '../providers/chatbot_chat_provider.dart';
import '../providers/chatbot_history_provider.dart';
import '../services/chatbot_storage_service.dart';
import 'chats_history_screen.dart';

class ChatbotChatScreen extends StatefulWidget {
  const ChatbotChatScreen({
    super.key,
    required this.sessionId,
    required this.displayName,
  });

  final String sessionId;
  final String displayName;

  static Future<void> open(
    BuildContext context, {
    required String sessionId,
    required String displayName,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) =>
              ChatbotChatProvider(sessionId: sessionId)..loadSession(),
          child: ChatbotChatScreen(
            sessionId: sessionId,
            displayName: displayName,
          ),
        ),
      ),
    );
  }

  @override
  State<ChatbotChatScreen> createState() => _ChatbotChatScreenState();
}

class _ChatbotChatScreenState extends State<ChatbotChatScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _sendMessage(ChatbotChatProvider provider, String text) async {
    if (text.trim().isEmpty) return;
    await provider.sendMessage(text.trim());
    _inputController.clear();
    _scrollToBottom();
  }

  Future<void> _shareChat(ChatbotChatProvider provider) async {
    final text = provider.buildShareText();
    if (text.isEmpty) return;
    await SharePlus.instance.share(
      ShareParams(text: text, subject: widget.displayName),
    );
  }

  Future<void> _copyChat(
    BuildContext context,
    ChatbotChatProvider provider,
  ) async {
    final text = provider.buildShareText();
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    AppToast.show(context, context.l10n.ocrCopySuccess);
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await DeleteDialog.show(
      context: context,
      title: l10n.chatbotDeleteTitle,
      message: l10n.chatbotDeleteMessage,
    );

    if (confirmed != true || !context.mounted) return;

    await ChatbotStorageService().deleteSession(widget.sessionId);

    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => ChatbotHistoryProvider()..loadSessions(),
          child: const HistoryScreen(),
        ),
      ),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Consumer<ChatbotChatProvider>(
      builder: (context, provider, _) {
        final title = provider.session?.displayName ?? widget.displayName;

        return Scaffold(
          backgroundColor: const Color(
            0xFFF8F9FA,
          ), // Clean UI background light grey
          appBar: AppBar(
            backgroundColor: const Color(0xFFF8F9FA),
            elevation: 0,
            foregroundColor: AppColors.textPrimary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'share':
                      _shareChat(provider);
                    case 'copy':
                      _copyChat(context, provider);
                    case 'delete':
                      _confirmDelete(context);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'share', child: Text(l10n.commonShare)),
                  PopupMenuItem(value: 'copy', child: Text(l10n.commonCopy)),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(l10n.commonDelete),
                  ),
                ],
              ),
            ],
          ),
          body: provider.isLoadingSession
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        children: [
                          if (provider.messages.isEmpty)
                            _WelcomeCard(l10n: l10n),
                          ...provider.messages.map(
                            (message) => _MessageBubble(message: message),
                          ),
                          if (provider.isSending)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.chatbotAccent,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (provider.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Text(
                          l10n.chatbotChatFailed,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    _ChatInputBar(
                      controller: _inputController,
                      hint: 'Ask anything about this PDF...',
                      isSending: provider.isSending,
                      onSend: (text) => _sendMessage(provider, text),
                      onSuggestionTap: (text) => _sendMessage(provider, text),
                      suggestions: [
                        l10n.chatbotChatPromptSummarize, // "Summarize this document"
                        l10n.chatbotChatPromptHighlights, // "What are the key highlights?"
                        l10n.chatbotChatPromptFinancial, // "Show me financial data"
                        l10n.chatbotChatPromptDates, // "Extract important dates"
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI Bot Avatar Icon Accent
        Container(
          margin: const EdgeInsets.only(bottom: 12, top: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEFF), // Light purple shade
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.android_rounded,
            color: AppColors.chatbotAccent,
            size: 24,
          ),
        ),

        // Greeting Card Box
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withOpacity(0.04)),
          ),
          child: const Text.rich(
            TextSpan(
              text: '👋🏻 Hi! I’m your AI assistant.\n',
              style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
              children: [
                TextSpan(
                  text: 'Ask me anything about this PDF and I’ll help you.',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
            style: TextStyle(fontSize: 15, color: AppColors.textPrimary),
          ),
        ),

        // "You can ask me" Onboarding Suggestions Card
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withOpacity(0.04)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'You can ask me:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              _buildBulletItem(l10n.chatbotChatPromptSummarize),
              _buildBulletItem(l10n.chatbotChatPromptHighlights),
              _buildBulletItem(l10n.chatbotChatPromptFinancial),
              _buildBulletItem(l10n.chatbotChatPromptDates),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 6, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatbotMessageModel message;

  // AI response clean helper structure
  String _cleanResponseText(String source) {
    // Is dynamic formatter se saare markdown '*' aur multiple inline hash headers filter clean ho jayenge
    return source.replaceAll(RegExp(r'\*+'), '').trim();
  }

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatbotMessageRole.user;
    final cleanedText = _cleanResponseText(message.content);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.8,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppColors.chatbotAccent : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          border: isUser
              ? null
              : Border.all(color: Colors.black.withOpacity(0.04)),
          boxShadow: [
            if (!isUser)
              BoxShadow(
                color: Colors.black.withOpacity(0.01),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Text(
          cleanedText,
          style: TextStyle(
            fontSize: 15,
            height: 1.45,
            color: isUser ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  const _ChatInputBar({
    required this.controller,
    required this.hint,
    required this.isSending,
    required this.onSend,
    required this.onSuggestionTap,
    required this.suggestions,
  });

  final TextEditingController controller;
  final String hint;
  final bool isSending;
  final ValueChanged<String> onSend;
  final ValueChanged<String> onSuggestionTap;
  final List<String> suggestions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bottom Horizontal Tiles
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: suggestions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final text = suggestions[index];
                return InkWell(
                  onTap: isSending ? null : () => onSuggestionTap(text),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.06)),
                    ),
                    child: Center(
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Main Chat Text Field & Send Action Floating Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.black.withOpacity(0.06)),
                    ),
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 4,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 15,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: isSending
                      ? null
                      : () {
                          if (controller.text.trim().isNotEmpty) {
                            onSend(controller.text);
                          }
                        },
                  icon: const Icon(Icons.send_rounded, size: 22),
                  color: AppColors.white,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.chatbotAccent,
                    minimumSize: const Size(48, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
