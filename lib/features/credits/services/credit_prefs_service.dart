import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/prefs_keys.dart';

class CreditPrefsService {
  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<int> getUsedCount() async {
    final prefs = await _prefs;
    return prefs.getInt(PrefsKeys.freeCreditsUsed) ?? 0;
  }

  Future<void> setUsedCount(int value) async {
    final prefs = await _prefs;
    await prefs.setInt(PrefsKeys.freeCreditsUsed, value);
  }
}
