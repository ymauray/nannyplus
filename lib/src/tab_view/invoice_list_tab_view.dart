import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';
import 'package:intl/intl.dart';

import '../../cubit/invoice_list_cubit.dart';
import '../../data/model/invoice.dart';
import '../../src/ui/ui_card.dart';
import '../../utils/date_format_extension.dart';
import '../../utils/list_extensions.dart';
import '../../utils/snack_bar_util.dart';
import '../../views/invoice_view.dart';
import '../common/loading_indicator_list_view.dart';
import '../ui/list_view.dart';

class NewInvoiceListTabView extends StatelessWidget {
  const NewInvoiceListTabView({
    Key? key,
    required this.childId,
  }) : super(key: key);

  final int childId;

  @override
  Widget build(BuildContext context) {
    context.read<InvoiceListCubit>().loadInvoiceList(childId);

    return BlocConsumer<InvoiceListCubit, InvoiceListState>(
      listener: (context, state) {
        if (state is InvoiceListError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.t('Error loading invoices')),
            ),
          );
        }
      },
      builder: (context, state) {
        return state is InvoiceListLoaded
            ? _List(invoices: state.invoices)
            : const LoadingIndicatorListView();
      },
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    Key? key,
    required this.invoices,
  }) : super(key: key);

  final List<Invoice> invoices;

  @override
  Widget build(BuildContext context) {
    var i = invoices.groupBy<int>(
      (invoice) => DateFormat('yyyy-MM-dd').parse(invoice.date).year,
      groupComparator: (a, b) => b.compareTo(a),
    );

    return UIListView(
      itemBuilder: (context, index) {
        return _GroupCard(
          group: i[index],
        );
      },
      itemCount: i.length,
      onFloatingActionPressed: () {},
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group<int, Invoice> group;

  @override
  Widget build(BuildContext context) {
    return UICard(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  group.key.toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
        const Divider(
          height: 2,
        ),
        ...group.value.map(
          (invoice) => _InvoiceCard(
            invoice: invoice,
          ),
        ),
      ],
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  const _InvoiceCard({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Text(invoice.date.formatDate()),
              onTap: () => openPDF(context),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(invoice.total.toStringAsFixed(2)),
            ),
            onTap: () => openPDF(context),
          ),
          Row(
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () async {
                  var delete = await _showConfirmationDialog(context);
                  if (delete ?? false) {
                    //var childId = invoice.childId;
                    context.read<InvoiceListCubit>().deleteInvoice(invoice);
                    ScaffoldMessenger.of(context).success(
                      context.t("Removed successfully"),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void openPDF(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InvoiceView(
          invoice,
          GettextLocalizations.of(context),
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.t('Delete')),
          content:
              Text(context.t('Are you sure you want to delete this invoice ?')),
          actions: [
            TextButton(
              child: Text(context.t('Yes')),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: Text(context.t('No')),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
