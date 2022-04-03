import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../cubit/child_info_cubit.dart';
import '../cubit/invoice_list_cubit.dart';
import '../widgets/child_info.dart';

class ChildInfoTabView extends StatelessWidget {
  final int childId;
  const ChildInfoTabView(
    this.childId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ChildInfoCubit>().read(childId);

    return BlocConsumer<ChildInfoCubit, ChildInfoState>(
      listener: (context, state) {
        if (state is InvoiceListError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.t('Error loading invoices')),
            ),
          );
        }
      },
      builder: (context, state) => state is ChildInfoLoaded
          ? ChildInfo(state.child)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
