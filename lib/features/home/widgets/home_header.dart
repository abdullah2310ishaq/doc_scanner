import 'package:flutter/material.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,

    required this.titlePrefix,
    required this.proSemanticsLabel,
    this.onProTap,
    this.tags,
  });

  final String titlePrefix;
  final String proSemanticsLabel;
  final VoidCallback? onProTap;
  final Widget? tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [_ProButton(label: proSemanticsLabel, onTap: onProTap)],
        ),
        const SizedBox(height: 18),

        _HomeTitle(prefix: titlePrefix),
        if (tags != null) ...[const SizedBox(height: 12), tags!],
      ],
    );
  }
}

class _ProButton extends StatelessWidget {
  const _ProButton({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label:
          label, // Fixed: Added missing label mapping to the Semantics widget
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(HomeAssets.pro, height: 26, fit: BoxFit.contain),
      ),
    );
  }
}

class _HomeTitle extends StatelessWidget {
  const _HomeTitle({required this.prefix});

  final String prefix;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            prefix,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Image.asset(HomeAssets.scanner, height: 26, fit: BoxFit.contain),
      ],
    );
  }
}
