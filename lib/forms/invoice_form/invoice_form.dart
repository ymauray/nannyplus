import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/forms/invoice_form/invoice_form_provider.dart';
import 'package:nannyplus/provider/children.dart';
//import 'package:nannyplus/cubit/invoice_form_cubit.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/snack_bar_util.dart';

class InvoiceForm extends ConsumerWidget {
  const InvoiceForm({
    required this.childId,
    super.key,
  });

  final int childId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //context.read<InvoiceFormCubit>().init(childId);
    final child = ref.watch(childInfoProvider(childId));
    final children = ref.watch(invoiceFormChildrenProvider(childId));

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
              //final ok = await context.read<InvoiceFormCubit>().createInvoice();
              final ok = await ref.read(invoiceFormChildrenProvider(childId).notifier).createInvoice();
              if (ok) {
                if (!Platform.isLinux && !Platform.isWindows) {
                  await FirebaseAnalytics.instance.logEvent(
                    name: 'invoice_created',
                  );
                }
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context)
                    .failure(context.t('There is no service to invoice'));
              }
            },
          ),
        ],
        persistentHeader: const UISliverCurvedPersistenHeader(child: Text('')),
        body: Builder(
          builder: (context) {
            return UIListView.fromChildren(
              children: [
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
                          child.when(
                            data: (child) => Expanded(
                              child: Text(child.displayName),
                            ),
                            loading: () => const Expanded(
                              child: CircularProgressIndicator(),
                            ),
                            error: (error, stackTrace) => Expanded(
                              child: Text(error.toString()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                children.when(
                  data: (children) => children.isNotEmpty
                      ? UICard(
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
                            ...children.map(
                              (c) => _Child(
                                formChild: c,
                                onPressed: () {
                                  ref
                                      .read(
                                        invoiceFormChildrenProvider(childId)
                                            .notifier,
                                      )
                                      .toggle(c);
                                },
                              ),
                            ),
                          ],
                        )
                      : UICard(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(kdMediumPadding),
                              child: Text(
                                context
                                    .t('No other child to add to the invoice'),
                              ),
                            ),
                          ],
                        ),
                  loading: () => UICard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(kdMediumPadding),
                        child: Text(
                          context.t('No other child to add to the invoice'),
                        ),
                      ),
                    ],
                  ),
                  error: (error, stackTrace) => UICard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(kdMediumPadding),
                        child: Text(error.toString()),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
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
