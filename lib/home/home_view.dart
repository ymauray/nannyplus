import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import 'folder/folders_tab.dart';
import '../tools/tab_meta.dart';
import 'home_view_cubit.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final tabs = <TabMeta>[
    TabMeta(
      label: 'Folders',
      icon: const Icon(Icons.child_care),
      factory: () => const FoldersTab(),
    ),
    TabMeta(
      label: 'Taxes',
      icon: const Icon(Icons.money),
      factory: () => const Center(
        child: Text("Taxes"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewCubit(),
      child: BlocBuilder<HomeViewCubit, HomeViewState>(
        builder: (context, state) => Scaffold(
          body: tabs[state.tab].widget,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            items: tabs
                .map((tab) => BottomNavigationBarItem(
                    icon: tab.icon, label: context.t(tab.label)))
                .toList(),
            currentIndex: state.tab,
            onTap: (value) {
              context.read<HomeViewCubit>().changeTab(value);
            },
          ),
        ),
      ),
    );
  }
}
