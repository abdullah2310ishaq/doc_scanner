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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final sideMargin = (screenWidth * 0.08).clamp(24.0, 48.0);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(sideMargin, 0, sideMargin, 16),
        child: Container(
          height: 52, // ADJUSTMENT: Shrunk slightly from 56 to 52
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.navbarGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _NavItem(
                iconAsset: HomeAssets.navbariconn,
                label: homeLabel,
                isSelected: current == AppNavItem.home,
                onTap: () => onChanged(AppNavItem.home),
              ),
              const SizedBox(
                width: 64,
              ), // ADJUSTMENT: Shrunk width gap from 80 to 64
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

  static const double _iconSize =
      22; // ADJUSTMENT: Scaled icon down down from 24 to 22

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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 3, // ADJUSTMENT: Trimmed slightly from 4 to 3
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize:
                      10.5, // ADJUSTMENT: Scaled text down marginally from 11 to 10.5
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
