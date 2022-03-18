import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';

import '../data/model/invoice.dart';
import '../utils/date_format_extension.dart';
import '../views/invoice_view.dart';
import 'bold_text.dart';

class InvoiceList extends StatelessWidget {
  final List<Invoice> invoices;
  const InvoiceList(this.invoices, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFirst = true;
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
              groupHeaderBuilder: (element) {
                var r = Padding(
                  padding: EdgeInsets.only(top: isFirst ? 0.0 : 24.0),
                  child: Text(
                    DateFormat('yyyy-MM-dd')
                        .parse(element.date)
                        .year
                        .toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                );
                isFirst = false;
                return r;
              },
              itemBuilder: (context, invoice) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(invoice.date.formatDate()),
                    ),
                    Text(invoice.total.toStringAsFixed(2)),
                    IconButton(
                      visualDensity: VisualDensity.compact,
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
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
