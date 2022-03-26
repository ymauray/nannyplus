import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../cubit/child_list_cubit.dart';
import '../data/model/child.dart';
import '../forms/child_form.dart';
import '../widgets/child_list.dart';
import '../widgets/floating_action_stack.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/main_drawer.dart';

import 'app_view.dart';

class ChildListView extends StatelessWidget {
  const ChildListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ChildListCubit>().loadChildList();

    return AppView(
      title: const Text("Nanny+"),
      actions: [
        BlocBuilder<ChildListCubit, ChildListState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  if (!state.showArchivedItems)
                    PopupMenuItem(
                      value: 'show_archived_items',
                      child: Text(context.t('Show archived items')),
                    ),
                  if (state.showArchivedItems)
                    PopupMenuItem(
                      value: 'hide_archived_items',
                      child: Text(context.t('Hide archived items')),
                    ),
                ],
                onSelected: (value) async {
                  if (value == 'show_archived_items') {
                    context.read<ChildListCubit>().showArchivedItems();
                  } else if (value == 'hide_archived_items') {
                    context.read<ChildListCubit>().hideArchivedItems();
                  }
                },
              ),
            );
          },
        ),
      ],
      drawer: const MainDrawer(),
      body: BlocConsumer<ChildListCubit, ChildListState>(
        listener: (context, state) {
          if (state is ChildListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ChildListInitial) {
            return const LoadingIndicator();
          } else if (state is ChildListLoaded) {
            return FloatingActionStack(
              child: ChildList(
                state.children,
                state.pendingTotal,
                state.pendingTotalPerChild,
              ),
              onPressed: () async {
                var child = await Navigator.of(context).push<Child>(
                  MaterialPageRoute(builder: (context) => const ChildForm()),
                );
                if (child != null) {
                  context.read<ChildListCubit>().create(child);
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
