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
  const InvoiceList(
    this.invoices, {
    Key? key,
  }) : super(key: key);

  final List<Invoice> invoices;

  @override
  Widget build(BuildContext context) {
    var i = invoices.groupBy<int>(
      (invoice) => DateFormat('yyyy-MM-dd').parse(invoice.date).year,
      groupComparator: (a, b) => b.compareTo(a),
    );

    return CardScrollView(
      bottomPadding: 80,
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
                  (invoice) => _InvoiceCard(
                    invoice: invoice,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  const _InvoiceCard({
    required this.invoice,
    Key? key,
  }) : super(key: key);

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: Text(invoice.date.formatDate())),
          Text(invoice.total.toStringAsFixed(2)),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.file_download, color: Colors.grey),
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
    );
  }
}
