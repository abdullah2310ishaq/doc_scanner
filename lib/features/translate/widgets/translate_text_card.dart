import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'translate_full_text_sheet.dart';

class TranslateTextCard extends StatefulWidget {
  const TranslateTextCard({
    super.key,
    required this.title,
    required this.text,
    required this.placeholder,
    required this.seeMoreLabel,
    required this.copySemanticsLabel,
    this.readAloudSemanticsLabel,
    this.onCopy,
    this.onReadAloud,
    this.isLoading = false,
  });

  final String title;
  final String text;
  final String placeholder;
  final String seeMoreLabel;
  final String copySemanticsLabel;
  final String? readAloudSemanticsLabel;
  final VoidCallback? onCopy;
  final VoidCallback? onReadAloud;
  final bool isLoading;

  static const int _maxLines = 2;
  static const TextStyle _bodyStyle = TextStyle(
    fontSize: 14,
    height: 1.45,
    color: AppColors.textSecondary,
  );

  @override
  State<TranslateTextCard> createState() => _TranslateTextCardState();
}

class _TranslateTextCardState extends State<TranslateTextCard> {
  bool _showSeeMore = false;

  @override
  Widget build(BuildContext context) {
    final displayText = widget.text.isEmpty ? widget.placeholder : widget.text;
    final isPlaceholder = widget.text.isEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
        border: Border.all(color: AppColors.translateCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.translateSectionTitle,
                ),
              ),
              const Spacer(),
              if (widget.onReadAloud != null && widget.text.isNotEmpty)
                _CardIconButton(
                  icon: Icons.volume_up_outlined,
                  semanticsLabel: widget.readAloudSemanticsLabel!,
                  onTap: widget.onReadAloud!,
                ),
              if (widget.onCopy != null && widget.text.isNotEmpty) ...[
                if (widget.onReadAloud != null) const SizedBox(width: 4),
                _CardIconButton(
                  icon: Icons.copy_rounded,
                  semanticsLabel: widget.copySemanticsLabel,
                  onTap: widget.onCopy!,
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          if (widget.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                _updateSeeMore(displayText, constraints.maxWidth, isPlaceholder);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      displayText,
                      maxLines: isPlaceholder ? null : TranslateTextCard._maxLines,
                      overflow: isPlaceholder
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: isPlaceholder
                          ? TranslateTextCard._bodyStyle.copyWith(
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.7,
                              ),
                            )
                          : TranslateTextCard._bodyStyle,
                    ),
                    if (_showSeeMore && !isPlaceholder)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => showTranslateFullTextSheet(
                            context,
                            title: widget.title,
                            body: widget.text,
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(top: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            widget.seeMoreLabel,
                            style: const TextStyle(
                              color: AppColors.textLink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  void _updateSeeMore(String text, double maxWidth, bool isPlaceholder) {
    if (isPlaceholder || maxWidth <= 0) {
      if (_showSeeMore) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _showSeeMore = false);
        });
      }
      return;
    }

    final painter = TextPainter(
      text: TextSpan(text: text, style: TranslateTextCard._bodyStyle),
      maxLines: TranslateTextCard._maxLines,
      textDirection: Directionality.of(context),
    )..layout(maxWidth: maxWidth);

    final shouldShow = painter.didExceedMaxLines;
    if (shouldShow != _showSeeMore) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _showSeeMore = shouldShow);
      });
    }
  }
}

class _CardIconButton extends StatelessWidget {
  const _CardIconButton({
    required this.icon,
    required this.semanticsLabel,
    required this.onTap,
  });

  final IconData icon;
  final String semanticsLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: AppColors.translateSectionTitle, size: 22),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      ),
    );
  }
}
