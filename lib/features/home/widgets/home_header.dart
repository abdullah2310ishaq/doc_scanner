import 'package:flutter/material.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.greeting,
    required this.titlePrefix,
    required this.proSemanticsLabel,
    this.onMenuTap,
    this.onProTap,
  });

  final String greeting;
  final String titlePrefix;
  final String proSemanticsLabel;
  final VoidCallback? onMenuTap;
  final VoidCallback? onProTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _DrawerButton(onTap: onMenuTap),
            _ProButton(label: proSemanticsLabel, onTap: onProTap),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          greeting,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        _HomeTitle(prefix: titlePrefix),
      ],
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Menu',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          HomeAssets.drawer,
          width: 44,
          height: 44,
          fit: BoxFit.contain,
        ),
      ),
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
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          HomeAssets.pro,
          height: 36,
          fit: BoxFit.contain,
        ),
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
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Image.asset(
          HomeAssets.scanner,
          height: 36,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
