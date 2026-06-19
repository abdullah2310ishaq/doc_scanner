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

  static const Duration _pollInterval = Duration(seconds: 5);

  bool _isOnline = true;
  bool _isStarted = false;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  StreamSubscription<InternetConnectionStatus>? _internetSub;
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

    _internetSub = _internetChecker.onStatusChange.listen((status) {
      _setOnline(status == InternetConnectionStatus.connected);
    });

    _connectivitySub = _connectivity.onConnectivityChanged.listen((results) {
      if (_hasNoConnection(results)) {
        _setOnline(false);
        return;
      }
      unawaited(_recheckInternet());
    });

    _pollTimer = Timer.periodic(_pollInterval, (_) {
      unawaited(_recheckInternet());
    });
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
    final online = await checkInternet();
    _setOnline(online);
    return _isOnline;
  }

  Future<void> _recheckInternet() async {
    final online = await checkInternet();
    _setOnline(online);
  }

  void _setOnline(bool online) {
    if (_isOnline == online) return;
    _isOnline = online;
    if (kDebugMode) {
      debugPrint('[ConnectivityService] status => ${online ? "online" : "offline"}');
    }
    if (!_statusController.isClosed) {
      _statusController.add(_isOnline);
    }
  }

  bool _hasNoConnection(List<ConnectivityResult> results) {
    if (results.isEmpty) return true;
    return results.every((result) => result == ConnectivityResult.none);
  }

  void dispose() {
    _connectivitySub?.cancel();
    _internetSub?.cancel();
    _pollTimer?.cancel();
    _statusController.close();
    _isStarted = false;
  }
}
