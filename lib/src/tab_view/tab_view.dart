import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/child_info_cubit.dart';
import 'package:nannyplus/cubit/service_list_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/src/child_form/child_form.dart';
import 'package:nannyplus/src/tab_view/child_info_tab_view.dart';
import 'package:nannyplus/src/tab_view/invoice_list_tab_view.dart';
import 'package:nannyplus/src/tab_view/service_list_tab_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/sliver_tab_bar_peristant_header.dart';
import 'package:nannyplus/src/ui/view.dart';

class TabView extends StatelessWidget {
  const TabView(
    this.childId, {
    super.key,
  });

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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final state =
                  context.read<ChildInfoCubit>().state as ChildInfoLoaded;
              final child = state.child;
              final updatedChild = await Navigator.of(context).push<Child>(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) {
                    return ChildForm(child: child);
                  },
                ),
              );
              if (updatedChild != null) {
                await context
                    .read<ChildInfoCubit>()
                    .update(updatedChild.copyWith(id: child.id));
              }
            },
          ),
        ],
        persistentHeader: UISliverCurvedPersistenHeader(
          child: BlocBuilder<ServiceListCubit, ServiceListState>(
            builder: (context, state) => state is ServiceListLoaded
                ? Text(
                    '${context.t('Pending total')} : ${state.services.fold<double>(
                          0,
                          (previousValue, service) =>
                              previousValue + service.total,
                        ).toStringAsFixed(2)}',
                  )
                : Text(context.t('Loading...')),
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
          onTap: (index) {
            debugPrint(index.toString());
          },
        ),
        body: TabBarView(
          children: [
            ServiceListTabView(childId: childId),
            InvoiceListTabView(childId: childId),
            ChildInfoTabView(childId: childId),
          ],
        ),
      ),
    );
  }
}
