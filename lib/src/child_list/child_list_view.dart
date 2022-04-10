import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/widgets/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubit/child_list_cubit.dart';
import '../../data/model/child.dart';
import '../../forms/child_form.dart';
import '../../src/constants.dart';
import '../../utils/i18n_utils.dart';
import '../../utils/prefs_util.dart';
import '../../utils/snack_bar_util.dart';
import '../../widgets/main_drawer.dart';
import '../tab_view/tab_view.dart';
import '../ui/sliver_curved_persistent_header.dart';
import '../ui/view.dart';

class NewChildListView extends StatelessWidget {
  const NewChildListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ChildListCubit>().loadChildList();

    return BlocConsumer<ChildListCubit, ChildListState>(
      listener: (context, state) async {
        if (state is ChildListLoaded) {
          if (state.showOnboarding) {
            await _showOnboardingDialog(context);
          }
        }
        if (state is ChildListError) {
          ScaffoldMessenger.of(context).failure(state.message);
        }
      },
      builder: (context, state) {
        return UIView(
          drawer: const MainDrawer(),
          //onFloatingActionPressed: () async {
          //  var child = await Navigator.of(context).push<Child>(
          //    MaterialPageRoute(builder: (context) => const ChildForm()),
          //  );
          //  if (child != null) {
          //    context.read<ChildListCubit>().create(child);
          //  }
          //},
          title: const Text(ksAppName),
          persistentHeader: UISliverCurvedPersistenHeader(
            child: Text(
              context.t('Pending total') +
                  ' : ' +
                  (state is ChildListLoaded
                      ? state.pendingTotal.toStringAsFixed(2)
                      : '...'),
            ),
          ),
          body: (state is ChildListLoaded)
              //? Stack(
              //    children: [
              //      ListView.builder(
              //        padding: const EdgeInsets.only(top: 0, bottom: 88),
              //        itemBuilder: (context, index) {
              //          return _ChildListTile(
              //            index: index,
              //            state: state,
              //            onTap: () async {
              //              await Navigator.of(context).push(
              //                MaterialPageRoute(
              //                  builder: (context) =>
              //                      NewTabView(state.children[index].id!),
              //                ),
              //              );
              //              var cubit = context.read<ChildListCubit>();
              //              cubit.loadChildList();
              //            },
              //          );
              //        },
              //        itemCount: state.children.length,
              //      ),
              //      Align(
              //        alignment: Alignment.bottomRight,
              //        child: Padding(
              //          padding: const EdgeInsets.all(16.0),
              //          child: FloatingActionButton(
              //            child: const Icon(Icons.add),
              //            onPressed: () {},
              //          ),
              //        ),
              //      ),
              //    ],
              //  )
              ? UIListView(
                  itemBuilder: (context, index) {
                    return _ChildListTile(
                      index: index,
                      state: state,
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                NewTabView(state.children[index].id!),
                          ),
                        );
                        var cubit = context.read<ChildListCubit>();
                        cubit.loadChildList();
                      },
                    );
                  },
                  itemCount: state.children.length,
                  onFloatingActionPressed: () async {
                    var child = await Navigator.of(context).push<Child>(
                      MaterialPageRoute(
                        builder: (context) => const ChildForm(),
                      ),
                    );
                    if (child != null) {
                      context.read<ChildListCubit>().create(child);
                    }
                  },
                )
              : const LoadingIndicator(),
        );
      },
    );
  }

  Future<void> _showOnboardingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            context.t('Welcome !'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t(
                  "Since this is the first time you run this app, we inserted some sample data.",
                ),
                style: Theme.of(context).textTheme.bodyText1,
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

class _ChildListTile extends StatelessWidget {
  const _ChildListTile({
    required this.index,
    required this.state,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final ChildListLoaded state;
  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final child = state.children[index];
    final serviceInfo = state.servicesInfo[child.id];
    final lastEntry = serviceInfo != null
        ? DateFormat.yMMMMd(I18nUtils.locale).format(serviceInfo.lastEnty!)
        : '...';
    final pendingTotal = serviceInfo != null
        ? serviceInfo.pendingTotal.toStringAsFixed(2)
        : '0.00';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 4,
        shape: Theme.of(context).listTileTheme.shape,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.phone,
                    color: child.hasPhoneNumber
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  onPressed: () {
                    child.hasPhoneNumber
                        ? launch('tel://${child.phoneNumber}')
                        : ScaffoldMessenger.of(context).failure(
                            context.t('No phone number'),
                          );
                  },
                ),
              ],
            ),
            title: Text(child.displayName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child.hasAllergies
                      ? context.t('Allergies') + ' : ' + child.allergies!
                      : context.t('No known allergies'),
                ),
                Text(
                  context.t('Last entry') + ' : ' + lastEntry,
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(pendingTotal),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: !state.servicesInfo.containsKey(child.id)
                        ? kcDangerColor
                        : null,
                  ),
                  onPressed: serviceInfo != null
                      ? () {
                          ScaffoldMessenger.of(context).failure(
                            context.t(
                              "There are existing services for this child",
                            ),
                          );
                        }
                      : () async {
                          var delete = await _showConfirmationDialog(context);
                          if (delete ?? false) {
                            context.read<ChildListCubit>().delete(child);
                            ScaffoldMessenger.of(context).success(
                              context.t("Removed successfully"),
                            );
                          }
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.t('Delete')),
          content: Text(
            context.t('Are you sure you want to delete this child\'s folder ?'),
          ),
          actions: [
            TextButton(
              child: Text(context.t('Yes')),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: Text(context.t('No')),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
