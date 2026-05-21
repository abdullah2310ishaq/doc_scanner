import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

Future<void> showTranslateFullTextSheet(
  BuildContext context, {
  required String title,
  required String body,
  String? copyLabel,
  VoidCallback? onCopy,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      final bottomInset = MediaQuery.paddingOf(sheetContext).bottom;

      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        minChildSize: 0.35,
        maxChildSize: 0.92,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 16 + bottomInset),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.tagBorder,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.translateSectionTitle,
                        ),
                      ),
                    ),
                    if (onCopy != null && copyLabel != null)
                      TextButton.icon(
                        onPressed: onCopy,
                        icon: const Icon(Icons.copy_rounded, size: 18),
                        label: Text(copyLabel),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textLink,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: SelectableText(
                      body,
                      textDirection: _isRtl(body) ? TextDirection.rtl : TextDirection.ltr,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.55,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
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
