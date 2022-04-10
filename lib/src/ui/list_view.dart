import 'package:flutter/material.dart';

class UIListView extends StatelessWidget {
  const UIListView({
    Key? key,
    required this.itemBuilder,
    this.itemCount,
    this.onFloatingActionPressed,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int? itemCount;
  final VoidCallback? onFloatingActionPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(
            top: 0,
            bottom: onFloatingActionPressed != null ? 80 : 0,
          ),
          itemBuilder: itemBuilder,
          itemCount: itemCount,
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
}
