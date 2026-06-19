import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'home_header.dart';

class HomeHeaderSliverDelegate extends SliverPersistentHeaderDelegate {
  HomeHeaderSliverDelegate({required this.title, this.tags});

  final String title;
  final Widget? tags;

  static const double _topPadding = 14;
  static const double _bottomPadding = 8;
  static const double _titleExtent = 52;
  static const double _tagsGap = 20;
  static const double _tagsExtent = 52;

  double get _extent {
    var height = _topPadding + _titleExtent + _bottomPadding;
    if (tags != null) {
      height += _tagsGap + _tagsExtent;
    }
    return height;
  }

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
    final safeRight = MediaQuery.paddingOf(context).right;

    return ColoredBox(
      color: AppColors.scaffoldBackground,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          _topPadding,
          safeRight + 30,
          _bottomPadding,
        ),
        child: HomeHeader(title: title, tags: tags),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HomeHeaderSliverDelegate oldDelegate) {
    return title != oldDelegate.title || tags != oldDelegate.tags;
  }
}
