import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'home_header.dart';

class HomeHeaderSliverDelegate extends SliverPersistentHeaderDelegate {
  HomeHeaderSliverDelegate({
    required this.title,
    this.tags,
  });

  final String title;
  final Widget? tags;

  static const double _topPadding = 14;
  static const double _titleExtent = 58;
  static const double _tagsExtent = 52;

  double get _extent => tags != null ? _titleExtent + _tagsExtent : _titleExtent;

  @override
  double get minExtent => _extent;

  @override
  double get maxExtent => _extent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: AppColors.scaffoldBackground,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, _topPadding, 16, 8),
        child: HomeHeader(
          title: title,
          tags: tags,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HomeHeaderSliverDelegate oldDelegate) {
    return title != oldDelegate.title || tags != oldDelegate.tags;
  }
}
