import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../ads/app_open.dart';
import '../ads/inter.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/l10n_extension.dart';
import '../features/subscription/providers/subscription_provider.dart';
import 'billing_service.dart';

class ProAccessScreen extends StatefulWidget {
  const ProAccessScreen({
    super.key,
    required this.nextScreen,
    this.initialTrialEnabled = false,
    this.showAdOnClose = false,
    this.replaceOnExit = true,
  });

  final Widget nextScreen;
  final bool initialTrialEnabled;
  final bool showAdOnClose;
  final bool replaceOnExit;

  @override
  State<ProAccessScreen> createState() => _ProAccessScreenState();
}

class _ProAccessScreenState extends State<ProAccessScreen> {
  final InterstitialAdService _interstitialService = InterstitialAdService();
  late bool _isTrialEnabled;
  SubscriptionProvider? _subscription;
  bool _wasPurchasing = false;

  static const Color _lightBgColor = Color(0xfff4f5f9);

  @override
  void initState() {
    super.initState();
    _isTrialEnabled = widget.initialTrialEnabled;
    if (widget.showAdOnClose) {
      _interstitialService.loadAd();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _subscription = context.read<SubscriptionProvider>();
      _subscription?.addListener(_onSubscriptionChanged);
      _ensureBillingReady();
    });
  }

  Future<void> _ensureBillingReady() async {
    final subscription = context.read<SubscriptionProvider>();
    if (!subscription.isInitialized) {
      await subscription.initialize();
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _subscription?.removeListener(_onSubscriptionChanged);
    super.dispose();
  }

  BillingPlan get _selectedPlan =>
      _isTrialEnabled ? BillingPlan.freeTrial : BillingPlan.yearly;

  void _onSubscriptionChanged() {
    final subscription = context.read<SubscriptionProvider>();
    if (subscription.isPro) {
      _exitToNext();
      return;
    }

    if (_wasPurchasing && !subscription.isPurchasing) {
      _wasPurchasing = false;
      if (!subscription.isPro && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.proPurchaseFailed)));
      }
    }
  }

  Future<void> _onContinue() async {
    final l10n = context.l10n;
    final subscription = context.read<SubscriptionProvider>();

    if (!subscription.isStoreAvailable || !subscription.hasProducts) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.proStoreUnavailable)));
      return;
    }

    _wasPurchasing = true;
    final started = await subscription.purchasePlan(_selectedPlan);
    if (!mounted) return;
    if (!started) {
      _wasPurchasing = false;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.proPurchaseFailed)));
    }
  }

  void _onClose() {
    if (widget.showAdOnClose) {
      AppOpenAdService.instance.blockNextForegroundShow();

      final navigator = Navigator.of(context);
      final loadingMessage = context.l10n.adLoading;

      _interstitialService.showAdWithLoading(
        context: context,
        loadingMessage: loadingMessage,
        onLoadingDismissed: () {
          if (!navigator.mounted) {
            return;
          }
          if (widget.replaceOnExit) {
            navigator.pushReplacement(
              MaterialPageRoute<void>(builder: (_) => widget.nextScreen),
            );
          } else {
            navigator.pop();
          }
        },
        onAdDismissed: () {},
      );
      return;
    }
    _exitToNext();
  }

  void _exitToNext() {
    if (!mounted) return;
    if (widget.replaceOnExit) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => widget.nextScreen),
      );
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final subscription = context.watch<SubscriptionProvider>();
    final primaryColor = AppColors.textLink;

    const String dummyWeeklyPrice = "Rs 500.00";
    const String dummyWeeklyThenPrice = "Rs 1,900.00";
    const String dummyYearlyPrice = "Rs 9,900.00";

    final canPurchase =
        subscription.isStoreAvailable &&
        subscription.hasProducts &&
        !subscription.isPurchasing;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _onClose();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.black, size: 28.w),
                    onPressed: _onClose,
                  ),
                ),
                const Spacer(flex: 1),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 32.sp, color: primaryColor),
                    children: [
                      TextSpan(
                        text: '${l10n.proPaywallTitleGet} ',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: l10n.proPaywallTitlePro,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' ${l10n.proPaywallTitleAccess}',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                _buildFeatureRow(l10n.proFeatureUnlimitedScans, primaryColor),
                _buildFeatureRow(l10n.proFeatureOcr, primaryColor),
                _buildFeatureRow(l10n.proFeaturePdf, primaryColor),
                _buildFeatureRow(l10n.proFeatureAi, primaryColor),
                SizedBox(height: 24.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _lightBgColor,
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.proEnableTrial,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Switch(
                        value: _isTrialEnabled,
                        activeThumbColor: Colors.white,
                        activeTrackColor: primaryColor,
                        onChanged: (value) {
                          setState(() => _isTrialEnabled = value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _isTrialEnabled = true),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: _isTrialEnabled ? Colors.white : _lightBgColor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: _isTrialEnabled
                                ? primaryColor
                                : Colors.black12,
                            width: _isTrialEnabled ? 2.w : 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.proTrialPlanTitle,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "then $dummyWeeklyThenPrice/week",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  dummyWeeklyPrice,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  l10n.proPerWeek,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12.w,
                      top: -12.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          l10n.proSaveBadge,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),

                GestureDetector(
                  onTap: () => setState(() => _isTrialEnabled = false),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: !_isTrialEnabled ? Colors.white : _lightBgColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: !_isTrialEnabled ? primaryColor : Colors.black12,
                        width: !_isTrialEnabled ? 2.w : 1.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.proYearlyPlanTitle,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "just $dummyYearlyPrice per year",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Rs 190.38",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              l10n.proPerWeek,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 2),

                if (subscription.isPurchasing)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: const Center(child: CircularProgressIndicator()),
                  ),

                // 7. Gradient Continue Button Wrap Integration
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF1966FE), // 0%
                        Color(0xFF635CF1), // 99.62%
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: ElevatedButton(
                    onPressed: canPurchase ? _onContinue : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: AppColors.white,
                      disabledBackgroundColor: Colors.transparent,
                      disabledForegroundColor: AppColors.white.withValues(
                        alpha: 0.5,
                      ),
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      l10n.proContinue,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                Text(
                  _isTrialEnabled
                      ? "After 3 days free - then weekly subscription for $dummyYearlyPrice will start. Cancel anytime 24 hours before renewal"
                      : "Yearly subscription for $dummyWeeklyThenPrice/year. Cancel anytime at least 24 hours before renewal.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor.withValues(alpha: 0.8),
                    fontSize: 12.sp,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String text, Color iconColor) {
    return Padding(
      padding: EdgeInsets.fromLTRB(36.w, 6.h, 8.w, 6.h),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: iconColor, size: 22.w),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: iconColor.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
