import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../cubit/service_list_cubit.dart';
import '../data/model/service.dart';
import '../forms/service_form.dart';
import '../widgets/service_list.dart';

class ServiceListTabView extends StatelessWidget {
  final int childId;
  const ServiceListTabView(
    this.childId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ServiceListCubit>().loadServices(childId);

    return BlocConsumer<ServiceListCubit, ServiceListState>(
      listener: (context, state) {
        if (state is ServiceListError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.t('Error loading services')),
            ),
          );
        }
      },
      builder: (context, state) => state is ServiceListLoaded
          ? Stack(
              children: [
                ServiceList(child: state.child, services: state.services),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute<Service>(
                            builder: (context) => ServiceForm(
                              childId: state.child.id!,
                              tab: 0,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                        context.read<ServiceListCubit>().loadServices(childId);
                      },
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
