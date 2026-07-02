import '../../features/subscription/models/feature_type.dart';
import '../../features/subscription/models/subscription_plan.dart';

abstract final class PremiumLimits {
  static const int weeklyPeriodDays = 7;
  static const int yearlyPeriodDays = 365;

  // Weekly Pass
  static const int ocrPagesWeekly = 350;
  static const int smartCropWeekly = 250;
  static const int pdfAssistantWeekly = 250;
  static const int askPdfWeekly = 330;

  // Yearly Plan
  static const int ocrPagesYearly = 2200;
  static const int smartCropYearly = 1700;
  static const int pdfAssistantYearly = 420;
  static const int askPdfYearly = 550;

  static int limitFor({
    required SubscriptionPlan plan,
    required FeatureType feature,
  }) {
    return switch (plan) {
      SubscriptionPlan.weekly => switch (feature) {
        FeatureType.ocrScan => ocrPagesWeekly,
        FeatureType.smartCrop => smartCropWeekly,
        FeatureType.pdfAssistant => pdfAssistantWeekly,
        FeatureType.askPdf => askPdfWeekly,
      },
      SubscriptionPlan.yearly => switch (feature) {
        FeatureType.ocrScan => ocrPagesYearly,
        FeatureType.smartCrop => smartCropYearly,
        FeatureType.pdfAssistant => pdfAssistantYearly,
        FeatureType.askPdf => askPdfYearly,
      },
      SubscriptionPlan.none => 0,
    };
  }
}
