import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/prefs_keys.dart';
import '../models/subscription_plan.dart';

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

  Future<SubscriptionPlan> getActivePlan() async {
    final prefs = await _prefs;
    return SubscriptionPlan.fromStorage(prefs.getString(PrefsKeys.activeSubscriptionPlan));
  }

  Future<void> setActivePlan(SubscriptionPlan plan) async {
    final prefs = await _prefs;
    await prefs.setString(PrefsKeys.activeSubscriptionPlan, plan.toStorage());
  }

  Future<DateTime?> getPlanPeriodStart() async {
    final prefs = await _prefs;
    final millis = prefs.getInt(PrefsKeys.planPeriodStartMs);
    if (millis == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  Future<void> setPlanPeriodStart(DateTime value) async {
    final prefs = await _prefs;
    await prefs.setInt(PrefsKeys.planPeriodStartMs, value.millisecondsSinceEpoch);
  }

  Future<void> clearSubscription() async {
    final prefs = await _prefs;
    await prefs.setBool(PrefsKeys.isProUser, false);
    await prefs.setString(
      PrefsKeys.activeSubscriptionPlan,
      SubscriptionPlan.none.toStorage(),
    );
    await prefs.remove(PrefsKeys.planPeriodStartMs);
  }
}
