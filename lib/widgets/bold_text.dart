import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String data;
  final TextAlign? textAlign;

  const BoldText(
    this.data, {
    this.textAlign,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
