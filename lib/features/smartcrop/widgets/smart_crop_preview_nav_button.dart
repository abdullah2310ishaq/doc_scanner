import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Circular prev/next control — white fill, blue border (design mock).
class SmartCropPreviewNavButton extends StatelessWidget {
  const SmartCropPreviewNavButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  static const double size = 44;
  static const double iconSize = 28;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 3,
      shadowColor: Colors.black26,
      shape: CircleBorder(
        side: BorderSide(
          color: AppColors.smartCropPrimary,
          width: 2,
        ),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            color: AppColors.textPrimary,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
