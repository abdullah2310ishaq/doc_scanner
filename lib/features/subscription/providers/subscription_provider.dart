import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/constants/premium_limits.dart';
import '../../../in_app/billing_service.dart';
import '../models/feature_type.dart';
import '../models/subscription_plan.dart';
import '../services/premium_usage_service.dart';
import '../services/subscription_prefs_service.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({
    BillingService? billingService,
    SubscriptionPrefsService? prefsService,
    PremiumUsageService? usageService,
  }) : _billingService = billingService ?? BillingService(),
       _prefsService = prefsService ?? SubscriptionPrefsService(),
       _usageService = usageService ?? PremiumUsageService();

  final BillingService _billingService;
  final SubscriptionPrefsService _prefsService;
  final PremiumUsageService _usageService;

  StreamSubscription<BillingPurchaseEvent>? _purchaseSubscription;
  bool _isPro = false;
  SubscriptionPlan _activePlan = SubscriptionPlan.none;
  DateTime? _planPeriodStart;
  bool _isInitialized = false;
  bool _isPurchasing = false;

  bool get isPro => _isPro;
  SubscriptionPlan get activePlan => _activePlan;
  DateTime? get planPeriodStart => _planPeriodStart;
  bool get isInitialized => _isInitialized;
  bool get isPurchasing => _isPurchasing;
  bool get isStoreAvailable => _billingService.isStoreAvailable;
  bool get hasProducts => _billingService.hasProducts;

  BillingService get billingService => _billingService;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    _isPro = await _prefsService.isProUser();
    _activePlan = await _prefsService.getActivePlan();
    _planPeriodStart = await _prefsService.getPlanPeriodStart();

    if (_isPro && _activePlan == SubscriptionPlan.none) {
      _activePlan = SubscriptionPlan.weekly;
      await _prefsService.setActivePlan(_activePlan);
    }

    await _usageService.initialize();

    if (_isPro && _activePlan != SubscriptionPlan.none) {
      await _usageService.maybeResetPeriod(
        plan: _activePlan,
        now: DateTime.now(),
      );
      _planPeriodStart = _usageService.periodStart;
    }

    await _billingService.initialize();
    _purchaseSubscription = _billingService.purchaseEvents.listen(
      _onPurchaseEvent,
    );

    await _billingService.restorePurchases();

    _isInitialized = true;
    notifyListeners();
  }

  void _onPurchaseEvent(BillingPurchaseEvent event) {
    switch (event.status) {
      case BillingPurchaseStatus.pending:
        _isPurchasing = true;
        notifyListeners();
        break;
      case BillingPurchaseStatus.purchased:
        _isPurchasing = false;
        unawaited(_activateSubscription(event.productId));
        break;
      case BillingPurchaseStatus.canceled:
      case BillingPurchaseStatus.error:
        _isPurchasing = false;
        notifyListeners();
        break;
    }
  }

  SubscriptionPlan _planFromProductId(String productId) {
    if (productId == kProWeeklyProductId) {
      return SubscriptionPlan.weekly;
    }
    if (productId == kProYearlyProductId) {
      return SubscriptionPlan.yearly;
    }
    return SubscriptionPlan.none;
  }

  Future<void> _activateSubscription(String productId) async {
    final plan = _planFromProductId(productId);
    if (plan == SubscriptionPlan.none) {
      notifyListeners();
      return;
    }

    final planChanged = _activePlan != plan;
    _isPro = true;
    _activePlan = plan;

    if (planChanged || _planPeriodStart == null) {
      await _usageService.resetPeriodAndUsage();
      _planPeriodStart = _usageService.periodStart;
      if (_planPeriodStart != null) {
        await _prefsService.setPlanPeriodStart(_planPeriodStart!);
      }
    }

    await _prefsService.setProUser(true);
    await _prefsService.setActivePlan(plan);
    notifyListeners();
  }

  int limitFor(FeatureType feature) {
    return PremiumLimits.limitFor(plan: _activePlan, feature: feature);
  }

  int usedFor(FeatureType feature) {
    return _usageService.getUsed(feature);
  }

  int remainingFor(FeatureType feature) {
    final limit = limitFor(feature);
    final used = usedFor(feature);
    final left = limit - used;
    return left < 0 ? 0 : left;
  }

  Future<void> prepareUsageCheck() async {
    if (!_isPro || _activePlan == SubscriptionPlan.none) {
      return;
    }

    await _usageService.maybeResetPeriod(
      plan: _activePlan,
      now: DateTime.now(),
    );
    _planPeriodStart = _usageService.periodStart;
  }

  bool canUse(FeatureType feature) {
    if (!_isPro || _activePlan == SubscriptionPlan.none) {
      return false;
    }

    return _usageService.canUse(
      plan: _activePlan,
      feature: feature,
      now: DateTime.now(),
    );
  }

  Future<void> recordUsage(FeatureType feature) async {
    if (!_isPro || _activePlan == SubscriptionPlan.none) {
      return;
    }

    final now = DateTime.now();
    await _usageService.maybeResetPeriod(plan: _activePlan, now: now);
    await _usageService.increment(feature: feature, plan: _activePlan, now: now);
    _planPeriodStart = _usageService.periodStart;
    notifyListeners();
  }

  /// Debug/profile builds only — simulate Pro without a real purchase.
  Future<void> debugSetPro(bool value, {SubscriptionPlan plan = SubscriptionPlan.weekly}) async {
    assert(!kReleaseMode, 'debugSetPro is only available in non-release builds');
    if (value) {
      await _activateSubscription(
        plan == SubscriptionPlan.yearly
            ? kProYearlyProductId
            : kProWeeklyProductId,
      );
      return;
    }

    _isPro = false;
    _activePlan = SubscriptionPlan.none;
    _planPeriodStart = null;
    await _prefsService.clearSubscription();
    await _usageService.resetAllUsage();
    notifyListeners();
  }

  String? displayPriceForPlan(BillingPlan plan) {
    return _billingService.displayPriceForPlan(plan);
  }

  String? weeklyPaidMinPrice() => _billingService.weeklyPaidMinPrice();

  String? weeklyStandardDisplayPrice() =>
      _billingService.weeklyStandardDisplayPrice();

  String? weeklySinglePaymentDisplayPrice() =>
      _billingService.weeklySinglePaymentDisplayPrice();

  String? yearlyPerWeekDisplayPrice() =>
      _billingService.yearlyPerWeekDisplayPrice();

  void logPaywallPriceSummary() => _billingService.logPaywallPriceSummary();

  String? weeklyPaidMaxPrice() => _billingService.weeklyPaidMaxPrice();

  Future<bool> purchasePlan(BillingPlan plan) async {
    if (!_isInitialized) {
      await initialize();
    }
    _isPurchasing = true;
    notifyListeners();

    final started = await _billingService.purchasePlan(plan);
    if (!started) {
      _isPurchasing = false;
      notifyListeners();
    }
    return started;
  }

  Future<void> restorePurchases() async {
    if (!_isInitialized) {
      await initialize();
    }
    _isPurchasing = true;
    notifyListeners();
    await _billingService.restorePurchases();
    if (!_isPro) {
      _isPurchasing = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    _billingService.dispose();
    super.dispose();
  }
}
