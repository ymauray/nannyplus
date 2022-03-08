import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nannyplus/cubit/child_list_cubit.dart';
import 'package:nannyplus/views/app_view.dart';
import 'package:nannyplus/widgets/child_list.dart';
import 'package:nannyplus/widgets/loading_indicator.dart';

class ChildListView extends StatelessWidget {
  const ChildListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ChildListCubit>().getChildList();
    return AppView(
      title: const Text("Nanny+"),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {},
      ),
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
            return ChildList(state.children);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
