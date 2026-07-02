import '../../../core/constants/credit_limits.dart';
import 'credit_prefs_service.dart';

/// Tracks shared free generations stored on device.
class CreditManager {
  CreditManager({CreditPrefsService? prefsService})
    : _prefsService = prefsService ?? CreditPrefsService();

  final CreditPrefsService _prefsService;

  int _usedCount = 0;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  int get usedCount => _usedCount;

  int get remainingCredits {
    final left = CreditLimits.maxFreeGenerations - _usedCount;
    if (left < 0) return 0;
    if (left > CreditLimits.maxFreeGenerations) {
      return CreditLimits.maxFreeGenerations;
    }
    return left;
  }

  bool get hasFreeCreditsRemaining => remainingCredits > 0;

  bool canUseCredit({required bool isPro}) {
    if (isPro) return true;
    return hasFreeCreditsRemaining;
  }

  Future<void> initialize() async {
    if (_isInitialized) return;
    _usedCount = await _prefsService.getUsedCount();
    _isInitialized = true;
  }

  Future<bool> consumeCredit({required bool isPro}) async {
    if (isPro) return true;
    if (!hasFreeCreditsRemaining) return false;

    _usedCount++;
    await _prefsService.setUsedCount(_usedCount);
    return true;
  }
}
