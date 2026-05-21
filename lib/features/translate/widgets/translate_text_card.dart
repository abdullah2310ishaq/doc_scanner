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
    this.subtitle,
  });

  final String title;
  final String? subtitle;
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
    height:
        1.4, // Increased to 1.4 to ensure stable, reliable text layout rendering metrics
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
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
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
                widget.subtitle == null
                    ? widget.title
                    : "${widget.title} (${widget.subtitle})",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.translateSectionTitle,
                ),
              ),
              const Spacer(),
              if (widget.onReadAloud != null && widget.text.isNotEmpty)
                // _CardIconButton(
                //   icon: Icons.volume_up_outlined,
                //   semanticsLabel: widget.readAloudSemanticsLabel!,
                //   onTap: widget.onReadAloud!,
                // ),
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
          const SizedBox(height: 2),
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
                // Perform layout measurement calculations
                _updateSeeMore(
                  displayText,
                  constraints.maxWidth,
                  isPlaceholder,
                );

                final isRtl = _isRtl(displayText);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: constraints
                          .maxWidth, // Explicit boundary lock to maximize block coverage
                      child: Text(
                        displayText,
                        maxLines: isPlaceholder
                            ? null
                            : TranslateTextCard._maxLines,
                        overflow: isPlaceholder
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                        style: isPlaceholder
                            ? TranslateTextCard._bodyStyle.copyWith(
                                color: AppColors.textSecondary.withValues(
                                  alpha: 0.7,
                                ),
                              )
                            : TranslateTextCard._bodyStyle,
                      ),
                    ),
                    if (_showSeeMore && !isPlaceholder) ...[
                      const SizedBox(
                        height: 6,
                      ), // Give separation below line baseline
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => showTranslateFullTextSheet(
                            context,
                            title: widget.subtitle == null
                                ? widget.title
                                : '${widget.title} (${widget.subtitle})',
                            body: widget.text,
                            copyLabel: widget.onCopy != null
                                ? widget.copySemanticsLabel
                                : null,
                            onCopy: widget.onCopy,
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
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

  bool _isRtl(String text) {
    return text.runes.any(
      (code) =>
          (code >= 0x0590 && code <= 0x05FF) || // Hebrew
          (code >= 0x0600 && code <= 0x06FF) || // Arabic, Urdu, Persian
          (code >= 0x0750 && code <= 0x077F) || // Arabic Supplement
          (code >= 0x08A0 && code <= 0x08FF) || // Arabic Extended-A
          (code >= 0xFB50 && code <= 0xFDFF) || // Arabic Presentation Forms-A
          (code >= 0xFE70 && code <= 0xFEFF),   // Arabic Presentation Forms-B
    );
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
