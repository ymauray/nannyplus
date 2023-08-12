import 'package:flutter/material.dart';

const _kDefaultSpacing = 12.0;
const _kDefaultHeight = kMinInteractiveDimension;

class UISliverCurvedPersistenHeader extends StatelessWidget {
  const UISliverCurvedPersistenHeader({
    this.child,
    this.height = _kDefaultHeight,
    this.spacing = _kDefaultSpacing,
    super.key,
  });

  final Widget? child;
  final double height;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _Delegate(
        child: child,
        height: height,
        spacing: spacing,
      ),
      pinned: true,
    );
  }
}

class _Delegate extends SliverPersistentHeaderDelegate {
  _Delegate({
    required this.height,
    required this.spacing,
    this.child,
  });

  final Widget? child;
  final double height;
  final double spacing;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final borderRadius = BorderRadius.vertical(
      bottom: Radius.elliptical(
        MediaQuery.of(context).size.width / 2,
        height / 2,
      ),
    );

    return Stack(
      children: [
        ColoredBox(
          color: Theme.of(context).colorScheme.background,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: Material(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Theme.of(context).colorScheme.primary,
              ),
              height: height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (child != null)
                    DefaultTextStyle(
                      style: Theme.of(context).appBarTheme.toolbarTextStyle ??
                          Theme.of(context).textTheme.bodyLarge!,
                      child: child!,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => height + spacing;

  @override
  double get minExtent => height + spacing;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
