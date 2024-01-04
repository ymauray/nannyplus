import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/cubit/child_list_state.dart';
import 'package:nannyplus/provider/legacy/child_list_provider.dart';
import 'package:nannyplus/provider/show_pending_invoice_provider.dart';
import 'package:nannyplus/src/child_list/main_drawer.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/prefs_util.dart';
import 'package:nannyplus/utils/snack_bar_util.dart';
import 'package:nannyplus/views/child_list_view.dart';
import 'package:nannyplus/views/options_view.dart';

class MainTabView extends ConsumerStatefulWidget {
  const MainTabView({super.key});

  @override
  ConsumerState<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends ConsumerState<MainTabView> {
  bool showArchivedFolders = false;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final showPendingInvoice = ref.watch(showPendingInvoiceProvider);

    final childListState = ref.watch(childListControllerProvider);

    if (childListState is ChildListLoaded) {
      if (childListState.showOnboarding) {
        Future<void>.delayed(
          Duration.zero,
          () => _showOnboardingDialog(context),
        );
      }
    }

    if (childListState is ChildListError) {
      Future<void>.delayed(
        Duration.zero,
        () => ScaffoldMessenger.of(context).failure(childListState.message),
      );
    }

    return UIView(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.folder),
            label: context.t('Folders'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: context.t('Options'),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      title: const Text(ksAppName),
      persistentHeader: UISliverCurvedPersistenHeader(
        child: _currentIndex == 0
            ? GestureDetector(
                onTap: () {
                  ref.read(showPendingInvoiceProvider.notifier).toggle();
                },
                child: showPendingInvoice
                    ? Text(
                        '${context.t('Pending invoice')} : ${childListState is ChildListLoaded ? childListState.pendingInvoice.toStringAsFixed(2) : '...'}',
                      )
                    : Text(
                        '${context.t('Pending total')} : ${childListState is ChildListLoaded ? childListState.pendingTotal.toStringAsFixed(2) : '...'}',
                      ),
              )
            : Text(
                context.t('Options'),
              ),
      ),
      body: _currentIndex == 0
          ? const ChildListView() // _buildChildList(context, childListState, ref)
          : const OptionsView(),
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
                  'Since this is the first time you run this app, we inserted some sample data.',
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  context.t(
                    'Thanks for using Nanny+ !',
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(context.t('Close')),
              onPressed: () async {
                final prefs = await PrefsUtil.getInstance();
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
