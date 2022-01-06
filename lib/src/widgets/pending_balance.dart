import 'package:flutter/material.dart';
import 'package:nannyplus/src/models/entry.dart';

class PendingBalance extends StatelessWidget {
  const PendingBalance(this.entries, {Key? key}) : super(key: key);

  final Entries entries;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Pending balance : ${entries.total().toStringAsFixed(2)}",
      ),
    );
  }
}
