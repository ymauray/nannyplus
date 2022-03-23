import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/invoice_list_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/views/app_view.dart';
import 'package:nannyplus/widgets/invoice_list.dart';

class InvoiceListView extends StatelessWidget {
  final Child child;
  const InvoiceListView(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<InvoiceListCubit>().loadInvoiceList(child.id!);

    return AppView(
      title: Text(
        context.t('Invoices'),
      ),
      body: BlocBuilder<InvoiceListCubit, InvoiceListState>(
        builder: (context, state) {
          return state is InvoiceListLoaded
              ? InvoiceList(state.invoices)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
