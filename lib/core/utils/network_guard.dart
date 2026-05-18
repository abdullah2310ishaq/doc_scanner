import '../providers/connectivity_provider.dart';

class NetworkGuard {
  const NetworkGuard._();

  static bool canProceed(ConnectivityProvider connectivity) {
    return connectivity.isOnline;
  }

  static Future<bool> ensureOnline(ConnectivityProvider connectivity) async {
    return connectivity.refresh();
  }
}
