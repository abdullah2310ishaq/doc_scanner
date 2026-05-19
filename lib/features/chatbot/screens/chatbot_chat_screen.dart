import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/widgets/toast.dart';
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
          create: (_) => ChatbotChatProvider(sessionId: sessionId)..loadSession(),
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
    await provider.sendMessage(text);
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

  Future<void> _copyChat(BuildContext context, ChatbotChatProvider provider) async {
    final text = provider.buildShareText();
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    AppToast.show(context, context.l10n.ocrCopySuccess);
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.chatbotDeleteTitle),
        content: Text(l10n.chatbotDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
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
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            foregroundColor: AppColors.textPrimary,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
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
                  PopupMenuItem(
                    value: 'share',
                    child: Text(l10n.commonShare),
                  ),
                  PopupMenuItem(
                    value: 'copy',
                    child: Text(l10n.commonCopy),
                  ),
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
                        padding: const EdgeInsets.all(16),
                        children: [
                          _WelcomeCard(l10n: l10n),
                          ...provider.messages.map(
                            (message) => _MessageBubble(message: message),
                          ),
                          if (provider.isSending)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (provider.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          l10n.chatbotChatFailed,
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    _ChatInputBar(
                      controller: _inputController,
                      hint: l10n.chatbotChatInputHint,
                      isSending: provider.isSending,
                      onSend: (text) => _sendMessage(provider, text),
                      onSuggestionTap: (text) => _sendMessage(provider, text),
                      suggestions: [
                        l10n.chatbotChatPromptSummarize,
                        l10n.chatbotChatPromptHighlights,
                        l10n.chatbotChatPromptFinancial,
                        l10n.chatbotChatPromptDates,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardChatbotBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.chatbotChatGreeting,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.chatbotChatYouCanAsk,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
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

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatbotMessageRole.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.8,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppColors.chatbotAccent : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: isUser ? null : Border.all(color: AppColors.searchBorder),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            fontSize: 15,
            height: 1.4,
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
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: suggestions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final text = suggestions[index];
                return ActionChip(
                  label: Text(text, style: const TextStyle(fontSize: 12)),
                  onPressed: isSending ? null : () => onSuggestionTap(text),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: hint,
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.searchBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.searchBorder),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: isSending
                      ? null
                      : () => onSend(controller.text),
                  icon: const Icon(Icons.send_rounded),
                  color: AppColors.white,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.chatbotAccent,
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
