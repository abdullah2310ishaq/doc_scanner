import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import 'native_ad_sizes.dart';

/// Blue banner-height placeholder shown while a native/banner ad loads.
class AdBannerLoadingPlaceholder extends StatelessWidget {
  const AdBannerLoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: NativeAdSizes.bannerHeight,
      width: double.infinity,

      child: const Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.navbarGradientStart,
          ),
        ),
      ),
    );
  }
}
