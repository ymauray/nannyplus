import 'package:flutter/material.dart';

const _kDefaultSpacing = 12.0;

class UISliverTabBarPeristantHeader extends StatelessWidget {
  const UISliverTabBarPeristantHeader({
    required this.tabBar,
    this.padding,
    this.onTap,
    super.key,
  });

  final double? padding;
  final TabBar tabBar;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _Delegate(tabBar: tabBar, onTap: onTap, padding: padding),
      pinned: true,
    );
  }
}

class _Delegate extends SliverPersistentHeaderDelegate {
  _Delegate({
    required this.tabBar,
    this.padding,
    this.onTap,
  });

  final double? padding;
  final TabBar tabBar;
  final ValueChanged<int>? onTap;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return DecoratedBox(
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Padding(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: padding ?? _kDefaultSpacing,
        ),
        //child: TabBar(
        //  tabs: children ?? [],
        //  onTap: onTap,
        //),
        child: tabBar,
      ),
    );
  }

  @override
  double get maxExtent =>
      tabBar.preferredSize.height; //48 + (padding ?? kdMediumPadding);

  @override
  double get minExtent =>
      tabBar.preferredSize.height; // 48 + (padding ?? kdMediumPadding);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
