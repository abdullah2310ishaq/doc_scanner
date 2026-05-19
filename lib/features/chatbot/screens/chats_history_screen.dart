import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../providers/chatbot_history_provider.dart';
import 'chatbot_chat_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  /// Pushes history. Pops with `true` when user wants to upload from empty state.
  static Future<bool?> open(BuildContext context) {
    return Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => ChatbotHistoryProvider()..loadSessions(),
          child: const HistoryScreen(),
        ),
      ),
    );
  }

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  void _returnToUploadAndOpenSheet() {
    Navigator.of(context).pop(true);
  }

  Future<void> _renameSession(
    BuildContext context,
    ChatbotHistoryProvider provider,
    String sessionId,
    String currentName,
  ) async {
    final l10n = context.l10n;
    final controller = TextEditingController(text: currentName);

    final newName = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.chatbotRenameTitle),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: l10n.chatbotRenameHint),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, controller.text),
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );

    if (newName == null || !context.mounted) return;
    await provider.renameSession(sessionId: sessionId, newName: newName);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.chatbotHistoryTitle,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Consumer<ChatbotHistoryProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.sessions.isEmpty) {
            return _EmptyState(
              onUpload: _returnToUploadAndOpenSheet,
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: provider.sessions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final session = provider.sessions[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.searchBorder),
                ),
                tileColor: AppColors.white,
                title: Text(
                  session.displayName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  session.previewText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => _renameSession(
                    context,
                    provider,
                    session.id,
                    session.displayName,
                  ),
                ),
                onTap: () {
                  ChatbotChatScreen.open(
                    context,
                    sessionId: session.id,
                    displayName: session.displayName,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onUpload});

  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Image.asset(
              'assets/chatbot/noconversation.png',
              height: 220,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),
            Text(
              l10n.chatbotNoConversationsTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.chatbotNoConversationsSubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const Spacer(flex: 2),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: onUpload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.chatbotAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.chatbotUploadPdfButton,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
