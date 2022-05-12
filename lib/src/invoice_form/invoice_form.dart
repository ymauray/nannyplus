import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../../cubit/invoice_form_cubit.dart';
import '../../src/common/loading_indicator_list_view.dart';
import '../../src/constants.dart';
import '../../src/ui/list_view.dart';
import '../../src/ui/sliver_curved_persistent_header.dart';
import '../../src/ui/ui_card.dart';
import '../../src/ui/view.dart';
import '../../utils/snack_bar_util.dart';

class NewInvoiceForm extends StatelessWidget {
  const NewInvoiceForm({
    Key? key,
    required this.childId,
  }) : super(key: key);

  final int childId;

  @override
  Widget build(BuildContext context) {
    context.read<InvoiceFormCubit>().init(childId);

    final _formKey = GlobalKey<FormBuilderState>();

    return FormBuilder(
      key: _formKey,
      initialValue: const {},
      child: UIView(
        title: Text(context.t("Create invoice")),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () async {
              var ok = await context.read<InvoiceFormCubit>().createInvoice();
              if (ok) {
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context)
                    .failure(context.t("There is no service to invoice"));
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
                              context.t("Invoice for"),
                              style: Theme.of(context).textTheme.caption,
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
                                context.t("Combined with"),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            ...state.children.map((child) => _Child(child)),
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
    Key? key,
  }) : super(key: key);

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
