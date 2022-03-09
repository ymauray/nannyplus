import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/prestation_list_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/prestation.dart';
import 'package:nannyplus/widgets/prestation_list.dart';

import 'app_view.dart';
import 'prestation_form.dart';

class PrestationListView extends StatelessWidget {
  final Child child;

  const PrestationListView(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PrestationListCubit>().getPrestations(child);
    return AppView(
      title: Text(context.t("Prestations")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var prestation = await Navigator.of(context).push(
            MaterialPageRoute<Prestation>(
              builder: (context) => const PrestationForm(),
              fullscreenDialog: true,
            ),
          );
          if (prestation != null) {
            context.read<PrestationListCubit>().create(prestation, child);
          }
        },
      ),
      body: BlocConsumer<PrestationListCubit, PrestationListState>(
        listener: (context, state) {
          if (state is PrestationListError) {}
        },
        builder: (context, state) {
          if (state is PrestationListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PrestationListLoaded) {
            return PrestationList(
              prestations: state.prestations,
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
