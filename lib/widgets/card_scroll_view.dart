import 'package:flutter/material.dart';

class CardScrollView extends StatelessWidget {
  const CardScrollView({
    required this.children,
    this.bottomPadding,
    this.onReorder,
    Key? key,
  }) : super(key: key);

  final List<Widget> children;
  final double? bottomPadding;
  final ReorderCallback? onReorder;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: Theme.of(context).cardTheme.copyWith(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
      ),
      child: Stack(
        children: [
          Container(
            color: const Color.fromARGB(0xff, 0xf0, 0xf0, 0xf0),
          ),
          if (onReorder == null)
            ListView.builder(
              itemCount:
                  children.length + 1 + ((bottomPadding != null) ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox(height: 4);
                } else if (index - 1 < children.length) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: children[index - 1],
                    ),
                  );
                } else {
                  return SizedBox(height: bottomPadding!);
                }
              },
            ),
          if (onReorder != null)
            ReorderableListView.builder(
              header: const SizedBox(height: 4),
              padding: EdgeInsets.only(bottom: bottomPadding ?? 0),
              itemCount: children.length,
              onReorder: onReorder!,
              itemBuilder: (context, index) {
                return Card(
                  key: ValueKey(index),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.reorder, color: Colors.grey),
                        ),
                        Expanded(child: children[index]),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
