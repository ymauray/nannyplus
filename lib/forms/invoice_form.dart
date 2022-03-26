import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/invoice_form_cubit.dart';
import 'package:nannyplus/views/app_view.dart';
import 'package:nannyplus/widgets/card_scroll_view.dart';
import 'package:nannyplus/widgets/loading_indicator.dart';

import '../data/model/child.dart';

class InvoiceForm extends StatelessWidget {
  const InvoiceForm({
    required this.childId,
    Key? key,
  }) : super(key: key);

  final int childId;

  @override
  Widget build(BuildContext context) {
    context.read<InvoiceFormCubit>().init(childId);

    return BlocBuilder<InvoiceFormCubit, InvoiceFormState>(
      builder: (context, state) {
        return state is InvoiceFormLoaded
            ? _InvoiceForm(child: state.child, children: state.children)
            : const LoadingIndicator();
      },
    );
  }
}

class _InvoiceForm extends StatelessWidget {
  const _InvoiceForm({
    required this.child,
    required this.children,
    Key? key,
  }) : super(key: key);

  final Child child;
  final List<InvoiceFormChild> children;

  @override
  Widget build(BuildContext context) {
    return AppView(
      title: Text(context.t("Create invoice")),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.save,
            color: Colors.white,
          ),
          onPressed: () async {
            await context.read<InvoiceFormCubit>().createInvoice();
            Navigator.of(context).pop();
          },
        ),
      ],
      body: CardScrollView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t("Invoice for"),
              style: Theme.of(context).textTheme.caption,
            ),
            Row(children: [Expanded(child: Text(child.displayName))]),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t("Combined with"),
              style: Theme.of(context).textTheme.caption,
            ),
            ...children.map((child) => _Child(child)),
          ],
        ),
      ]),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
