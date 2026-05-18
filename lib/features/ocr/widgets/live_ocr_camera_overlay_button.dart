import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LiveOcrCameraOverlayButton extends StatelessWidget {
  const LiveOcrCameraOverlayButton({
    super.key,
    required this.icon,
    required this.semanticsLabel,
    required this.onTap,
  });

  final IconData icon;
  final String semanticsLabel;
  final VoidCallback onTap;

  static const double _size = 40;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: Material(
        color: AppColors.liveCameraOverlay,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: _size,
            height: _size,
            child: Icon(icon, color: AppColors.liveCameraText, size: 22),
          ),
        ),
      ),
    );
  }
}
