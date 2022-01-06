import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/src/widgets/pending_balance.dart';
import 'package:provider/provider.dart';

import '../models/entry.dart';
import '../widgets/child_name_app_bar_title.dart';
import '../widgets/ex_forms/ex_form_row.dart';
import '../models/folder.dart';

class InvoicesPage extends StatelessWidget {
  const InvoicesPage(
      {Key? key, required this.folder /*, required this.entries*/})
      : super(key: key);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    var entries = context.read<Entries>();
    return Scaffold(
      appBar: AppBar(
        title: ChildNameAppBarTitle(folder),
      ),
      body: Column(
        children: [
          PendingBalance(entries),
          ExFormRow(children: [
            Expanded(
              child: TextButton(
                child: Text(
                  context.t("Invoice pending entries"),
                ),
                onPressed: () {
                  //entries.data.forEach(print);
                },
              ),
            ),
          ])
        ],
      ),
    );
  }
}
