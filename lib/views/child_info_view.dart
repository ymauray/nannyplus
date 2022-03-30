import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/forms/child_form.dart';

import '../cubit/child_info_cubit.dart';
import '../widgets/child_info.dart';

import 'app_view.dart';

class ChildInfoView extends StatelessWidget {
  final int childId;

  const ChildInfoView(
    this.childId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ChildInfoCubit>().read(childId);

    return BlocConsumer<ChildInfoCubit, ChildInfoState>(
      listener: (context, state) {
        if (state is ChildInfoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return AppView(
          title: state is ChildInfoLoaded
              ? Text(state.child.displayName)
              : Text(context.t('Loading...')),
          actions: [
            if (state is ChildInfoLoaded)
              IconButton(
                onPressed: () async {
                  var editedChild = await Navigator.of(context).push<Child>(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ChildForm(child: state.child),
                    ),
                  );
                  if (editedChild != null) {
                    context.read<ChildInfoCubit>().update(
                          editedChild.copyWith(
                            id: state.child.id,
                          ),
                        );
                  }
                },
                icon: const Icon(Icons.edit),
              ),
          ],
          body: state is ChildInfoLoaded
              ? ChildInfo(state.child)
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
