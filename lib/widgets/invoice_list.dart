import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/utils/date_format_extension.dart';
import 'package:nannyplus/views/invoice_view.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';

import 'bold_text.dart';
import 'card_scroll_view.dart';
import 'invoice_list_header.dart';

class InvoiceList extends StatelessWidget {
  final List<Invoice> invoices;
  const InvoiceList(this.invoices, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GroupedListView<Invoice, int>(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              elements: invoices,
              groupBy: (element) =>
                  DateFormat('yyyy-MM-dd').parse(element.date).year,
              groupComparator: (value1, value2) => value2 - value1,
              groupHeaderBuilder: (element) => ListTile(
                title: BoldText(
                  DateFormat('yyyy-MM-dd').parse(element.date).year.toString(),
                ),
              ),
              itemBuilder: (context, invoice) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(invoice.date.formatDate())],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [Text(invoice.total.toStringAsFixed(2))],
                        ),
                      )
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.file_download),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => InvoiceView(
                              invoice, GettextLocalizations.of(context)),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
