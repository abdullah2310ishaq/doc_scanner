import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../in_app/billing_service.dart';
import '../services/subscription_prefs_service.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({
    BillingService? billingService,
    SubscriptionPrefsService? prefsService,
  }) : _billingService = billingService ?? BillingService(),
       _prefsService = prefsService ?? SubscriptionPrefsService();

  final BillingService _billingService;
  final SubscriptionPrefsService _prefsService;

  StreamSubscription<BillingPurchaseEvent>? _purchaseSubscription;
  bool _isPro = false;
  bool _isInitialized = false;
  bool _isPurchasing = false;

  bool get isPro => _isPro;
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
    await _billingService.initialize();
    _purchaseSubscription = _billingService.purchaseEvents.listen(
      _onPurchaseEvent,
    );
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
        _setPro(true);
        break;
      case BillingPurchaseStatus.canceled:
      case BillingPurchaseStatus.error:
        _isPurchasing = false;
        notifyListeners();
        break;
    }
  }

  Future<void> _setPro(bool value) async {
    _isPro = value;
    await _prefsService.setProUser(value);
    notifyListeners();
  }

  String? displayPriceForPlan(BillingPlan plan) {
    return _billingService.displayPriceForPlan(plan);
  }

  String? weeklyPaidMinPrice() => _billingService.weeklyPaidMinPrice();

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
