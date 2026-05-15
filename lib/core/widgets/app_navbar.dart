import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          gradient: AppColors.navbarGradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              label: homeLabel,
              isSelected: current == AppNavItem.home,
              onTap: () => onChanged(AppNavItem.home),
            ),
            _NavItem(
              icon: Icons.settings_rounded,
              label: settingsLabel,
              isSelected: current == AppNavItem.settings,
              onTap: () => onChanged(AppNavItem.settings),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

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
              Icon(
                icon,
                size: 24,
                color: isSelected
                    ? AppColors.white
                    : AppColors.white.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? AppColors.white
                      : AppColors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
