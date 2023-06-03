import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/invoice_form_cubit.dart';
import 'package:nannyplus/src/common/loading_indicator_list_view.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/snack_bar_util.dart';

class InvoiceForm extends StatelessWidget {
  const InvoiceForm({
    super.key,
    required this.childId,
  });

  final int childId;

  @override
  Widget build(BuildContext context) {
    context.read<InvoiceFormCubit>().init(childId);

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
              final ok = await context.read<InvoiceFormCubit>().createInvoice();
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
        body: BlocBuilder<InvoiceFormCubit, InvoiceFormState>(
          builder: (context, state) {
            return state is InvoiceFormLoaded
                ? UIListView.fromChildren(
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
                                Expanded(child: Text(state.child.displayName)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (state.children.isNotEmpty)
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
                            ...state.children.map(_Child.new),
                          ],
                        ),
                      if (state.children.isEmpty)
                        UICard(
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
                    ],
                  )
                : const LoadingIndicatorListView();
          },
        ),
      ),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child(
    this.formChild, {
    super.key,
  });

  final InvoiceFormChild formChild;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kdMediumPadding),
      child: Row(
        children: [
          Expanded(child: Text(formChild.child.displayName)),
          IconButton(
            onPressed: () {
              context.read<InvoiceFormCubit>().toggle(formChild);
            },
            icon: Icon(
              formChild.checked
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
