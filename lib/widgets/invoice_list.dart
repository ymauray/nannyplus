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
import 'invoice_list_header.dart';

class InvoiceList extends StatelessWidget {
  final List<Invoice> invoices;
  final Child child;
  const InvoiceList(this.invoices, this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                child.displayName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const Divider(),
            const InvoiceListHeader(),
            GroupedListView<Invoice, int>(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              elements: invoices,
              groupBy: (element) =>
                  DateFormat('yyyy-MM-dd').parse(element.date).year,
              groupComparator: (value1, value2) => value2 - value1,
              groupHeaderBuilder: (element) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 2,
                      child: BoldText(
                        DateFormat('yyyy-MM-dd')
                            .parse(element.date)
                            .year
                            .toString(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              itemBuilder: (context, invoice) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(invoice.number.toString()),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(invoice.date.formatDate()),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(invoice.total.toStringAsFixed(2)),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.file_download),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => InvoiceView(invoice,
                                    child, GettextLocalizations.of(context)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
