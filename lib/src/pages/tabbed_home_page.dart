import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/src/pages/home_page.dart';

class TabbedHomePage extends StatefulWidget {
  const TabbedHomePage({Key? key}) : super(key: key);

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Center(
          child: TabbedHomePage._widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
                icon: const Icon(FontAwesomeIcons.euroSign),
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
  }
}
