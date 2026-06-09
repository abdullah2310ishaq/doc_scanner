import 'package:flutter/material.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.title, this.tags});

  final String title;
  final Widget? tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HomeTitle(prefix: title),
        if (tags != null) ...[const SizedBox(height: 20), tags!],
      ],
    );
  }
}

class _HomeTitle extends StatelessWidget {
  const _HomeTitle({required this.prefix});

  final String prefix;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
}
