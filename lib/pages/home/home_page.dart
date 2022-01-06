import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/pages/price_list/price_list_page.dart';

import '../../model/price_list.dart';
import '../../tools/tab_meta.dart';
import 'home_page_cubit.dart';
import 'folders/folders_tab.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

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
      create: (context) => HomePageCubit(context.read<PriceList>().allSet),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state.priceListSet) {
            return Scaffold(
              body: tabs[state.tab].widget,
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.blue,
                items: tabs
                    .map((tab) => BottomNavigationBarItem(
                        icon: tab.icon, label: context.t(tab.label)))
                    .toList(),
                currentIndex: state.tab,
                onTap: (value) {
                  context.read<HomePageCubit>().changeTab(value);
                },
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.t("Welcome to"),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const Image(
                    image: AssetImage("assets/img/banner1500.png"),
                  ),
                  Text(
                    context.t(
                        "Before you begin, you need to set your price list."),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PriceListPage(),
                          fullscreenDialog: true,
                        ),
                      );
                      context.read<HomePageCubit>().priceListSet = true;
                      //setState(() {
                      //  _selectedIndex = 0;
                      //});
                    },
                    child: Text(
                      context.t("Open price list page"),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
