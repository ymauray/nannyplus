import 'package:flutter/material.dart';

class FloatingActionStack extends StatelessWidget {
  const FloatingActionStack({
    required this.child,
    required this.onPressed,
    super.key,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FloatingActionButton(
              onPressed: onPressed,
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
