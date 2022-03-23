import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';

import '../data/model/invoice.dart';
import '../utils/date_format_extension.dart';
import '../utils/list_extensions.dart';
import '../views/invoice_view.dart';
import '../widgets/card_scroll_view.dart';

class InvoiceList extends StatelessWidget {
  final List<Invoice> invoices;
  const InvoiceList(this.invoices, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var i = invoices.groupBy<int>(
      (invoice) => DateFormat('yyyy-MM-dd').parse(invoice.date).year,
      groupComparator: (a, b) => b.compareTo(a),
    );

    return CardScrollView(
      children: i
          .map(
            (group) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.key.toString(),
                  style: const TextStyle(
                    inherit: true,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                ...group.value.map(
                  (invoice) => Row(
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
                                invoice,
                                GettextLocalizations.of(context),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
