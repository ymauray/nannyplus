import 'package:flutter/material.dart';

class CardScrollView extends StatelessWidget {
  final List<Widget> children;
  final double marginBottom;

  const CardScrollView({
    required this.children,
    this.marginBottom = 8.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = children.map<Widget>((w) {
      return Card(
        margin: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: w,
        ),
      );
    }).toList()
      ..add(
        SizedBox(
          height: marginBottom,
        ),
      );
    return Stack(
      children: [
        Container(
          color: const Color.fromARGB(0xff - 0xf4, 0, 0, 0),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: c,
          ),
        ),
      ],
    );
  }
}
