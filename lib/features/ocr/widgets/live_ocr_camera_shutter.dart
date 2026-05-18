import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LiveOcrCameraShutter extends StatelessWidget {
  const LiveOcrCameraShutter({
    super.key,
    required this.semanticsLabel,
    required this.onTap,
    this.isEnabled = true,
  });

  final String semanticsLabel;
  final VoidCallback onTap;
  final bool isEnabled;

  static const double _outerSize = 78;
  static const double _innerSize = 62;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      enabled: isEnabled,
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: Container(
          width: _outerSize,
          height: _outerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.liveCameraShutterRing,
              width: 3,
            ),
          ),
          alignment: Alignment.center,
          child: Container(
            width: _innerSize,
            height: _innerSize,
            decoration: BoxDecoration(
              color: isEnabled
                  ? AppColors.liveCameraText
                  : AppColors.liveCameraText.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
