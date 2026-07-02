import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/credit_gate.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/delete_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../../../l10n/app_localizations.dart';
import '../../subscription/models/feature_type.dart';
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
    this.initialSummary, // Summary capture karne ke liye option variable
  });

  final String sessionId;
  final String displayName;
  final String? initialSummary;

  static Future<void> open(
    BuildContext context, {
    required String sessionId,
    required String displayName,
    String? summary,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) =>
              ChatbotChatProvider(sessionId: sessionId)..loadSession(),
          child: ChatbotChatScreen(
            sessionId: sessionId,
            displayName: displayName,
            initialSummary: summary,
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
    final messageText = text.trim();

    final canGenerate = await CreditGate.ensureCanGenerate(
      context,
      feature: FeatureType.askPdf,
    );
    if (!mounted || !canGenerate) return;

    _inputController.clear();

    // Trigger the asynchronous send operation.
    // ChatbotChatProvider will immediately add the user message and set isSending = true.
    final sendFuture = provider.sendMessage(messageText);

    // Scroll to the bottom immediately to show the user's message and the "AI is thinking" loader.
    _scrollToBottom();

    // Wait for the chatbot service to fetch the OpenAI reply and save it.
    await sendFuture;

    if (!mounted) return;
    if (provider.errorMessage == null) {
      await CreditGate.recordGeneration(context, feature: FeatureType.askPdf);
    }

    // Scroll to bottom again to show the complete AI reply.
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
          backgroundColor: const Color(0xFFF9FAFD),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF9FAFD),
            elevation: 0,
            foregroundColor: AppColors.textPrimary,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        children: [
                          if (provider.messages.isEmpty)
                            _DocumentReadyWelcomeView(
                              l10n: l10n,
                              summary:
                                  widget.initialSummary ??
                                  provider.session?.summary ??
                                  '',
                              onActionTap: (promptText) =>
                                  _sendMessage(provider, promptText),
                            )
                          else ...[
                            if ((widget.initialSummary ??
                                    provider.session?.summary ??
                                    '')
                                .trim()
                                .isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _DocumentSummaryBox(
                                  l10n: l10n,
                                  summary:
                                      widget.initialSummary ??
                                      provider.session?.summary ??
                                      '',
                                ),
                              ),
                            ...provider.messages.map(
                              (message) => _MessageBubble(message: message),
                            ),
                          ],
                          if (provider.isSending)
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 4,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: _ThinkingLoader(),
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
                      hint: l10n.chatbotChatInputHint,
                      isSending: provider.isSending,
                      onSend: (text) => _sendMessage(provider, text),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

// Merged Screen State: Dashboard elements inside Chat Empty Welcome Context
class _DocumentReadyWelcomeView extends StatelessWidget {
  const _DocumentReadyWelcomeView({
    required this.l10n,
    required this.summary,
    required this.onActionTap,
  });

  final AppLocalizations l10n;
  final String summary;
  final ValueChanged<String> onActionTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Success Message Banner Box
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF4FBF7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2F3EB)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF2ECC71),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.chatbotDocumentReadyTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF27AE60),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.chatbotDocumentReadySubtitle,
                      style: const TextStyle(
                        fontSize: 13,
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
        const SizedBox(height: 12),

        // 2. Ask Questions Large Main Promo Widget
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withOpacity(0.02)),
          ),
          child: Row(
            children: [
              Container(child: SvgPicture.asset('assets/q.svg')),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  l10n.chatbotAskQuestions,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 3. Four Quick Action Interactive Chips Grid
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _QuickActionWelcomeChip(
              iconAsset: 'assets/chatbot/up1.svg',
              label: l10n.chatbotSuggestSummarizeChip,
              onTap: () => onActionTap(l10n.chatbotChatPromptSummarize),
            ),
            _QuickActionWelcomeChip(
              iconAsset: 'assets/chatbot/up2.svg',
              label: l10n.chatbotSuggestKeyPointsChip,
              onTap: () => onActionTap(l10n.chatbotChatPromptHighlights),
            ),
            _QuickActionWelcomeChip(
              iconAsset: 'assets/chatbot/up3.svg',
              label: l10n.chatbotSuggestExplainChip,
              onTap: () => onActionTap(l10n.chatbotChatPromptHighlights),
            ),
            _QuickActionWelcomeChip(
              iconAsset: 'assets/chatbot/up1.svg',
              label: l10n.chatbotSuggestTranslateChip,
              onTap: () => onActionTap(l10n.chatbotSuggestTranslate),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 4. Compact Structural Document Summary Panel
        if (summary.trim().isNotEmpty)
          _DocumentSummaryBox(l10n: l10n, summary: summary),
      ],
    );
  }
}

class _DocumentSummaryBox extends StatelessWidget {
  const _DocumentSummaryBox({required this.l10n, required this.summary});

  final AppLocalizations l10n;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.8,
        ),
        height: 260,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.02)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.chatbotCurrentSummary,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                summary,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: AppColors.textPrimary.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}

class _QuickActionWelcomeChip extends StatelessWidget {
  const _QuickActionWelcomeChip({
    required this.iconAsset,
    required this.label,

    required this.onTap,
  });

  final String iconAsset;
  final String label;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        elevation: 0,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.black.withOpacity(0.02)),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(iconAsset),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    height: 1.2,
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

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatbotMessageModel message;

  String _cleanResponseText(String source) {
    return source.replaceAll(RegExp(r'\*+'), '').trim();
  }

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatbotMessageRole.user;
    final cleanedText = _cleanResponseText(message.content);

    if (isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.8,
          ),
          decoration: const BoxDecoration(
            color: AppColors.chatbotAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Text(
            cleanedText,
            style: const TextStyle(
              fontSize: 15,
              height: 1.4,
              color: AppColors.white,
            ),
          ),
        ),
      );
    } else {
      final lines = cleanedText
          .split('\n')
          .map((l) => l.trim())
          .where((l) => l.isNotEmpty)
          .toList();

      Widget contentWidget;
      if (lines.length > 1) {
        final heading = lines.first;
        final points = lines.sublist(1);

        contentWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              heading,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            ...points.map((point) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  point,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.45,
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }),
          ],
        );
      } else {
        contentWidget = Text(
          cleanedText,
          style: const TextStyle(
            fontSize: 15,
            height: 1.55,
            color: AppColors.textPrimary,
          ),
        );
      }

      return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 6, top: 4),
              width: 32,
              height: 32,
              child: Image.asset(
                'assets/chatbot/robot.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.8,
              ),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black.withOpacity(0.04)),
              ),
              child: contentWidget,
            ),
          ],
        ),
      );
    }
  }
}

class _ChatInputBar extends StatelessWidget {
  const _ChatInputBar({
    required this.controller,
    required this.hint,
    required this.isSending,
    required this.onSend,
  });

  final TextEditingController controller;
  final String hint;
  final bool isSending;
  final ValueChanged<String> onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Container(
          // Pura input bar aik hi container hai jaisa image mein hai
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16), // Rounded capsule edges
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(
            16,
            4,
            8,
            4,
          ), // Right padding kam ki taake button sahi adjust ho
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              // Button ko Row ke andar TextField ke sath hi rakha hai taake boundary ke andar show ho
              IconButton(
                onPressed: isSending
                    ? null
                    : () {
                        if (controller.text.trim().isNotEmpty) {
                          onSend(controller.text);
                        }
                      },
                icon: const Icon(Icons.send_rounded, size: 20),
                color: AppColors.white,
                style: IconButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF4F56FF,
                  ), // Blue/purple tint matches image perfectly
                  minimumSize: const Size(40, 40),
                  maximumSize: const Size(40, 40),
                  shape:
                      const CircleBorder(), // Circular floating action button effect inside bar
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThinkingLoader extends StatefulWidget {
  const _ThinkingLoader();

  @override
  State<_ThinkingLoader> createState() => _ThinkingLoaderState();
}

class _ThinkingLoaderState extends State<_ThinkingLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.chatbotAiThinking,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF555555),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final delay = index * 0.2;
                double scale = 1.0;
                double opacity = 0.3;

                if (_controller.value > delay &&
                    _controller.value < delay + 0.4) {
                  scale = 1.4;
                  opacity = 1.0;
                }

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 6 * scale,
                  height: 6 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(opacity),
                    shape: BoxShape.circle,
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
