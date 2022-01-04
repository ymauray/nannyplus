import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/rates.dart';
import 'home_page.dart';
import 'rates_page.dart';

class TabMeta {
  final String label;
  final Icon icon;
  final Widget widget;

  TabMeta({required this.label, required this.icon, required this.widget});
}

class TabbedHomePage extends StatefulWidget {
  const TabbedHomePage({Key? key, required this.sharedPreferences})
      : super(key: key);

  final SharedPreferences sharedPreferences;

  static final List<TabMeta> _widgetOptions = [
    TabMeta(
        label: 'Children',
        icon: const Icon(Icons.folder),
        widget: const HomePage()),
    TabMeta(
        label: 'Taxes',
        icon: const Icon(FontAwesomeIcons.euroSign),
        widget: const HomePage()),
  ];

  @override
  State<TabbedHomePage> createState() => _TabbedHomePageState();
}

class _TabbedHomePageState extends State<TabbedHomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<Rates>(
      builder: (context, rates, _) {
        if (rates.allSet) {
          return DefaultTabController(
            length: TabbedHomePage._widgetOptions.length,
            child: Scaffold(
              body: Center(
                child: TabbedHomePage._widgetOptions
                    .elementAt(_selectedIndex)
                    .widget,
              ),
              bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: Colors.blue,
                  items: TabbedHomePage._widgetOptions
                      .map((e) =>
                          BottomNavigationBarItem(icon: e.icon, label: e.label))
                      .toList(),
                  currentIndex: _selectedIndex,
                  onTap: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
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
                  context
                      .t("Before you begin, you need to set your price list."),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RatesPage(),
                        fullscreenDialog: true,
                      ),
                    );
                    setState(() {
                      _selectedIndex = 0;
                    });
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
    );
  }
}
