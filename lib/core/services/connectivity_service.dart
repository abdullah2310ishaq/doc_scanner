import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  ConnectivityService({
    Connectivity? connectivity,
    InternetConnectionChecker? internetChecker,
  })  : _connectivity = connectivity ?? Connectivity(),
        _internetChecker =
            internetChecker ?? InternetConnectionChecker.instance;

  final Connectivity _connectivity;
  final InternetConnectionChecker _internetChecker;

  static const Duration _debounceDuration = Duration(milliseconds: 800);
  static const Duration _pollInterval = Duration(seconds: 30);

  bool _isOnline = true;
  bool _isStarted = false;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  Timer? _debounceTimer;
  Timer? _pollTimer;

  final StreamController<bool> _statusController =
      StreamController<bool>.broadcast();

  bool get isOnline => _isOnline;
  Stream<bool> get onStatusChanged => _statusController.stream;

  Future<void> start() async {
    if (_isStarted) return;
    _isStarted = true;

    _isOnline = await checkInternet();
    _statusController.add(_isOnline);

    _connectivitySub = _connectivity.onConnectivityChanged.listen((_) {
      _scheduleCheck();
    });

    _pollTimer = Timer.periodic(_pollInterval, (_) => _scheduleCheck());
  }

  Future<bool> checkInternet() async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (_hasNoConnection(results)) {
        return false;
      }
      return _internetChecker.hasConnection;
    } catch (error) {
      if (kDebugMode) {
        debugPrint('[ConnectivityService] check failed: $error');
      }
      return false;
    }
  }

  Future<bool> ensureOnline() async {
    _isOnline = await checkInternet();
    return _isOnline;
  }

  void _scheduleCheck() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, () async {
      final wasOnline = _isOnline;
      _isOnline = await checkInternet();

      if (wasOnline != _isOnline) {
        _statusController.add(_isOnline);
      }
    });
  }

  bool _hasNoConnection(List<ConnectivityResult> results) {
    if (results.isEmpty) return true;
    return results.every((result) => result == ConnectivityResult.none);
  }

  void dispose() {
    _connectivitySub?.cancel();
    _debounceTimer?.cancel();
    _pollTimer?.cancel();
    _statusController.close();
    _isStarted = false;
  }
}
