import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/src/models/invoice.dart';
import 'package:provider/provider.dart';
import '../models/entry.dart';
import '../models/rates.dart';
import '../models/folder.dart';
import '../widgets/ex_forms/ex_form_row.dart';
import '../widgets/ex_forms/ex_text_field.dart';

class ImportPage extends StatelessWidget {
  const ImportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? _json;

    return Consumer<Folders>(
      builder: (context, folders, _) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            context.t("Import data"),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Column(
              children: [
                ExFormRow(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ExTextField(
                        label: Text(
                          context.t("JSON"),
                        ),
                        maxLines: 25,
                        onSaved: (value) {
                          _json = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                ExFormRow(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          _formKey.currentState!.save();
                          var rates = context.read<Rates>();
                          // Read JSON
                          Map<String, dynamic> jsonData = jsonDecode(_json!);

                          // Iterate of children in json file
                          var children = jsonData['children'] as List;
                          for (var child in children) {
                            // Create a folder from json data
                            var folder = await folders
                                .createFolder(Folder.fromJson(child));

                            // Create invoices from json data, mapping them to newly created folder
                            // Also create a map of old ids => new ids
                            var idMap = <int, int>{};
                            var invoices = Invoices.load(folder);
                            var invoicesData = child['_invoices'] as List;
                            for (var invoiceData in invoicesData) {
                              var invoice = Invoice.fromJson(invoiceData);
                              var oldId = invoice.id!;
                              invoice = await invoices.createInvoice(invoice);
                              idMap[oldId] = invoice.id!;
                            }

                            // Create entries from json data, mapping old invoice ids to new ones
                            var entries = Entries.load(folder);
                            var entriesData = child['_entries'] as List;
                            for (var entryData in entriesData) {
                              var entry =
                                  rates.createEntryFromJson(entryData, true);
                              entry.invoiceId =
                                  idMap[int.tryParse(entryData['invoiceId'])!];
                              entry = await entries.createEntry(entry);
                            }
                          }
                        },
                        child: Text(
                          context.t("Import"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
