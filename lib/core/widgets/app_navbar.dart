import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_colors.dart';
import '../constants/home_assets.dart';

enum AppNavItem { home, settings }

class AppNavbar extends StatelessWidget {
  const AppNavbar({
    super.key,
    required this.current,
    required this.onChanged,
    required this.homeLabel,
    required this.settingsLabel,
  });

  final AppNavItem current;
  final ValueChanged<AppNavItem> onChanged;
  final String homeLabel;
  final String settingsLabel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            gradient: AppColors.navbarGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              _NavItem(
                iconAsset: HomeAssets.navbariconn,
                label: homeLabel,
                isSelected: current == AppNavItem.home,
                onTap: () => onChanged(AppNavItem.home),
              ),
              _NavItem(
                iconData: Icons.settings_rounded,
                label: settingsLabel,
                isSelected: current == AppNavItem.settings,
                onTap: () => onChanged(AppNavItem.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    this.iconAsset,
    this.iconData,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : assert(iconAsset != null || iconData != null);

  final String? iconAsset;
  final IconData? iconData;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  static const double _iconSize = 24;

  Color get _iconColor =>
      isSelected ? AppColors.white : AppColors.white.withValues(alpha: 0.7);

  Widget _buildIcon() {
    if (iconAsset != null) {
      return SvgPicture.asset(
        iconAsset!,
        width: _iconSize,
        height: _iconSize,
        colorFilter: ColorFilter.mode(_iconColor, BlendMode.srcIn),
      );
    }
    return Icon(iconData, size: _iconSize, color: _iconColor);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: _iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
