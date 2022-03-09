import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/service_list_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/widgets/service_list.dart';

import 'app_view.dart';
import '../forms/service_form.dart';

class ServiceListView extends StatelessWidget {
  final Child child;

  const ServiceListView(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ServiceListCubit>().loadServices(child);
    return AppView(
      title: Text(context.t("Services")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var service = await Navigator.of(context).push(
            MaterialPageRoute<Service>(
              builder: (context) => const ServiceForm(),
              fullscreenDialog: true,
            ),
          );
          if (service != null) {
            context.read<ServiceListCubit>().create(service, child);
          }
        },
      ),
      body: BlocConsumer<ServiceListCubit, ServiceListState>(
        listener: (context, state) {
          if (state is ServiceListError) {}
        },
        builder: (context, state) {
          if (state is ServiceListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ServiceListLoaded) {
            return ServiceList(
              services: state.services,
              child: child,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
