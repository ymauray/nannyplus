import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/widgets/invoice_list.dart';

import '../cubit/invoice_list_cubit.dart';

class InvoiceListTabView extends StatelessWidget {
  final int childId;
  const InvoiceListTabView(
    this.childId, {
    Key? key,
  }) : super(key: key);

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
          ? InvoiceList(state.invoices)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
