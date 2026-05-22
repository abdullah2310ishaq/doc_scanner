import 'package:flutter/material.dart';

import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/app_exit_guard.dart';
import '../../../core/widgets/app_navbar.dart';
import '../../settings/screens/settings_screen.dart';
import '../widgets/home_drawer.dart';
import 'home_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  AppNavItem _current = AppNavItem.home;

  void _onNavChanged(AppNavItem item) {
    setState(() => _current = item);
  }

  void _onDrawerDestination(HomeDrawerDestination destination) {
    if (destination == HomeDrawerDestination.settings) {
      _onNavChanged(AppNavItem.settings);
    } else if (destination == HomeDrawerDestination.home) {
      _onNavChanged(AppNavItem.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppExitGuard(
      child: Scaffold(
        body: IndexedStack(
          index: _current.index,
          children: [
            HomeScreen(onDrawerDestination: _onDrawerDestination),
            const SettingsScreen(),
          ],
        ),
        bottomNavigationBar: AppNavbar(
          current: _current,
          onChanged: _onNavChanged,
          homeLabel: l10n.navHome,
          settingsLabel: l10n.navSettings,
        ),
      ),
    );
  }
}
