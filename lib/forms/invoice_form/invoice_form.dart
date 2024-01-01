import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/forms/invoice_form/invoice_form_provider.dart';
//import 'package:nannyplus/cubit/invoice_form_cubit.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/src/ui/view.dart';

class InvoiceForm extends ConsumerWidget {
  const InvoiceForm({
    required this.childId,
    super.key,
  });

  final int childId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //context.read<InvoiceFormCubit>().init(childId);
    //final child = ref.watch(childInfoProvider(childId));
    //final children = ref.watch(invoiceFormChildrenProvider(childId));
    final invoiceFormState = ref.watch(invoiceFormProvider(childId));

    final formKey = GlobalKey<FormBuilderState>();

    return FormBuilder(
      key: formKey,
      child: UIView(
        title: Text(context.t('Create invoice')),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () async {
              if (invoiceFormState.asData!.value.selectedMonth != null) {
                final ok = await ref
                    .read(invoiceFormProvider(childId).notifier)
                    .createInvoice();
                if (ok) {
                  if (!Platform.isLinux && !Platform.isWindows) {
                    await FirebaseAnalytics.instance.logEvent(
                      name: 'invoice_created',
                    );
                  }
                }
              }
              Navigator.of(context).pop();
            },
          ),
        ],
        persistentHeader: const UISliverCurvedPersistenHeader(child: Text('')),
        body: invoiceFormState.when(
          loading: () => const Expanded(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Expanded(
            child: Text(error.toString()),
          ),
          data: (formState) => UIListView.fromChildren(
            children: [
              if (formState.selectedMonth == null)
                UICard(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kdMediumPadding),
                      child: Text(
                        context.t('Nothing to invoice'),
                      ),
                    ),
                  ],
                ),
              if (formState.selectedMonth != null)
                UICard(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kdMediumPadding,
                        top: kdMediumPadding,
                        right: kdMediumPadding,
                      ),
                      child: Text(
                        context.t('Invoice for'),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kdMediumPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(formState.child.displayName),
                          ),
                          DropdownButton(
                            value: formState.selectedMonth,
                            items: formState.months
                                .map(
                                  (month) => DropdownMenuItem(
                                    value: month,
                                    child: Text(
                                      DateFormat('MMMM yyyy').format(
                                        DateFormat('yyyy-MM').parse(month),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              ref
                                  .read(
                                    invoiceFormProvider(childId).notifier,
                                  )
                                  .selectMonth(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (formState.selectedMonth != null)
                if (formState.children.isNotEmpty)
                  UICard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: kdMediumPadding,
                          top: kdMediumPadding,
                          right: kdMediumPadding,
                        ),
                        child: Text(
                          context.t('Combined with'),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      ...formState.children.map(
                        (c) => _Child(
                          formChild: c,
                          onPressed: () {
                            ref
                                .read(
                                  invoiceFormProvider(childId).notifier,
                                )
                                .toggle(c);
                          },
                        ),
                      ),
                    ],
                  )
                else
                  UICard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(kdMediumPadding),
                        child: Text(
                          context.t('No other child to add to the invoice'),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Child extends ConsumerWidget {
  const _Child({
    required this.formChild,
    required this.onPressed,
  });

  //final InvoiceFormChild formChild;
  final InvoiceFormChild formChild;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kdMediumPadding),
      child: Row(
        children: [
          Expanded(child: Text(formChild.child.displayName)),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              formChild.selected
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
