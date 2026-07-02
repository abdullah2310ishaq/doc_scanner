import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/credits/providers/credit_provider.dart';
import '../../features/subscription/models/feature_type.dart';
import '../../features/subscription/providers/subscription_provider.dart';
import '../../in_app/paywall_routes.dart';
import '../utils/l10n_extension.dart';
import '../widgets/toast.dart';

/// Gates AI generations for free users (shared credits) and premium users (plan caps).
abstract final class CreditGate {
  /// Returns `true` when the user may start a generation.
  static Future<bool> ensureCanGenerate(
    BuildContext context, {
    required FeatureType feature,
  }) async {
    final subscription = context.read<SubscriptionProvider>();
    if (subscription.isPro) {
      await subscription.prepareUsageCheck();
      if (!context.mounted) return false;
      if (subscription.canUse(feature)) {
        return true;
      }

      AppToast.show(context, context.l10n.proLimitOcr);
      return false;
    }

    final credits = context.read<CreditProvider>();
    if (credits.canUseCredit()) {
      return true;
    }

    AppToast.show(context, context.l10n.proLimitOcr);
    if (!context.mounted) {
      return false;
    }

    await PaywallRoutes.openFeatureGate(context);
    if (!context.mounted) {
      return false;
    }

    final updated = context.read<SubscriptionProvider>();
    if (updated.isPro) {
      await updated.prepareUsageCheck();
      if (!context.mounted) return false;
      return updated.canUse(feature);
    }

    return false;
  }

  /// Call after a generation succeeds.
  static Future<void> recordGeneration(
    BuildContext context, {
    required FeatureType feature,
  }) async {
    if (!context.mounted) return;

    final subscription = context.read<SubscriptionProvider>();
    if (subscription.isPro) {
      await subscription.recordUsage(feature);
      return;
    }

    await context.read<CreditProvider>().consumeCredit();
  }
}
