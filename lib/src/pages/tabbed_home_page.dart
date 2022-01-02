import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/rates.dart';
import 'home_page.dart';
import 'rates_page.dart';

class TabbedHomePage extends StatefulWidget {
  const TabbedHomePage({Key? key, required this.sharedPreferences})
      : super(key: key);

  final SharedPreferences sharedPreferences;

  static const List<Widget> _widgetOptions = [
    HomePage(),
    HomePage(),
    HomePage(),
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
            length: 3,
            child: Scaffold(
              body: Center(
                child: TabbedHomePage._widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: Colors.blue,
                  items: [
                    BottomNavigationBarItem(
                      label: context.t("Children"),
                      icon: const Icon(Icons.folder),
                    ),
                    BottomNavigationBarItem(
                      label: context.t("Invoices"),
                      icon: const Icon(FontAwesomeIcons.solidFilePdf),
                    ),
                    BottomNavigationBarItem(
                      label: context.t("Taxes"),
                      icon: const Icon(
                        FontAwesomeIcons.euroSign,
                      ),
                    )
                  ],
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
