import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LiveOcrCameraTipBanner extends StatelessWidget {
  const LiveOcrCameraTipBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.liveCameraTipBorder),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: AppColors.liveCameraTextMuted,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.liveCameraTextMuted,
                fontSize: 13,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
