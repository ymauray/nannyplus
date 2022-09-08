import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';
import 'package:intl/intl.dart';

import '../../cubit/invoice_list_cubit.dart';
import '../../cubit/service_list_cubit.dart';
import '../../data/model/invoice.dart';
import '../../src/constants.dart';
import '../../src/ui/ui_card.dart';
import '../../utils/date_format_extension.dart';
import '../../utils/list_extensions.dart';
import '../../utils/snack_bar_util.dart';
import '../common/loading_indicator_list_view.dart';
import '../invoice_form/invoice_form.dart';
import '../invoice_view/invoice_view.dart';
import '../ui/list_view.dart';

class NewInvoiceListTabView extends StatefulWidget {
  const NewInvoiceListTabView({
    Key? key,
    required this.childId,
  }) : super(key: key);

  final int childId;

  @override
  State<NewInvoiceListTabView> createState() => _NewInvoiceListTabViewState();
}

class _NewInvoiceListTabViewState extends State<NewInvoiceListTabView> {
  bool showPaidInvoices = false;

  @override
  Widget build(BuildContext context) {
    context
        .read<InvoiceListCubit>()
        .loadInvoiceList(widget.childId, loadPaidInvoices: showPaidInvoices);

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
            ? _List(
                invoices: state.invoices,
                childId: widget.childId,
                showPaidInvoices: showPaidInvoices,
                onToggleShowPaidInvoices: (showHiddenInvoices) {
                  setState(() {
                    showPaidInvoices = showHiddenInvoices;
                  });
                },
              )
            : const LoadingIndicatorListView();
      },
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    Key? key,
    required this.invoices,
    required this.childId,
    required this.showPaidInvoices,
    required this.onToggleShowPaidInvoices,
  }) : super(key: key);

  final List<Invoice> invoices;
  final int childId;
  final bool showPaidInvoices;
  final Function(bool) onToggleShowPaidInvoices;

  @override
  Widget build(BuildContext context) {
    var i = invoices.groupBy<int>(
      (invoice) => DateFormat('yyyy-MM-dd').parse(invoice.date).year,
      groupComparator: (a, b) => b.compareTo(a),
    );

    void action() async {
      await Navigator.of(context).push(
        MaterialPageRoute<Invoice>(
          builder: (context) => NewInvoiceForm(childId: childId),
          fullscreenDialog: true,
        ),
      );
      context.read<InvoiceListCubit>().loadInvoiceList(childId);
      context.read<ServiceListCubit>().loadServices(childId);
    }

    final extraWidget = TextButton(
      onPressed: () {
        onToggleShowPaidInvoices(!showPaidInvoices);
      },
      child: Text(
        context
            .t(showPaidInvoices ? 'Hide paid invoices' : 'Show paid invoices'),
      ),
    );

    return invoices.isNotEmpty
        ? UIListView(
            itemBuilder: (context, index) {
              return _GroupCard(
                group: i[index],
              );
            },
            itemCount: i.length,
            extraWidget: extraWidget,
            onFloatingActionPressed: action,
          )
        : UIListView.fromChildren(
            onFloatingActionPressed: action,
            children: [
              UICard(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(kdMediumPadding),
                    child: Text(context.t('No open invoice found')),
                  ),
                ],
              ),
              extraWidget,
            ],
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
              child: Text(
                invoice.date.formatDate(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontStyle: invoice.paid == 1
                          ? FontStyle.italic
                          : FontStyle.normal,
                    ),
              ),
              onTap: () => openPDF(context),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                invoice.total.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontStyle: invoice.paid == 1
                          ? FontStyle.italic
                          : FontStyle.normal,
                    ),
              ),
            ),
            onTap: () => openPDF(context),
          ),
          Row(
            children: [
              PopupMenuButton(
                onSelected: (value) async {
                  switch (value) {
                    case 1:
                      var mark = await _showMarkPaidDialog(context);
                      if (mark ?? false) {
                        context.read<InvoiceListCubit>().markInvoiceAsPaid(
                              invoice,
                            );
                        context
                            .read<ServiceListCubit>()
                            .loadServices(invoice.childId);
                        ScaffoldMessenger.of(context).success(
                          context.t("Invoice marked as paid"),
                        );
                      }
                      break;
                    case 2:
                      var delete = await _showConfirmationDialog(context);
                      if (delete ?? false) {
                        context.read<InvoiceListCubit>().deleteInvoice(
                              invoice,
                            );
                        context
                            .read<ServiceListCubit>()
                            .loadServices(invoice.childId);
                        ScaffoldMessenger.of(context).success(
                          context.t("Removed successfully"),
                        );
                      }
                  }
                },
                padding: EdgeInsets.zero,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 1,
                      enabled: invoice.paid == 0,
                      child: ListTile(
                        leading: const Icon(
                          Icons.savings_outlined,
                          color: kcAlmostBlack,
                        ),
                        title: Text(
                          context.t('Mark as paid'),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      enabled: invoice.paid == 0,
                      child: ListTile(
                        leading: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                        ),
                        title: Text(
                          context.t('Delete'),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ];
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

  Future<bool?> _showMarkPaidDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.t('Mark as paid')),
          content: Text(context
              .t('Are you sure you want to mark this invoice as paid ?')),
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
