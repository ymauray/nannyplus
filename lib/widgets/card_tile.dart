import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  const CardTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.expandGestureDetector = true,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool expandGestureDetector;

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
                onTap: onTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [title, if (subtitle != null) subtitle!],
                ),
              ),
            ),
            if (trailing != null)
              expandGestureDetector
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onTap,
                      child: trailing!,
                    )
                  : trailing!,
          ],
        ),
      ],
    );
  }
}
