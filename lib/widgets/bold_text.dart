import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String data;
  const BoldText(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
