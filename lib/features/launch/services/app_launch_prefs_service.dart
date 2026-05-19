import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/prefs_keys.dart';


class AppLaunchPrefsService {
  Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  Future<bool> isFirstLaunch() async {
    final prefs = await _prefs;
    return prefs.getBool(PrefsKeys.isFirstLaunch) ?? true;
  }

  Future<void> markFirstLaunchSeen() async {
    final prefs = await _prefs;
    await prefs.setBool(PrefsKeys.isFirstLaunch, false);
  }

  Future<bool> hasCompletedOnboarding() async {
    final prefs = await _prefs;
    return prefs.getBool(PrefsKeys.hasCompletedOnboarding) ?? false;
  }

  Future<void> setOnboardingCompleted() async {
    final prefs = await _prefs;
    await prefs.setBool(PrefsKeys.hasCompletedOnboarding, true);
  }
}
