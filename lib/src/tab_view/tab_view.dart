import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/service_list_cubit.dart';
import 'package:nannyplus/src/tab_view/service_list_tab_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/sliver_tab_bar_peristant_header.dart';

import '../../cubit/child_info_cubit.dart';
import '../../src/ui/view.dart';
import 'child_info_tab_view.dart';
import 'invoice_list_tab_view.dart';

class NewTabView extends StatelessWidget {
  const NewTabView(
    this.childId, {
    Key? key,
  }) : super(key: key);

  final int childId;

  @override
  Widget build(BuildContext context) {
    context.read<ChildInfoCubit>().read(childId);
    context.read<ServiceListCubit>().loadServices(childId);

    return DefaultTabController(
      length: 3,
      child: UIView(
        title: BlocBuilder<ChildInfoCubit, ChildInfoState>(
          builder: (context, state) => state is ChildInfoLoaded
              ? Text(state.child.displayName)
              : Text(context.t('Loading...')),
        ),
        persistentHeader: UISliverCurvedPersistenHeader(
          child: BlocBuilder<ServiceListCubit, ServiceListState>(
            builder: (context, state) => state is ServiceListLoaded
                ? Text(
                    context.t('Pending total') +
                        ' : ' +
                        state.services
                            .fold<double>(
                              0.0,
                              (previousValue, service) =>
                                  previousValue + service.total,
                            )
                            .toStringAsFixed(2),
                  )
                : Text(context.t("Loading...")),
          ),
        ),
        persistentTabBar: UISliverTabBarPeristantHeader(
          tabBar: TabBar(
            tabs: [
              Tab(text: context.t('Services')),
              Tab(text: context.t('Invoices')),
              Tab(text: context.t('Info')),
            ],
          ),
          //children: [
          //  Tab(text: context.t('Services')),
          //  Tab(text: context.t('Invoices')),
          //  Tab(text: context.t('Info')),
          //],
          onTap: (index) {
            print(index);
          },
        ),
        body: TabBarView(
          children: [
            //ListView.builder(
            //  padding: EdgeInsets.zero,
            //  itemBuilder: (context, index) => ListTile(
            //    title: Text("Tab 1, Child $index"),
            //  ),
            //),
            NewServiceListTabView(childId: childId),
            NewInvoiceListTabView(childId: childId),
            NewChildInfoTabView(childId: childId),
          ],
        ),
      ),
    );
  }
}