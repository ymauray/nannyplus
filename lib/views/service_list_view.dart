import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/views/invoice_list_view.dart';

import '../cubit/service_list_cubit.dart';
import '../data/model/service.dart';
import '../forms/service_form.dart';
import '../widgets/service_list.dart';

import 'app_view.dart';
import 'child_info_view.dart';

class ServiceListView extends StatelessWidget {
  final int childId;

  const ServiceListView(this.childId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ServiceListCubit>().loadServices(childId);
    return BlocConsumer<ServiceListCubit, ServiceListState>(
      listener: (context, state) {
        if (state is ServiceListError) {}
      },
      builder: (context, state) => AppView(
        title: Text(context.t('Services')),
        actions: [
          if (state is ServiceListLoaded)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: PopupMenuButton(
                itemBuilder: (context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 'create_invoice',
                    child: Text(context.t('Create invoice')),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'invoices',
                    child: Text(context.t('Invoices')),
                  ),
                  PopupMenuItem(
                    value: 'info',
                    child: Text(context.t('Info')),
                  ),
                ],
                onSelected: (value) async {
                  switch (value) {
                    case 'create_invoice':
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invoice created"),
                        ),
                      );
                      break;
                    case 'invoices':
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => InvoiceListView(state.child),
                        ),
                      );
                      break;
                    case 'info':
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChildInfoView(state.child.id!),
                        ),
                      );
                      context
                          .read<ServiceListCubit>()
                          .loadServices(state.child.id!);
                      break;
                  }
                },
              ),
            ),
        ],
        floatingActionButton: state is ServiceListLoaded
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                  var service = await Navigator.of(context).push(
                    MaterialPageRoute<Service>(
                      builder: (context) => ServiceForm(
                        childId: state.child.id!,
                      ),
                      fullscreenDialog: true,
                    ),
                  );
                  if (service != null) {
                    context.read<ServiceListCubit>().create(
                          service,
                          state.child.id!,
                        );
                  }
                },
              )
            : null,
        body: state is ServiceListLoaded
            ? ServiceList(
                services: state.services,
                child: state.child,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
