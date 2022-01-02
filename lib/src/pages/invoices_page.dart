import 'package:nannyplus/src/models/entry.dart';
import 'package:nannyplus/src/widgets/ex_forms/ex_form_row.dart';
import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../models/folder.dart';

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({Key? key, required this.folder, required this.entries})
      : super(key: key);

  final Folder folder;
  final Entries entries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(context.t("Invoices for {0}", args: ["${folder.firstName}"])),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ExFormRow(children: [
            Expanded(
              child: TextButton(
                child: Text(
                  context.t("Invoice pending entries"),
                ),
                onPressed: () {
                  entries.data.forEach(print);
                },
              ),
            ),
          ])
        ],
      ),
    );
  }
}
