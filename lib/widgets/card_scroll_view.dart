import 'package:flutter/material.dart';

class CardScrollView extends StatelessWidget {
  final List<Widget> children;
  final double? bottomPadding;
  const CardScrollView({
    required this.children,
    this.bottomPadding,
    Key? key,
  }) : super(key: key);

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
          ListView.builder(
            itemCount: children.length + 1 + ((bottomPadding != null) ? 1 : 0),
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
        ],
      ),
    );
  }
}
