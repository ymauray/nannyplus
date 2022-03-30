import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  const CardTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (leading != null) leading!,
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [title, if (subtitle != null) subtitle!],
                ),
                onTap: onTap,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ],
    );
  }
}
