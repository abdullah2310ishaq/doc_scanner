import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Centered empty message for Recent PDFs or Recent Images lists.
class RecentDocumentsEmptyState extends StatelessWidget {
  const RecentDocumentsEmptyState({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
