import 'package:flutter/material.dart';
import 'package:nannyplus/src/ui/ui_card.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    required this.leading,
    required this.label,
    required this.destination,
    super.key,
  });

  final Widget leading;
  final String label;
  final Widget Function() destination;

  @override
  Widget build(BuildContext context) {
    return UICard(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => destination(),
              ),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: ListTile(
            leading: leading,
            title: Text(label),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }
}
