import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../cubit/invoice_list_cubit.dart';
import '../data/model/invoice.dart';
import '../forms/invoice_form.dart';
import '../widgets/floating_action_stack.dart';
import '../widgets/invoice_list.dart';

class InvoiceListTabView extends StatelessWidget {
  const InvoiceListTabView(
    this.childId, {
    Key? key,
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
      builder: (context, state) => state is InvoiceListLoaded
          ? FloatingActionStack(
              child: InvoiceList(state.invoices),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute<Invoice>(
                    builder: (context) => InvoiceForm(childId: childId),
                    fullscreenDialog: true,
                  ),
                );
                context.read<InvoiceListCubit>().loadInvoiceList(childId);
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
