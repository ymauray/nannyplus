import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../cubit/child_list_cubit.dart';
import '../data/model/child.dart';
import '../forms/child_form.dart';
import '../utils/device_utils.dart';
import '../utils/prefs_util.dart';
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

    if (context.useMobileLayout) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    return AppView(
      title: const Text("Nanny+"),
      drawer: const MainDrawer(),
      body: BlocConsumer<ChildListCubit, ChildListState>(
        listener: (context, state) async {
          if (state is ChildListLoaded) {
            if (state.showOnboarding) {
              await _showOnboardingDialog(context);
            }
          }
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
                state.undeletableChildren,
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

  Future<void> _showOnboardingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.t('Welcome !')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t(
                  "Since this is the first time you run this app, we inserted some sample data.",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  context.t(
                    "Thanks for using Nanny+ !",
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(context.t('Close')),
              onPressed: () async {
                var prefs = await PrefsUtil.getInstance();
                prefs.showOnboarding = false;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
