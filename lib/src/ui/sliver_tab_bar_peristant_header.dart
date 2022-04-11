import 'package:flutter/material.dart';

const _kDefaultSpacing = 12.0;

class UISliverTabBarPeristantHeader extends StatelessWidget {
  const UISliverTabBarPeristantHeader({
    this.padding,
    //this.children,
    required this.tabBar,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final double? padding;
  //final List<Widget>? children;
  final TabBar tabBar;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _Delegate(
        //children: children,
        tabBar: tabBar,
        onTap: onTap,
      ),
      pinned: true,
    );
  }
}

class _Delegate extends SliverPersistentHeaderDelegate {
  _Delegate({
    this.padding,
    //this.children,
    required this.tabBar,
    this.onTap,
  });

  final double? padding;
  //final List<Widget>? children;
  final TabBar tabBar;
  final ValueChanged<int>? onTap;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
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
