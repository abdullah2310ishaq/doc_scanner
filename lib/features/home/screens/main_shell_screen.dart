import 'package:flutter/material.dart';

import '../../../core/navigation/app_navigator.dart';
import '../../../core/utils/home_offline_toast.dart';
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

class _MainShellScreenState extends State<MainShellScreen>
    with RouteAware, WidgetsBindingObserver {
  AppNavItem _current = AppNavItem.home;
  bool _routeSubscribed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOffline();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_routeSubscribed) {
      return;
    }

    final route = ModalRoute.of(context);
    if (route is PageRoute<void>) {
      appRouteObserver.subscribe(this, route);
      _routeSubscribed = true;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_routeSubscribed) {
      appRouteObserver.unsubscribe(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkOffline();
    }
  }

  @override
  void didPush() {
    _checkOffline();
  }

  @override
  void didPopNext() {
    _checkOffline();
  }

  void _checkOffline() {
    if (!mounted) {
      return;
    }
    HomeOfflineToast.showIfOffline(context);
  }

  void _onNavChanged(AppNavItem item) {
    setState(() => _current = item);
    if (item == AppNavItem.home) {
      _checkOffline();
    }
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
