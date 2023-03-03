import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/cubit/invoice_list_cubit.dart';
import 'package:nannyplus/cubit/service_list_cubit.dart';
import 'package:nannyplus/data/model/invoice.dart';
import 'package:nannyplus/src/common/loading_indicator_list_view.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/invoice_form/invoice_form.dart';
import 'package:nannyplus/src/invoice_view/child_statement_view.dart';
import 'package:nannyplus/src/invoice_view/invoice_view.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/utils/date_format_extension.dart';
import 'package:nannyplus/utils/list_extensions.dart';
import 'package:nannyplus/utils/snack_bar_util.dart';

class InvoiceListTabView extends StatefulWidget {
  const InvoiceListTabView({
    super.key,
    required this.childId,
  });

  final int childId;

  @override
  State<InvoiceListTabView> createState() => _InvoiceListTabViewState();
}

class _InvoiceListTabViewState extends State<InvoiceListTabView> {
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
    required this.invoices,
    required this.childId,
    required this.showPaidInvoices,
    required this.onToggleShowPaidInvoices,
  });

  final List<Invoice> invoices;
  final int childId;
  final bool showPaidInvoices;
  final void Function(bool) onToggleShowPaidInvoices;

  @override
  Widget build(BuildContext context) {
    final i = invoices.groupBy<num>(
      (invoice) => DateFormat('yyyy-MM-dd').parse(invoice.date).year,
      groupComparator: (a, b) => b.compareTo(a),
    );

    Future<void> action() async {
      await Navigator.of(context).push(
        MaterialPageRoute<Invoice>(
          builder: (context) => InvoiceForm(childId: childId),
          fullscreenDialog: true,
        ),
      );
      await context.read<InvoiceListCubit>().loadInvoiceList(childId);
      await context.read<ServiceListCubit>().loadServices(childId);
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
    required this.group,
  });

  final Group<num, Invoice> group;

  @override
  Widget build(BuildContext context) {
    return UICard(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  group.key.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                onPressed: () => _openYearlyStatementPDF(context, group),
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

  void _openYearlyStatementPDF(
    BuildContext context,
    Group<num, Invoice> group,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ChildStatementView(
          group,
          GettextLocalizations.of(context),
        ),
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  const _InvoiceCard({
    required this.invoice,
  });

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8),
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
              padding: const EdgeInsets.only(right: 8),
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
                      final mark = await _showMarkPaidDialog(context);
                      if (mark ?? false) {
                        await context
                            .read<InvoiceListCubit>()
                            .markInvoiceAsPaid(
                              invoice,
                            );
                        await context
                            .read<ServiceListCubit>()
                            .loadServices(invoice.childId);
                        ScaffoldMessenger.of(context).success(
                          context.t('Invoice marked as paid'),
                        );
                      }
                      break;
                    case 2:
                      final delete = await _showConfirmationDialog(context);
                      if (delete ?? false) {
                        await context.read<InvoiceListCubit>().deleteInvoice(
                              invoice,
                            );
                        await context
                            .read<ServiceListCubit>()
                            .loadServices(invoice.childId);
                        ScaffoldMessenger.of(context).success(
                          context.t('Removed successfully'),
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
      MaterialPageRoute<void>(
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
          content: Text(
            context.t('Are you sure you want to mark this invoice as paid ?'),
          ),
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
