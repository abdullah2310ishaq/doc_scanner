import '../../../core/constants/premium_limits.dart';
import '../models/feature_type.dart';
import '../models/subscription_plan.dart';
import 'premium_usage_prefs_service.dart';

class PremiumUsageService {
  PremiumUsageService({PremiumUsagePrefsService? prefsService})
    : _prefsService = prefsService ?? PremiumUsagePrefsService();

  final PremiumUsagePrefsService _prefsService;

  DateTime? _periodStart;
  final Map<FeatureType, int> _usedByFeature = {
    FeatureType.ocrScan: 0,
    FeatureType.smartCrop: 0,
    FeatureType.pdfAssistant: 0,
    FeatureType.askPdf: 0,
  };

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  DateTime? get periodStart => _periodStart;

  Future<void> initialize() async {
    if (_isInitialized) return;

    _periodStart = await _prefsService.getPeriodStart();
    for (final feature in FeatureType.values) {
      _usedByFeature[feature] = await _prefsService.getUsed(feature);
    }
    _isInitialized = true;
  }

  int getUsed(FeatureType feature) {
    return _usedByFeature[feature] ?? 0;
  }

  Future<void> setPeriodStart(DateTime value) async {
    _periodStart = value;
    await _prefsService.setPeriodStart(value);
  }

  Future<void> resetPeriodAndUsage() async {
    _periodStart = DateTime.now();
    await _prefsService.setPeriodStart(_periodStart!);
    await resetAllUsage();
  }

  Future<void> resetAllUsage() async {
    for (final feature in FeatureType.values) {
      _usedByFeature[feature] = 0;
    }
    await _prefsService.resetAllUsage();
  }

  Future<void> maybeResetPeriod({
    required SubscriptionPlan plan,
    required DateTime now,
  }) async {
    if (plan == SubscriptionPlan.none) return;

    final start = _periodStart;
    if (start == null) {
      await resetPeriodAndUsage();
      return;
    }

    final periodDays = plan == SubscriptionPlan.weekly
        ? PremiumLimits.weeklyPeriodDays
        : PremiumLimits.yearlyPeriodDays;
    final periodEnd = start.add(Duration(days: periodDays));
    if (!now.isBefore(periodEnd)) {
      await resetPeriodAndUsage();
    }
  }

  bool canUse({
    required SubscriptionPlan plan,
    required FeatureType feature,
    required DateTime now,
  }) {
    if (plan == SubscriptionPlan.none) return false;

    final limit = PremiumLimits.limitFor(plan: plan, feature: feature);
    return getUsed(feature) < limit;
  }

  Future<void> increment({
    required FeatureType feature,
    required SubscriptionPlan plan,
    required DateTime now,
  }) async {
    await maybeResetPeriod(plan: plan, now: now);
    final current = getUsed(feature);
    _usedByFeature[feature] = current + 1;
    await _prefsService.setUsed(feature, current + 1);
  }
}
