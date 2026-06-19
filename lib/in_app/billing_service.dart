import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

/// Play Console subscription product ID (used in [InAppPurchase.queryProductDetails]).
const String kProWeeklyProductId = 'documentsingle';

/// Weekly base plan — auto-renewing.
const String kProWeeklyBasePlanId = 'documentsingle';

/// Weekly offer on [kProWeeklyBasePlanId].
const String kProWeeklyOfferId = 'singlepayment';

/// Play Console yearly subscription product ID — auto-renewing.
const String kProYearlyProductId = 'documentyearly';

/// Yearly base plan — auto-renewing.
const String kProYearlyBasePlanId = 'documentyearly';

enum BillingPlan { freeTrial, yearly }

enum BillingPurchaseStatus { pending, purchased, canceled, error }

class BillingPurchaseEvent {
  final BillingPurchaseStatus status;
  final String productId;

  const BillingPurchaseEvent({required this.status, required this.productId});
}

class BillingService {
  static const Set<String> _productIds = <String>{
    kProWeeklyProductId,
    kProYearlyProductId,
  };

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final StreamController<BillingPurchaseEvent> _purchaseEventsController =
      StreamController<BillingPurchaseEvent>.broadcast();

  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;
  bool _isStoreAvailable = false;
  bool _isInitialized = false;
  List<ProductDetails> _allProductVariants = const [];
  Map<String, ProductDetails> _productsById = const {};
  String? _trialPaidPriceFallback;
  String? _trialPaidPriceMax;
  GooglePlayProductDetails? _cachedWeeklySinglePayment;
  GooglePlayProductDetails? _cachedWeeklyStandard;
  GooglePlayProductDetails? _cachedYearly;

  Stream<BillingPurchaseEvent> get purchaseEvents =>
      _purchaseEventsController.stream;

  bool get isStoreAvailable => _isStoreAvailable;

  bool get hasProducts {
    final hasWeekly = _allProductVariants.any(
      (product) => product.id == kProWeeklyProductId,
    );
    final hasYearly = _allProductVariants.any(
      (product) => product.id == kProYearlyProductId,
    );
    return hasWeekly || hasYearly;
  }

  bool get isInitialized => _isInitialized;

  void _log(String message) {
    debugPrint('[BillingService] $message');
  }

  void _logAllStoreVariants(List<ProductDetails> products) {
    _log('--- All store variants count=${products.length} ---');
    for (final p in products) {
      _logAndroidOfferDetails(p, prefix: 'variant');
      _log(
        'variant => productId=${p.id}, title=${p.title}, price=${p.price}, currency=${p.currencyCode}, rawPrice=${p.rawPrice}',
      );
    }
    _log('--- End all store variants ---');
  }

  /// Logs every price the paywall uses — call once after products load.
  void logPaywallPriceSummary() {
    _log('========== PAYWALL PRICE SUMMARY ==========');
    _log('Play Console mapping (confirmed):');
    _log('  Weekly base plan: $kProWeeklyBasePlanId (weekly, auto-renewing)');
    _log('  Weekly offer: $kProWeeklyOfferId (inside $kProWeeklyBasePlanId)');
    _log('  Yearly base plan: $kProYearlyBasePlanId (yearly, auto-renewing)');

    _log('--- All loaded variants (${_allProductVariants.length}) ---');
    for (final product in _allProductVariants) {
      if (product is GooglePlayProductDetails) {
        final offer = _offerAt(product);
        _log(
          '  variant => productId=${product.id}, basePlanId=${offer?.basePlanId}, offerId=${offer?.offerId ?? "null"}, price=${product.price}, rawPrice=${product.rawPrice}',
        );
      } else {
        _log(
          '  variant => productId=${product.id}, price=${product.price}, rawPrice=${product.rawPrice}',
        );
      }
    }

    final trialCardRight = weeklySinglePaymentDisplayPrice();
    final trialCardThen = weeklyStandardDisplayPrice();
    final yearlyCardLeft = displayPriceForPlan(BillingPlan.yearly);
    final yearlyCardRight = yearlyPerWeekDisplayPrice();
    final trialPurchase = productForPlan(BillingPlan.freeTrial);
    final yearlyPurchase = productForPlan(BillingPlan.yearly);

    _log('--- Paywall UI prices ---');
    _log(
      '  3-Day card RIGHT (singlepayment): ${trialCardRight ?? "NOT LOADED"}',
    );
    _log(
      '  3-Day card THEN line (standard weekly): ${trialCardThen ?? "NOT LOADED"}',
    );
    _log(
      '  Yearly card LEFT (documentyearly): ${yearlyCardLeft ?? "NOT LOADED"}',
    );
    _log(
      '  Yearly card RIGHT (yearly ÷ 52): ${yearlyCardRight ?? "NOT LOADED"}',
    );

    _log('--- Purchase products ---');
    if (trialPurchase is GooglePlayProductDetails) {
      final offer = _offerAt(trialPurchase);
      _log(
        '  Trial purchase => productId=${trialPurchase.id}, basePlanId=${offer?.basePlanId}, offerId=${offer?.offerId}, price=${trialPurchase.price}',
      );
    } else {
      _log('  Trial purchase => NOT LOADED');
    }
    if (yearlyPurchase is GooglePlayProductDetails) {
      final offer = _offerAt(yearlyPurchase);
      _log(
        '  Yearly purchase => productId=${yearlyPurchase.id}, basePlanId=${offer?.basePlanId}, offerId=${offer?.offerId ?? "null"}, price=${yearlyPurchase.price}',
      );
    } else {
      _log('  Yearly purchase => NOT LOADED');
    }
    _log('========== END PAYWALL PRICE SUMMARY ==========');
  }

  void _cachePaywallVariants() {
    _cachedWeeklySinglePayment = _findWeeklySinglePaymentOffer();
    _cachedWeeklyStandard = _findWeeklyStandardOffer();
    _cachedYearly = _findYearlyProduct();
  }

  void _logAndroidOfferDetails(
    ProductDetails product, {
    String prefix = 'offer',
  }) {
    if (product is! GooglePlayProductDetails) return;

    final subscriptionIndex = product.subscriptionIndex;
    final offers = product.productDetails.subscriptionOfferDetails;
    if (subscriptionIndex == null || offers == null) return;
    if (subscriptionIndex >= offers.length) return;

    final offer = offers[subscriptionIndex];
    _log(
      '$prefix => productId=${product.id}, basePlanId=${offer.basePlanId}, offerId=${offer.offerId}, offerToken=${offer.offerIdToken}',
    );
    for (final phase in offer.pricingPhases) {
      _log(
        '  pricingPhase => price=${phase.formattedPrice}, micros=${phase.priceAmountMicros}, period=${phase.billingPeriod}, recurrence=${phase.recurrenceMode}',
      );
    }
  }

  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;
    _log('Initialize requested.');
    _log(
      'Configured IDs => weeklyProduct=$kProWeeklyProductId, weeklyBasePlan=$kProWeeklyBasePlanId, weeklyOffer=$kProWeeklyOfferId, yearlyProduct=$kProYearlyProductId, yearlyBasePlan=$kProYearlyBasePlanId',
    );
    _log('Query product IDs: $_productIds');

    try {
      _isStoreAvailable = await _inAppPurchase.isAvailable();
      _log('Store available: $_isStoreAvailable');
    } catch (error, stackTrace) {
      _isStoreAvailable = false;
      _log('Store connection failed during isAvailable: $error');
      _log('Store connection stack trace: $stackTrace');
    }

    if (!_isStoreAvailable) {
      _log('Store not available. Billing setup will stay in fallback mode.');
      return;
    }

    try {
      _purchaseSubscription = _inAppPurchase.purchaseStream.listen(
        _handlePurchaseUpdates,
        onDone: () => _purchaseSubscription?.cancel(),
        onError: (Object error, StackTrace stackTrace) {
          _log('Purchase stream error: $error');
          _log('Purchase stream stack trace: $stackTrace');
        },
      );

      _log('Querying product details from store...');
      final ProductDetailsResponse response = await _inAppPurchase
          .queryProductDetails(_productIds);
      _log('Store products returned: ${response.productDetails.length}');
      _log('Store products not found: ${response.notFoundIDs}');
      if (response.error != null) {
        _log(
          'Store query error: code=${response.error!.code}, message=${response.error!.message}',
        );
      }

      _logAllStoreVariants(response.productDetails);

      _allProductVariants = response.productDetails;

      // Some Play Billing configurations return multiple ProductDetails for the
      // same subscription productId (trial offer vs paid offer). Keep the paid
      // price around for UI display on the "Free trial" card.
      _trialPaidPriceFallback = null;
      _trialPaidPriceMax = null;
      final paidVariants =
          response.productDetails
              .where((p) => p.id == kProWeeklyProductId && p.rawPrice > 0)
              .toList()
            ..sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
      if (paidVariants.isNotEmpty) {
        final minPrice = paidVariants.first.price.trim();
        final maxPrice = paidVariants.last.price.trim();
        _trialPaidPriceFallback = minPrice.isEmpty ? null : minPrice;
        _trialPaidPriceMax = maxPrice.isEmpty ? null : maxPrice;
      }

      _productsById = _buildProductsById(response.productDetails);

      final countsById = <String, int>{};
      for (final product in response.productDetails) {
        countsById[product.id] = (countsById[product.id] ?? 0) + 1;
      }

      // Log the resolved product per ID (what the app will actually use),
      // then separately note if Play returned multiple variants for that ID.
      for (final entry in _productsById.entries) {
        final product = entry.value;
        final variants = countsById[product.id] ?? 1;
        _log(
          'Product resolved => id=${product.id}, variants=$variants, title=${product.title}, price=${product.price}, currency=${product.currencyCode}, rawPrice=${product.rawPrice}',
        );
        _logAndroidOfferDetails(product, prefix: 'resolved');
      }

      final weeklyResolved = _resolveWeeklyProduct(preferTrial: true);
      if (weeklyResolved != null) {
        _log(
          'Weekly plan resolved for UI/purchase (preferTrial=true) => id=${weeklyResolved.id}, price=${weeklyResolved.price}',
        );
        _logAndroidOfferDetails(weeklyResolved, prefix: 'weeklySelected');
      } else {
        _log(
          'Weekly plan not resolved. Check basePlan=$kProWeeklyBasePlanId, offer=$kProWeeklyOfferId',
        );
      }

      final yearlyResolved = _resolveYearlyProduct();
      if (yearlyResolved != null) {
        _log(
          'Yearly plan resolved for UI/purchase => id=${yearlyResolved.id}, price=${yearlyResolved.price}',
        );
        _logAndroidOfferDetails(yearlyResolved, prefix: 'yearlySelected');
      } else {
        _log('Yearly plan not resolved. Check basePlan=$kProYearlyBasePlanId');
      }

      _cachePaywallVariants();
      logPaywallPriceSummary();
    } catch (error, stackTrace) {
      _log('Billing setup failed after store availability check: $error');
      _log('Billing setup stack trace: $stackTrace');
      _isStoreAvailable = false;
      _productsById = const {};
      _allProductVariants = const [];
      await _purchaseSubscription?.cancel();
      _purchaseSubscription = null;
      return;
    }
  }

  ProductDetails? productForPlan(BillingPlan plan) {
    switch (plan) {
      case BillingPlan.freeTrial:
        return _resolveWeeklyProduct(preferTrial: true);
      case BillingPlan.yearly:
        return _resolveYearlyProduct();
    }
  }

  GooglePlayProductDetails? _resolveYearlyProduct() {
    return _cachedYearly ?? _findYearlyProduct();
  }

  GooglePlayProductDetails? _findYearlyProduct() {
    final variants = _allProductVariants
        .where(
          (product) =>
              product.id == kProYearlyProductId &&
              product is GooglePlayProductDetails,
        )
        .cast<GooglePlayProductDetails>()
        .toList();

    _log(
      'Resolve yearly => variants=${variants.length}, basePlan=$kProYearlyBasePlanId',
    );

    GooglePlayProductDetails? basePlanMatch;
    GooglePlayProductDetails? fallback;

    for (final variant in variants) {
      final offer = _offerAt(variant);
      if (offer == null) continue;

      _log(
        'Yearly candidate => basePlanId=${offer.basePlanId}, offerId=${offer.offerId}, price=${variant.price}',
      );

      fallback ??= variant;

      if (offer.basePlanId != kProYearlyBasePlanId) {
        continue;
      }

      if (basePlanMatch == null || !_hasAndroidFreeTrialPhase(variant)) {
        basePlanMatch = variant;
      }
    }

    if (basePlanMatch != null) {
      _log(
        'Yearly resolved => offerId=${_offerAt(basePlanMatch)?.offerId}, price=${basePlanMatch.price}',
      );
      return basePlanMatch;
    }

    if (fallback != null) {
      _log('Yearly resolved with first available variant (no base-plan match)');
      return fallback;
    }

    _log(
      'Yearly resolve failed: no variants for productId=$kProYearlyProductId',
    );
    return null;
  }

  GooglePlayProductDetails? _resolveWeeklyProduct({required bool preferTrial}) {
    return _findWeeklyProduct(preferTrial: preferTrial);
  }

  GooglePlayProductDetails? _findWeeklyProduct({required bool preferTrial}) {
    final variants = _allProductVariants
        .where(
          (product) =>
              product.id == kProWeeklyProductId &&
              product is GooglePlayProductDetails,
        )
        .cast<GooglePlayProductDetails>()
        .toList();

    _log(
      'Resolve weekly => variants=${variants.length}, preferTrial=$preferTrial, basePlan=$kProWeeklyBasePlanId, offer=$kProWeeklyOfferId',
    );

    GooglePlayProductDetails? singlePaymentOffer;
    GooglePlayProductDetails? trialOffer;
    GooglePlayProductDetails? basePlanFallback;

    for (final variant in variants) {
      final offer = _offerAt(variant);
      if (offer == null) continue;

      _log(
        'Weekly candidate => basePlanId=${offer.basePlanId}, offerId=${offer.offerId}, price=${variant.price}',
      );

      if (offer.basePlanId != kProWeeklyBasePlanId) {
        continue;
      }

      basePlanFallback ??= variant;

      if (offer.offerId == kProWeeklyOfferId) {
        singlePaymentOffer = variant;
      }

      if (_hasAndroidFreeTrialPhase(variant)) {
        trialOffer = variant;
      }
    }

    if (preferTrial && trialOffer != null) {
      _log(
        'Weekly resolved with trial offer => offerId=${_offerAt(trialOffer)?.offerId}',
      );
      return trialOffer;
    }

    if (singlePaymentOffer != null) {
      _log('Weekly resolved with singlepayment offer');
      return singlePaymentOffer;
    }

    if (basePlanFallback != null) {
      _log(
        'Weekly resolved with base-plan fallback => offerId=${_offerAt(basePlanFallback)?.offerId}',
      );
      return basePlanFallback;
    }

    if (variants.isNotEmpty) {
      _log('Weekly resolved with first available variant (no base-plan match)');
      return variants.first;
    }

    _log(
      'Weekly resolve failed: no variants for productId=$kProWeeklyProductId',
    );
    return null;
  }

  /// Default weekly base-plan offer (offerId null) — shown on the trial card UI.
  GooglePlayProductDetails? _resolveWeeklyStandardOffer() {
    return _cachedWeeklyStandard ?? _findWeeklyStandardOffer();
  }

  GooglePlayProductDetails? _findWeeklyStandardOffer() {
    final variants = _allProductVariants
        .where(
          (product) =>
              product.id == kProWeeklyProductId &&
              product is GooglePlayProductDetails,
        )
        .cast<GooglePlayProductDetails>()
        .toList();

    GooglePlayProductDetails? standardOffer;
    GooglePlayProductDetails? highestPriceFallback;

    for (final variant in variants) {
      final offer = _offerAt(variant);
      if (offer == null) continue;
      if (offer.basePlanId != kProWeeklyBasePlanId) continue;

      final offerId = offer.offerId;
      final isStandardOffer = offerId == null || offerId.isEmpty;

      if (isStandardOffer) {
        standardOffer = variant;
        break;
      }

      if (highestPriceFallback == null ||
          variant.rawPrice > highestPriceFallback.rawPrice) {
        highestPriceFallback = variant;
      }
    }

    final resolved = standardOffer ?? highestPriceFallback;
    return resolved;
  }

  /// `singlepayment` offer on [kProWeeklyBasePlanId] — trial card main price.
  GooglePlayProductDetails? _resolveWeeklySinglePaymentOffer() {
    return _cachedWeeklySinglePayment ?? _findWeeklySinglePaymentOffer();
  }

  GooglePlayProductDetails? _findWeeklySinglePaymentOffer() {
    final variants = _allProductVariants
        .where(
          (product) =>
              product.id == kProWeeklyProductId &&
              product is GooglePlayProductDetails,
        )
        .cast<GooglePlayProductDetails>();

    for (final variant in variants) {
      final offer = _offerAt(variant);
      if (offer == null) continue;
      if (offer.basePlanId != kProWeeklyBasePlanId) continue;
      if (offer.offerId == kProWeeklyOfferId) {
        return variant;
      }
    }

    return null;
  }

  String? weeklySinglePaymentDisplayPrice() {
    return _displayPriceFromDetails(_resolveWeeklySinglePaymentOffer());
  }

  String? weeklyStandardDisplayPrice() {
    return _displayPriceFromDetails(_resolveWeeklyStandardOffer());
  }

  /// Yearly price divided by 52 — shown per week on the yearly card.
  String? yearlyPerWeekDisplayPrice() {
    final yearly = _resolveYearlyProduct();
    if (yearly == null || yearly.rawPrice <= 0) return null;

    final perWeek = (yearly.rawPrice / 52).round();
    return _formatPriceLikeStore(perWeek.toDouble(), yearly, decimalDigits: 0);
  }

  String? _displayPriceFromDetails(GooglePlayProductDetails? details) {
    if (details == null) return null;

    final price = details.price.trim();
    if (price.isNotEmpty && price != '0' && price.toLowerCase() != 'free') {
      return price;
    }

    final subscriptionIndex = details.subscriptionIndex;
    final offers = details.productDetails.subscriptionOfferDetails;
    if (subscriptionIndex != null &&
        offers != null &&
        subscriptionIndex < offers.length) {
      final paidPhase = offers[subscriptionIndex].pricingPhases.firstWhere(
        (p) => p.priceAmountMicros > 0,
        orElse: () => offers[subscriptionIndex].pricingPhases.isNotEmpty
            ? offers[subscriptionIndex].pricingPhases.last
            : offers[subscriptionIndex].pricingPhases.first,
      );
      if (paidPhase.formattedPrice.isNotEmpty) {
        return paidPhase.formattedPrice;
      }
    }

    return null;
  }

  String _formatPriceLikeStore(
    double amount,
    ProductDetails details, {
    int decimalDigits = 2,
  }) {
    final sample = details.price.trim();
    final prefixMatch = RegExp(r'^([^\d]+)').firstMatch(sample);
    final prefix = prefixMatch?.group(1)?.trim() ?? '';
    final numberPart = decimalDigits == 0
        ? NumberFormat('#,##0').format(amount.round())
        : NumberFormat('#,##0.00').format(amount);
    if (prefix.isEmpty) return numberPart;
    return '$prefix $numberPart';
  }

  SubscriptionOfferDetailsWrapper? _offerAt(GooglePlayProductDetails details) {
    final subscriptionIndex = details.subscriptionIndex;
    final offers = details.productDetails.subscriptionOfferDetails;
    if (subscriptionIndex == null || offers == null) return null;
    if (subscriptionIndex >= offers.length) return null;
    return offers[subscriptionIndex];
  }

  String? displayPriceForPlan(BillingPlan plan) {
    final details = productForPlan(plan);
    if (details == null) return null;

    final direct = details.price.trim();
    if (direct.isNotEmpty && direct != '0' && direct.toLowerCase() != 'free') {
      return direct;
    }

    if (defaultTargetPlatform != TargetPlatform.android) {
      return direct.isEmpty ? null : direct;
    }

    if (details is! GooglePlayProductDetails) {
      return direct.isEmpty ? null : direct;
    }

    final subscriptionIndex = details.subscriptionIndex;
    final offers = details.productDetails.subscriptionOfferDetails;
    if (subscriptionIndex == null || offers == null) return null;
    if (subscriptionIndex >= offers.length) return null;

    final offer = offers[subscriptionIndex];
    final paidPhase = offer.pricingPhases.firstWhere(
      (p) => p.priceAmountMicros > 0,
      orElse: () => offer.pricingPhases.isNotEmpty
          ? offer.pricingPhases.last
          : offer.pricingPhases.first,
    );

    final formatted = paidPhase.formattedPrice;
    if (formatted.isNotEmpty) {
      return formatted;
    }

    if (plan == BillingPlan.freeTrial &&
        _trialPaidPriceFallback != null &&
        _trialPaidPriceFallback!.isNotEmpty) {
      return _trialPaidPriceFallback;
    }

    // Fallback: use ProductDetails fields when formatted phase price missing.
    final fallback = details.price.trim();
    return fallback.isEmpty ? null : fallback;
  }

  /// Lowest paid weekly price among returned variants (if any).
  String? weeklyPaidMinPrice() {
    final p = _trialPaidPriceFallback?.trim();
    return (p == null || p.isEmpty) ? null : p;
  }

  /// Highest paid weekly price among returned variants (if any).
  String? weeklyPaidMaxPrice() {
    final standard = weeklyStandardDisplayPrice()?.trim();
    if (standard != null && standard.isNotEmpty) {
      return standard;
    }
    final p = _trialPaidPriceMax?.trim();
    return (p == null || p.isEmpty) ? null : p;
  }

  Future<bool> purchasePlan(BillingPlan plan) async {
    final ProductDetails? productDetails = productForPlan(plan);
    if (productDetails == null) {
      _log('Purchase start failed: product not found for plan=$plan');
      return false;
    }
    _log(
      'Starting purchase for plan=$plan, productId=${productDetails.id}, price=${productDetails.price}',
    );
    _logAndroidOfferDetails(productDetails, prefix: 'purchase');

    final PurchaseParam purchaseParam = _buildPurchaseParam(
      plan: plan,
      productDetails: productDetails,
    );
    try {
      return _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (error, stackTrace) {
      _log('Purchase launch threw exception: $error');
      _log('Purchase launch stack trace: $stackTrace');
      return false;
    }
  }

  Future<void> restorePurchases() async {
    if (!_isInitialized) {
      await initialize();
    }
    if (!_isStoreAvailable) return;

    try {
      _log('Restoring purchases...');
      await _inAppPurchase.restorePurchases();
    } catch (error, stackTrace) {
      _log('Restore purchases failed: $error');
      _log('Restore purchases stack trace: $stackTrace');
    }
  }

  Map<String, ProductDetails> _buildProductsById(
    List<ProductDetails> products,
  ) {
    final resolved = <String, ProductDetails>{};

    for (final product in products) {
      final existing = resolved[product.id];
      if (existing == null) {
        resolved[product.id] = product;
        continue;
      }

      // Android subscriptions can return multiple ProductDetails entries for the
      // same productId (different base plans / offers).
      if (product.id == kProWeeklyProductId &&
          defaultTargetPlatform == TargetPlatform.android) {
        resolved[product.id] = _preferWeeklyOffer(existing, product);
        continue;
      }

      if (product.id == kProYearlyProductId &&
          defaultTargetPlatform == TargetPlatform.android) {
        resolved[product.id] = _preferYearlyOffer(existing, product);
        continue;
      }

      // Keep the first by default.
      resolved[product.id] = existing;
    }

    return resolved;
  }

  ProductDetails _preferWeeklyOffer(ProductDetails a, ProductDetails b) {
    if (a is! GooglePlayProductDetails || b is! GooglePlayProductDetails) {
      return _preferTrialOffer(a, b);
    }

    final aOffer = _offerAt(a);
    final bOffer = _offerAt(b);

    final aIsTarget =
        aOffer?.basePlanId == kProWeeklyBasePlanId &&
        aOffer?.offerId == kProWeeklyOfferId;
    final bIsTarget =
        bOffer?.basePlanId == kProWeeklyBasePlanId &&
        bOffer?.offerId == kProWeeklyOfferId;

    if (aIsTarget && !bIsTarget) return a;
    if (!aIsTarget && bIsTarget) return b;

    return _preferTrialOffer(a, b);
  }

  ProductDetails _preferYearlyOffer(ProductDetails a, ProductDetails b) {
    if (a is! GooglePlayProductDetails || b is! GooglePlayProductDetails) {
      return a;
    }

    final aOffer = _offerAt(a);
    final bOffer = _offerAt(b);

    final aIsYearly = aOffer?.basePlanId == kProYearlyBasePlanId;
    final bIsYearly = bOffer?.basePlanId == kProYearlyBasePlanId;

    if (aIsYearly && !bIsYearly) return a;
    if (!aIsYearly && bIsYearly) return b;

    return a;
  }

  ProductDetails _preferTrialOffer(ProductDetails a, ProductDetails b) {
    final aHasTrial = _hasAndroidFreeTrialPhase(a);
    final bHasTrial = _hasAndroidFreeTrialPhase(b);

    if (aHasTrial && !bHasTrial) return a;
    if (!aHasTrial && bHasTrial) return b;

    // If both (or neither) have a trial phase, prefer the one with the lower
    // first paid price (rawPrice is the first pricing phase's rawPrice).
    return b.rawPrice < a.rawPrice ? b : a;
  }

  bool _hasAndroidFreeTrialPhase(ProductDetails details) {
    if (details is! GooglePlayProductDetails) return false;
    final subscriptionIndex = details.subscriptionIndex;
    if (subscriptionIndex == null) return false;

    final offers = details.productDetails.subscriptionOfferDetails;
    if (offers == null || subscriptionIndex >= offers.length) return false;

    final offer = offers[subscriptionIndex];
    return offer.pricingPhases.any((p) => p.priceAmountMicros == 0);
  }

  PurchaseParam _buildPurchaseParam({
    required BillingPlan plan,
    required ProductDetails productDetails,
  }) {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return PurchaseParam(productDetails: productDetails);
    }

    // Subscription plans on Android must launch with the Play offer token.
    if (plan == BillingPlan.freeTrial || plan == BillingPlan.yearly) {
      if (productDetails is! GooglePlayProductDetails) {
        return PurchaseParam(productDetails: productDetails);
      }

      final offerToken = productDetails.offerToken;
      if (offerToken == null || offerToken.isEmpty) {
        _log(
          'No subscription offer token for plan=$plan productId=${productDetails.id}. Proceeding without offer token.',
        );
        return PurchaseParam(productDetails: productDetails);
      }

      _log('Using offerToken=$offerToken for plan=$plan');
      return GooglePlayPurchaseParam(
        productDetails: productDetails,
        offerToken: offerToken,
      );
    }

    return PurchaseParam(productDetails: productDetails);
  }

  Future<void> _handlePurchaseUpdates(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    _log('Purchase updates received: ${purchaseDetailsList.length}');
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      final String productId = purchaseDetails.productID;
      _log(
        'Purchase update => productId=$productId, status=${purchaseDetails.status}, pendingComplete=${purchaseDetails.pendingCompletePurchase}, error=${purchaseDetails.error}',
      );

      final isManagedProduct = _productIds.contains(productId);
      if (!isManagedProduct) {
        // Some devices/flows can deliver a canceled/error update with an empty
        // productId. Still emit an event so UI can stop showing progress.
        if (productId.isEmpty &&
            (purchaseDetails.status == PurchaseStatus.canceled ||
                purchaseDetails.status == PurchaseStatus.error)) {
          _purchaseEventsController.add(
            BillingPurchaseEvent(
              status: purchaseDetails.status == PurchaseStatus.canceled
                  ? BillingPurchaseStatus.canceled
                  : BillingPurchaseStatus.error,
              productId: productId,
            ),
          );
        } else {
          _log('Ignoring purchase update for unmanaged productId=$productId');
        }
        continue;
      }

      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          _purchaseEventsController.add(
            BillingPurchaseEvent(
              status: BillingPurchaseStatus.pending,
              productId: productId,
            ),
          );
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          if (purchaseDetails.pendingCompletePurchase) {
            try {
              _log('Completing purchase for productId=$productId');
              await _inAppPurchase.completePurchase(purchaseDetails);
            } catch (error, stackTrace) {
              _log('Complete purchase failed for productId=$productId: $error');
              _log('Complete purchase stack trace: $stackTrace');
              _purchaseEventsController.add(
                BillingPurchaseEvent(
                  status: BillingPurchaseStatus.error,
                  productId: productId,
                ),
              );
              break;
            }
          }

          if (!_isPurchaseVerificationDataValid(purchaseDetails)) {
            _log(
              'Purchase verification data missing. productId=$productId, status=${purchaseDetails.status}',
            );
            _purchaseEventsController.add(
              BillingPurchaseEvent(
                status: BillingPurchaseStatus.error,
                productId: productId,
              ),
            );
            break;
          }
          _purchaseEventsController.add(
            BillingPurchaseEvent(
              status: BillingPurchaseStatus.purchased,
              productId: productId,
            ),
          );
          break;
        case PurchaseStatus.canceled:
          _purchaseEventsController.add(
            BillingPurchaseEvent(
              status: BillingPurchaseStatus.canceled,
              productId: productId,
            ),
          );
          break;
        case PurchaseStatus.error:
          _purchaseEventsController.add(
            BillingPurchaseEvent(
              status: BillingPurchaseStatus.error,
              productId: productId,
            ),
          );
          break;
      }
    }
  }

  bool _isPurchaseVerificationDataValid(PurchaseDetails purchaseDetails) {
    final data = purchaseDetails.verificationData.serverVerificationData;
    return data.isNotEmpty;
  }

  Future<void> dispose() async {
    _log('Disposing billing service.');
    await _purchaseSubscription?.cancel();
    await _purchaseEventsController.close();
  }
}
