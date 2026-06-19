import '../providers/connectivity_provider.dart';

class NetworkGuard {
  const NetworkGuard._();

  static bool canProceed(ConnectivityProvider connectivity) {
    return connectivity.isOnline;
  }

  /// Re-checks with the store/internet before proceeding.
  static Future<bool> ensureOnline(ConnectivityProvider connectivity) {
    return connectivity.refresh();
  }
}
