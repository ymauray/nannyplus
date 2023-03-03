import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

class UIListView extends StatelessWidget {
  const UIListView({
    super.key,
    required this.itemBuilder,
    this.itemCount,
    this.onFloatingActionPressed,
    this.horizontalPadding = 0,
    this.extraWidget,
  }) : children = null;
  const UIListView.fromChildren({
    super.key,
    required this.children,
    this.onFloatingActionPressed,
    this.horizontalPadding = 0,
  })  : itemBuilder = null,
        itemCount = 0,
        extraWidget = null;

  final IndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final VoidCallback? onFloatingActionPressed;
  final List<Widget>? children;
  final double? horizontalPadding;
  final Widget? extraWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(
            left: horizontalPadding!,
            right: horizontalPadding!,
            bottom: onFloatingActionPressed != null ? 80 : 0,
          ),
          itemBuilder: extraWidget != null
              ? _extraItemBuilder
              : itemBuilder ?? _itemBuilder,
          itemCount: itemBuilder == null
              ? children!.length
              : extraWidget != null
                  ? (itemCount! + 1)
                  : itemCount,
        ),
        if (onFloatingActionPressed != null)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FloatingActionButton(
                tooltip: context.t('Add Child'),
                onPressed: onFloatingActionPressed,
                child: const Icon(Icons.add),
              ),
            ),
          ),
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return children![index];
  }

  Widget _extraItemBuilder(BuildContext context, int index) {
    return index < itemCount!
        ? itemBuilder!.call(context, index)
        : extraWidget!;
  }
}
