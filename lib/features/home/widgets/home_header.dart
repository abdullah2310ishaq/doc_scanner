import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../in_app/paywall_routes.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.title, this.tags});

  final String title;
  final Widget? tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HomeTitleRow(prefix: title),
        if (tags != null) ...[const SizedBox(height: 20), tags!],
      ],
    );
  }
}

class _HomeTitleRow extends StatelessWidget {
  const _HomeTitleRow({required this.prefix});

  final String prefix;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  prefix,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Image.asset(HomeAssets.scanner, height: 20, fit: BoxFit.contain),
            ],
          ),
        ),
        _ProLottieButton(),
      ],
    );
  }
}

class _ProLottieButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PaywallRoutes.openManualPaywall(context),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 65,
        height: 48,
        child: Lottie.asset(
          'assets/pro_animation.json',
          fit: BoxFit.contain,
          repeat: true,
        ),
      ),
    );
  }
}
