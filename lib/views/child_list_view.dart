import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/child_list_cubit.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/forms/child_form.dart';
import 'package:nannyplus/views/app_view.dart';
import 'package:nannyplus/widgets/child_list.dart';
import 'package:nannyplus/widgets/loading_indicator.dart';
import 'package:nannyplus/widgets/main_drawer.dart';

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
      //floatingActionButton: FloatingActionButton(
      //  child: const Icon(Icons.add),
      //  onPressed: () async {
      //    var child = await Navigator.of(context).push<Child>(
      //      MaterialPageRoute(
      //        builder: (context) => const ChildForm(),
      //      ),
      //    );
      //    if (child != null) {
      //      context.read<ChildListCubit>().create(child);
      //    }
      //  },
      //),
      body: BlocConsumer<ChildListCubit, ChildListState>(
        listener: (context, state) {
          if (state is ChildListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ChildListInitial) {
            return const LoadingIndicator();
          } else if (state is ChildListLoaded) {
            return Stack(
              children: [
                ChildList(state.children, state.pendingTotal,
                    state.pendingTotalPerChild),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () async {
                        var child = await Navigator.of(context).push<Child>(
                          MaterialPageRoute(
                            builder: (context) => const ChildForm(),
                          ),
                        );
                        if (child != null) {
                          context.read<ChildListCubit>().create(child);
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
