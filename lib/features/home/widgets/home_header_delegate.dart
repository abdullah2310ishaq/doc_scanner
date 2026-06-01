import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'home_header.dart';

class HomeHeaderSliverDelegate extends SliverPersistentHeaderDelegate {
  HomeHeaderSliverDelegate({
    required this.titlePrefix,
    required this.proSemanticsLabel,
    required this.menuSemanticsLabel,
    this.onMenuTap,
    this.onProTap,
    this.tags,
  });

  final String titlePrefix;
  final String proSemanticsLabel;
  final String menuSemanticsLabel;
  final VoidCallback? onMenuTap;
  final VoidCallback? onProTap;
  final Widget? tags;

  /// Room for drawer row, title, and feature tags (avoids 3px overflow).
  static const double extent = 135;

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
          titlePrefix: titlePrefix,
          proSemanticsLabel: proSemanticsLabel,

          onProTap: onProTap,
          tags: tags,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HomeHeaderSliverDelegate oldDelegate) {
    return titlePrefix != oldDelegate.titlePrefix ||
        proSemanticsLabel != oldDelegate.proSemanticsLabel ||
        menuSemanticsLabel != oldDelegate.menuSemanticsLabel;
  }
}
