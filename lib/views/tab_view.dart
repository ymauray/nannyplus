import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../cubit/child_info_cubit.dart';
import '../views/app_view.dart';
import 'child_info_tab_view.dart';
import 'invoice_list_tab_view.dart';
import 'service_list_tab_view.dart';

class TabView extends StatelessWidget {
  final int childId;
  const TabView(this.childId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ChildInfoCubit>().read(childId);

    return DefaultTabController(
      length: 3,
      child: AppView(
        title: BlocBuilder<ChildInfoCubit, ChildInfoState>(
          builder: (context, state) => state is ChildInfoLoaded
              ? Text(state.child.displayName)
              : Text(context.t('Loading...')),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () => {}),
        ],
        tabBar: TabBar(
          tabs: [
            Tab(text: context.t('Services')),
            Tab(text: context.t('Invoices')),
            Tab(text: context.t('Info')),
          ],
          labelStyle: Theme.of(context).primaryTextTheme.bodyText1!.copyWith(
                fontSize: 16,
              ),
        ),
        body: TabBarView(children: [
          ServiceListTabView(childId),
          InvoiceListTabView(childId),
          ChildInfoTabView(childId),
        ]),
      ),
    );
  }
}
