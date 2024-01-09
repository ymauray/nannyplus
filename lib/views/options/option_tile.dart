import 'package:flutter/material.dart';
import 'package:nannyplus/src/ui/ui_card.dart';

class OptionTile<T extends Widget> extends StatelessWidget {
  const OptionTile({
    required this.leading,
    required this.label,
    required this.destinationBuilder,
    super.key,
  });

  final Widget leading;
  final String label;
  final T Function() destinationBuilder;

  @override
  Widget build(BuildContext context) {
    final destination = destinationBuilder();
    return UICard(
      children: [
        GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => destination,
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
