import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
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

  void _log(String message) {
    debugPrint('[ProAccessScreen] $message');
  }

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

    _log(
      'Billing ready => storeAvailable=${subscription.isStoreAvailable}, hasProducts=${subscription.hasProducts}',
    );

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

    _log(
      'Continue tapped => plan=$_selectedPlan, trialEnabled=$_isTrialEnabled, storeAvailable=${subscription.isStoreAvailable}, hasProducts=${subscription.hasProducts}',
    );

    if (!subscription.isStoreAvailable || !subscription.hasProducts) {
      _log('Purchase blocked: store or products unavailable');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.proStoreUnavailable)));
      return;
    }

    _wasPurchasing = true;
    final started = await subscription.purchasePlan(_selectedPlan);
    if (!mounted) return;
    _log('Purchase launch result => started=$started, plan=$_selectedPlan');
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

    final weeklyTrialPrice = subscription.weeklySinglePaymentDisplayPrice();
    final weeklyStandardPrice = subscription.weeklyStandardDisplayPrice();
    final yearlyPrice = subscription.displayPriceForPlan(BillingPlan.yearly);
    final yearlyPerWeekPrice = subscription.yearlyPerWeekDisplayPrice();

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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: 36.w,
                      minHeight: 36.w,
                    ),
                    icon: Icon(Icons.close, color: Colors.black, size: 22.w),
                    onPressed: _onClose,
                  ),
                ),
                SizedBox(height: 4.h),
                Center(
                  child: SizedBox(
                    height: 200.h,
                    width: 220.w,
                    child: Lottie.asset(
                      'assets/in_app_animation.json',
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 24.sp, color: primaryColor),
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
                SizedBox(height: 10.h),

                _buildFeatureRow(l10n.proFeatureUnlimitedScans, primaryColor),
                _buildFeatureRow(l10n.proFeatureOcr, primaryColor),
                _buildFeatureRow(l10n.proFeaturePdf, primaryColor),
                _buildFeatureRow(l10n.proFeatureAi, primaryColor),
                SizedBox(height: 20.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
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
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Transform.scale(
                        scale: 0.85,
                        child: Switch(
                          value: _isTrialEnabled,
                          activeThumbColor: Colors.white,
                          activeTrackColor: primaryColor,
                          onChanged: (value) {
                            setState(() => _isTrialEnabled = value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _isTrialEnabled = true),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: _isTrialEnabled ? Colors.white : _lightBgColor,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: _isTrialEnabled
                                ? primaryColor
                                : Colors.black12,
                            width: _isTrialEnabled ? 1.5.w : 1.w,
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
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  if (weeklyStandardPrice != null)
                                    Text(
                                      l10n.proTrialThenPrice(
                                        weeklyStandardPrice,
                                      ),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (weeklyTrialPrice != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    weeklyTrialPrice,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    l10n.proPerWeek,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10.w,
                      top: -10.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          l10n.proSaveBadge,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                GestureDetector(
                  onTap: () => setState(() => _isTrialEnabled = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: !_isTrialEnabled ? Colors.white : _lightBgColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: !_isTrialEnabled ? primaryColor : Colors.black12,
                        width: !_isTrialEnabled ? 1.5.w : 1.w,
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
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              if (yearlyPrice != null)
                                Text(
                                  l10n.proYearlySubtitle(yearlyPrice),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 11.sp,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (yearlyPerWeekPrice != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                yearlyPerWeekPrice,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                l10n.proPerWeek,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),

                if (subscription.isPurchasing)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: const Center(child: CircularProgressIndicator()),
                  ),

                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF1966FE), Color(0xFF635CF1)],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
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
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      l10n.proContinue,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                if (_isTrialEnabled && weeklyStandardPrice != null)
                  Text(
                    l10n.proTrialDisclaimer(weeklyStandardPrice),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor.withValues(alpha: 0.8),
                      fontSize: 9.sp,
                      height: 1.25,
                    ),
                  )
                else if (!_isTrialEnabled && yearlyPrice != null)
                  Text(
                    l10n.proYearlyDisclaimer(yearlyPrice),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor.withValues(alpha: 0.8),
                      fontSize: 9.sp,
                      height: 1.25,
                    ),
                  ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String text, Color iconColor) {
    return Padding(
      padding: EdgeInsets.fromLTRB(80.w, 3.h, 4.w, 3.h),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: iconColor, size: 16.w),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
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
