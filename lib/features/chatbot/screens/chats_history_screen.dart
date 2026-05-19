import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/delete_dialog.dart';
import '../../../core/widgets/rename_dialog.dart';
import '../../../core/widgets/toast.dart';
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
  final TextEditingController _searchController = TextEditingController();

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

    final newName = await RenameDialog.show(
      context: context,
      title: l10n.chatbotRenameTitle,
      currentName: currentName,
    );

    if (newName == null || !context.mounted) return;
    await provider.renameSession(sessionId: sessionId, newName: newName);

    if (!context.mounted) return;
    AppToast.show(context, 'Renamed successfully');
  }

  Future<void> _deleteSession(
    BuildContext context,
    ChatbotHistoryProvider provider,
    String sessionId,
  ) async {
    final l10n = context.l10n;

    final confirmed = await DeleteDialog.show(
      context: context,
      title: l10n.chatbotDeleteTitle,
      message: l10n.chatbotDeleteMessage,
    );

    if (confirmed != true || !context.mounted) return;
    await provider.deleteSession(sessionId);

    if (!context.mounted) return;
    AppToast.show(context, 'Deleted successfully');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        centerTitle: false,
      ),
      body: Consumer<ChatbotHistoryProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.sessions.isEmpty) {
            return _EmptyState(onUpload: _returnToUploadAndOpenSheet);
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.searchBorder.withValues(alpha: 0.6),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: AppColors.textSecondary.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search your conversations..',
                            hintStyle: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Conversations List View
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  itemCount: provider.sessions.length,
                  separatorBuilder: (_, _) => const SizedBox(
                    height: 12,
                  ), // Fix: Single underscore use kiya taaki warning na aaye
                  itemBuilder: (context, index) {
                    final session = provider.sessions[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.searchBorder.withValues(alpha: 0.5),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        onTap: () {
                          ChatbotChatScreen.open(
                            context,
                            sessionId: session.id,
                            displayName: session.displayName,
                          );
                        },
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFECEF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset('assets/home/pdf.svg'),
                        ),
                        title: Text(
                          session.displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            session.previewText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        trailing: SizedBox(
                          height:
                              56, // Column ko bound karne ke liye explicit height
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize:
                                MainAxisSize.min, // Extra space occupy na kare
                            children: [
                              Expanded(
                                child: PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: AppColors.textSecondary,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onSelected: (value) {
                                    if (value == 'rename') {
                                      _renameSession(
                                        context,
                                        provider,
                                        session.id,
                                        session.displayName,
                                      );
                                    } else if (value == 'delete') {
                                      _deleteSession(
                                        context,
                                        provider,
                                        session.id,
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    const PopupMenuItem(
                                      value: 'rename',
                                      child: Row(children: [Text('Rename')]),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ), // Chota sa gap drop-down aur text ke beech
                              const Text(
                                '9:20 AM',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
