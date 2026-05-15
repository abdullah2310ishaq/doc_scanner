import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'home_header.dart';

class HomeHeaderSliverDelegate extends SliverPersistentHeaderDelegate {
  HomeHeaderSliverDelegate({
    required this.greeting,
    required this.titlePrefix,
    required this.proSemanticsLabel,
    required this.menuSemanticsLabel,
    this.onMenuTap,
    this.onProTap,
  });

  final String greeting;
  final String titlePrefix;
  final String proSemanticsLabel;
  final String menuSemanticsLabel;
  final VoidCallback? onMenuTap;
  final VoidCallback? onProTap;

  /// Toolbar row (45) + gaps + greeting (21) + title row (36) + vertical padding (20).
  static const double extent = 152;

  @override
  double get minExtent => extent;

  @override
  double get maxExtent => extent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: AppColors.scaffoldBackground,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: HomeHeader(
          greeting: greeting,
          titlePrefix: titlePrefix,
          proSemanticsLabel: proSemanticsLabel,
          menuSemanticsLabel: menuSemanticsLabel,
          onMenuTap: onMenuTap,
          onProTap: onProTap,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HomeHeaderSliverDelegate oldDelegate) {
    return greeting != oldDelegate.greeting ||
        titlePrefix != oldDelegate.titlePrefix ||
        proSemanticsLabel != oldDelegate.proSemanticsLabel ||
        menuSemanticsLabel != oldDelegate.menuSemanticsLabel;
  }
}
