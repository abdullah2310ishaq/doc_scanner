import 'package:flutter/material.dart';

import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/app_navbar.dart';
import '../../settings/screens/settings_screen.dart';
import 'home_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  AppNavItem _current = AppNavItem.home;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      extendBodyBehindAppBar: false,
      body: IndexedStack(
        index: _current.index,
        children: const [
          HomeScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: AppNavbar(
        current: _current,
        onChanged: (item) => setState(() => _current = item),
        homeLabel: l10n.navHome,
        settingsLabel: l10n.navSettings,
      ),
    );
  }
}
