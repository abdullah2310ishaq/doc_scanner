import 'dart:async';

import 'package:flutter/foundation.dart';

import '../services/connectivity_service.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityProvider({ConnectivityService? service})
      : _service = service ?? ConnectivityService();

  final ConnectivityService _service;
  StreamSubscription<bool>? _statusSubscription;

  bool _isOnline = true;
  bool _isInitialized = false;

  bool get isOnline => _isOnline;
  bool get isInitialized => _isInitialized;
  ConnectivityService get service => _service;
  Stream<bool> get onStatusChanged => _service.onStatusChanged;

  Future<void> initialize() async {
    if (_isInitialized) return;

    await _service.start();
    _isOnline = _service.isOnline;
    _isInitialized = true;

    _statusSubscription = _service.onStatusChanged.listen(_handleStatusChanged);
    notifyListeners();
  }

  Future<bool> refresh() async {
    final online = await _service.ensureOnline();
    _handleStatusChanged(online);
    return online;
  }

  void _handleStatusChanged(bool online) {
    if (_isOnline == online) return;
    _isOnline = online;
    notifyListeners();
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    _service.dispose();
    super.dispose();
  }
}
