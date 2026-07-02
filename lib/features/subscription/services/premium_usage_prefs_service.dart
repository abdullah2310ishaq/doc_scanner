import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/prefs_keys.dart';
import '../models/feature_type.dart';

class PremiumUsagePrefsService {
  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<DateTime?> getPeriodStart() async {
    final prefs = await _prefs;
    final millis = prefs.getInt(PrefsKeys.planPeriodStartMs);
    if (millis == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  Future<void> setPeriodStart(DateTime value) async {
    final prefs = await _prefs;
    await prefs.setInt(PrefsKeys.planPeriodStartMs, value.millisecondsSinceEpoch);
  }

  Future<int> getUsed(FeatureType feature) async {
    final prefs = await _prefs;
    return prefs.getInt(_keyFor(feature)) ?? 0;
  }

  Future<void> setUsed(FeatureType feature, int value) async {
    final prefs = await _prefs;
    await prefs.setInt(_keyFor(feature), value);
  }

  Future<void> resetAllUsage() async {
    final prefs = await _prefs;
    await prefs.setInt(PrefsKeys.premiumUsageOcrScan, 0);
    await prefs.setInt(PrefsKeys.premiumUsageSmartCrop, 0);
    await prefs.setInt(PrefsKeys.premiumUsagePdfAssistant, 0);
    await prefs.setInt(PrefsKeys.premiumUsageAskPdf, 0);
  }

  String _keyFor(FeatureType feature) {
    return switch (feature) {
      FeatureType.ocrScan => PrefsKeys.premiumUsageOcrScan,
      FeatureType.smartCrop => PrefsKeys.premiumUsageSmartCrop,
      FeatureType.pdfAssistant => PrefsKeys.premiumUsagePdfAssistant,
      FeatureType.askPdf => PrefsKeys.premiumUsageAskPdf,
    };
  }
}
