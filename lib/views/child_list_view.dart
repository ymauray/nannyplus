import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/cubit/child_list_state.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/provider/legacy/child_list_provider.dart';
import 'package:nannyplus/src/child_form/child_form.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/tab_view/tab_view.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/utils/i18n_utils.dart';
import 'package:nannyplus/utils/snack_bar_util.dart';
import 'package:url_launcher/url_launcher.dart';

class ChildListView extends ConsumerStatefulWidget {
  const ChildListView({super.key});

  @override
  ConsumerState<ChildListView> createState() => _ChildListViewState();
}

class _ChildListViewState extends ConsumerState<ChildListView> {
  bool showArchivedFolders = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(childListControllerProvider);

    if (state is ChildListInitial) {
      ref.read(childListControllerProvider.notifier).loadChildList(
            loadArchivedFolders: showArchivedFolders,
          );
    }

    if (state is! ChildListLoaded) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return UIListView(
      itemBuilder: (context, index) {
        return _ChildListTile(
          index: index,
          state: state,
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => TabView(state.children[index].id!),
              ),
            );
            await ref.read(childListControllerProvider.notifier).loadChildList(
                  loadArchivedFolders: showArchivedFolders,
                );
          },
          onToggleShowArchivedFolders: () {
            final child = state.children[index];
            if (!child.isArchived) {
              ref.read(childListControllerProvider.notifier).archive(child);
              ScaffoldMessenger.of(context)
                  .success(context.t('Archived successfully'));
            } else {
              ref.read(childListControllerProvider.notifier).unarchive(child);
              ScaffoldMessenger.of(context)
                  .success(context.t('Unarchived successfully'));
            }
            ref.read(childListControllerProvider.notifier).loadChildList(
                  loadArchivedFolders: showArchivedFolders,
                );
          },
        );
      },
      itemCount: state.children.length,
      extraWidget: TextButton(
        onPressed: () {
          setState(() {
            ref.read(childListControllerProvider.notifier).reinitialize();
            showArchivedFolders = !showArchivedFolders;
          });
        },
        child: Text(
          context.t(
            showArchivedFolders
                ? 'Hide archived folders'
                : 'Show archived folders',
          ),
        ),
      ),
      onFloatingActionPressed: () async {
        final child = await Navigator.of(context).push<Child>(
          MaterialPageRoute(
            builder: (context) => const ChildForm(),
          ),
        );
        if (child != null) {
          await ref.read(childListControllerProvider.notifier).create(child);
        }
      },
    );
  }
}

class _ChildListTile extends ConsumerWidget {
  const _ChildListTile({
    required this.index,
    required this.state,
    required this.onToggleShowArchivedFolders,
    this.onTap,
  });

  final ChildListLoaded state;
  final int index;
  final void Function()? onTap;
  final void Function() onToggleShowArchivedFolders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final child = state.children[index];
    final serviceInfo = state.servicesInfo[child.id];
    final lastEntry = serviceInfo != null
        ? (serviceInfo.lastEnty!.isBefore(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          )
            ? DateFormat.yMd(I18nUtils.localeString)
                .format(serviceInfo.lastEnty!)
            : DateFormat(DateFormat.WEEKDAY, I18nUtils.localeString)
                .format(serviceInfo.lastEnty!))
        : '...';
    final pendingTotal = serviceInfo != null
        ? serviceInfo.pendingTotal.toStringAsFixed(2)
        : '0.00';
    final pendingInvoice = serviceInfo != null
        ? serviceInfo.pendingInvoice.toStringAsFixed(2)
        : '0.00';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: 4,
        shape: Theme.of(context).listTileTheme.shape,
        child: GestureDetector(
          onTap: child.isArchived ? null : onTap,
          behavior: HitTestBehavior.opaque,
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.phone,
                    color: child.hasPhoneNumber
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                  ),
                  onPressed: () {
                    child.hasPhoneNumber
                        ? launchUrl(Uri.parse('tel://${child.phoneNumber}'))
                        : ScaffoldMessenger.of(context).failure(
                            context.t('No phone number'),
                          );
                  },
                ),
              ],
            ),
            title: Text(
              child.displayName,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontStyle:
                        child.isArchived ? FontStyle.italic : FontStyle.normal,
                    color: child.isArchived
                        ? Colors.grey
                        : (state.invoicesInfo.contains(child.id)
                            ? Colors.red
                            : null),
                  ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child.hasAllergies
                      ? child.allergies!
                      : context.t('No known allergies'),
                ),
                Text(
                  '${context.t('Last entry')} : $lastEntry',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                ),
                Text(
                  '${context.t('Pending invoice')} : $pendingInvoice',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(pendingTotal),
                ),
                PopupMenuButton(
                  onSelected: (value) async {
                    switch (value) {
                      case 1:
                        if (!child.isArchived &&
                            serviceInfo != null &&
                            serviceInfo.pendingTotal != 0) {
                          ScaffoldMessenger.of(context).failure(
                            context.t(
                              'There are existing services for this child',
                            ),
                          );
                        } else {
                          final archive = await showConfirmationDialog(
                            context,
                            child.isArchived
                                ? context.t(
                                    'Are you sure you want to unarchive this folder ?',
                                  )
                                : context.t(
                                    'Are you sure you want to archive this folder ?',
                                  ),
                          );
                          if (archive ?? false) {
                            onToggleShowArchivedFolders();
                          }
                        }
                      case 2:
                        if (serviceInfo != null) {
                          ScaffoldMessenger.of(context).failure(
                            context.t(
                              'There are existing services for this child',
                            ),
                          );
                        } else {
                          final delete = await showConfirmationDialog(
                            context,
                            context.t(
                              "Are you sure you want to delete this child's folder ?",
                            ),
                          );
                          if (delete ?? false) {
                            await ref
                                .read(childListControllerProvider.notifier)
                                .delete(child);
                            ScaffoldMessenger.of(context).success(
                              context.t('Removed successfully'),
                            );
                          }
                        }
                      case 3:
                        final clone = await Navigator.of(context).push<Child>(
                          MaterialPageRoute<Child>(
                            builder: (context) => ChildForm(
                              childToClone: child,
                            ),
                          ),
                        );
                        if (clone != null) {
                          await ref
                              .read(childListControllerProvider.notifier)
                              .create(clone);
                        }
                    }
                  },
                  padding: EdgeInsets.zero,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 3,
                        child: ListTile(
                          leading: const Icon(
                            Icons.copy,
                            color: kcAlmostBlack,
                          ),
                          title: Text(
                            context.t('Clone folder'),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          leading: const Icon(
                            Icons.hide_source_outlined,
                            color: kcAlmostBlack,
                          ),
                          title: Text(
                            child.isArchived
                                ? context.t('Unarchive folder')
                                : context.t('Archive folder'),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        enabled: !child.isArchived,
                        child: ListTile(
                          leading: Icon(
                            Icons.delete_forever_outlined,
                            color: !child.isArchived &&
                                    !state.servicesInfo.containsKey(child.id)
                                ? kcDangerColor
                                : null,
                          ),
                          title: Text(
                            context.t('Delete'),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showConfirmationDialog(
    BuildContext context,
    String message,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(context.t('Delete')),
          content: Text(message),
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
