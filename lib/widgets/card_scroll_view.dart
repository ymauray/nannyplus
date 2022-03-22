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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                ...children.map(
                  (e) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: e,
                    ),
                  ),
                ),
                if (bottomPadding != null)
                  SizedBox(
                    height: bottomPadding,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
