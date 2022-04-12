import 'package:flutter/material.dart';

class UIListView extends StatelessWidget {
  const UIListView.fromChildren({
    Key? key,
    required this.children,
    this.onFloatingActionPressed,
    this.horizontalPadding = 0,
  })  : itemBuilder = null,
        itemCount = 0,
        super(key: key);

  const UIListView({
    Key? key,
    required this.itemBuilder,
    this.itemCount,
    this.onFloatingActionPressed,
    this.horizontalPadding = 0,
  })  : children = null,
        super(key: key);

  final IndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final VoidCallback? onFloatingActionPressed;
  final List<Widget>? children;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(
            top: 0,
            left: horizontalPadding!,
            right: horizontalPadding!,
            bottom: onFloatingActionPressed != null ? 80 : 0,
          ),
          itemBuilder: itemBuilder ?? _itemBuilder,
          itemCount: itemBuilder == null ? children!.length : itemCount,
        ),
        if (onFloatingActionPressed != null)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: onFloatingActionPressed,
              ),
            ),
          ),
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return children![index];
  }
}
