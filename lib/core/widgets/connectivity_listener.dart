import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/connectivity_provider.dart';
import '../utils/l10n_extension.dart';
import 'toast.dart';

class ConnectivityListener extends StatefulWidget {
  const ConnectivityListener({super.key, required this.child});

  final Widget child;

  @override
  State<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener>
    with WidgetsBindingObserver {
  ConnectivityProvider? _provider;
  bool? _wasOnline;
  bool _offlineToastShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _provider = context.read<ConnectivityProvider>();
      _wasOnline = _provider!.isOnline;
      _provider!.addListener(_onConnectivityChanged);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _provider?.removeListener(_onConnectivityChanged);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _offlineToastShown = false;
      unawaited(_provider?.refresh());
    }
  }

  void _onConnectivityChanged() {
    if (!mounted) return;

    final lifecycle = WidgetsBinding.instance.lifecycleState;
    if (lifecycle != null && lifecycle != AppLifecycleState.resumed) {
      return;
    }

    final provider = context.read<ConnectivityProvider>();
    if (!provider.isInitialized) return;

    final isOnline = provider.isOnline;
    final wasOnline = _wasOnline;

    if (wasOnline == true && isOnline == false && !_offlineToastShown) {
      _offlineToastShown = true;
      AppToast.showGlobal(
        context.l10n.errorNoInternetFeatures,
        backgroundColor: AppToast.errorBackground,
      );
    }

    if (isOnline) {
      _offlineToastShown = false;
    }

    _wasOnline = isOnline;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
