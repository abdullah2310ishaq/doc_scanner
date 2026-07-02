import 'package:flutter/foundation.dart';

import '../../../core/constants/credit_limits.dart';
import '../../subscription/providers/subscription_provider.dart';
import '../services/credit_manager.dart';

class CreditProvider extends ChangeNotifier {
  CreditProvider({
    CreditManager? creditManager,
    required SubscriptionProvider subscriptionProvider,
  }) : _creditManager = creditManager ?? CreditManager(),
       _subscriptionProvider = subscriptionProvider {
    _subscriptionProvider.addListener(_onSubscriptionChanged);
  }

  final CreditManager _creditManager;
  final SubscriptionProvider _subscriptionProvider;

  bool get isInitialized => _creditManager.isInitialized;
  int get usedCount => _creditManager.usedCount;
  int get remainingCredits => _creditManager.remainingCredits;
  int get maxFreeCredits => CreditLimits.maxFreeGenerations;

  bool get hasFreeCreditsRemaining => _creditManager.hasFreeCreditsRemaining;

  bool canUseCredit() {
    return _creditManager.canUseCredit(isPro: _subscriptionProvider.isPro);
  }

  Future<void> initialize() async {
    await _creditManager.initialize();
    notifyListeners();
  }

  Future<void> consumeCredit() async {
    final consumed = await _creditManager.consumeCredit(
      isPro: _subscriptionProvider.isPro,
    );
    if (consumed) {
      notifyListeners();
    }
  }

  void _onSubscriptionChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _subscriptionProvider.removeListener(_onSubscriptionChanged);
    super.dispose();
  }
}
