import 'package:flutter/material.dart';

class ExFormRow extends StatelessWidget {
  const ExFormRow({Key? key, required this.children})
      : assert(children.length > 0),
        super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    var _children = [children.first];
    children.skip(1).forEach((c) {
      _children
        ..add(const SizedBox(
          width: 16,
        ))
        ..add(c);
    });
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _children,
      ),
    );
  }
}
