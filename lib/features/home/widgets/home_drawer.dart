import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

enum HomeDrawerDestination { home, scan, documents, translate, live, settings }

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.appTitle,
    required this.homeLabel,
    required this.scanLabel,
    required this.documentsLabel,
    required this.translateLabel,
    required this.liveLabel,
    required this.settingsLabel,
    required this.proTitle,
    this.onDestinationSelected,
  });

  final String appTitle;
  final String homeLabel;
  final String scanLabel;
  final String documentsLabel;
  final String translateLabel;
  final String liveLabel;
  final String settingsLabel;
  final String proTitle;
  final ValueChanged<HomeDrawerDestination>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                appTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.documentCardBorder),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerTile(
                    icon: Icons.home_rounded,
                    label: homeLabel,
                    onTap: () => _select(context, HomeDrawerDestination.home),
                  ),
                  _DrawerTile(
                    icon: Icons.document_scanner_outlined,
                    label: scanLabel,
                    onTap: () => _select(context, HomeDrawerDestination.scan),
                  ),
                  _DrawerTile(
                    icon: Icons.folder_outlined,
                    label: documentsLabel,
                    onTap: () =>
                        _select(context, HomeDrawerDestination.documents),
                  ),
                  _DrawerTile(
                    icon: Icons.translate_rounded,
                    label: translateLabel,
                    onTap: () =>
                        _select(context, HomeDrawerDestination.translate),
                  ),
                  _DrawerTile(
                    icon: Icons.videocam_outlined,
                    label: liveLabel,
                    onTap: () => _select(context, HomeDrawerDestination.live),
                  ),
                  const Divider(
                    height: 24,
                    indent: 20,
                    endIndent: 20,
                    color: AppColors.documentCardBorder,
                  ),
                  _DrawerTile(
                    icon: Icons.settings_outlined,
                    label: settingsLabel,
                    onTap: () =>
                        _select(context, HomeDrawerDestination.settings),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.proBadgeGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.workspace_premium_outlined,
                    color: AppColors.white,
                  ),
                  title: Text(
                    proTitle,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _select(BuildContext context, HomeDrawerDestination destination) {
    Navigator.pop(context);
    onDestinationSelected?.call(destination);
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
