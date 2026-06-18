import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/prefs_keys.dart';

class SubscriptionPrefsService {
  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<bool> isProUser() async {
    final prefs = await _prefs;
    return prefs.getBool(PrefsKeys.isProUser) ?? false;
  }

  Future<void> setProUser(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(PrefsKeys.isProUser, value);
  }
}
