import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nannyplus/src/pages/invoices_page.dart';

import '../models/folder.dart';
import '../pages/entries_page.dart';
import '../../tools/tab_meta.dart';

class TabbedEntriesPage extends StatefulWidget {
  TabbedEntriesPage(this.folder, {Key? key})
      : _widgetOptions = [
          //TabMeta(
          //    label: 'Entries',
          //    icon: const Icon(Icons.hourglass_empty),
          //    widget: OldEntriesPage(folder)),
          //TabMeta(
          //    label: 'Invoices',
          //    icon: const Icon(FontAwesomeIcons.filePdf),
          //    widget: InvoicesPage(
          //      folder: folder,
          //    )),
          //TabMeta(
          //    label: 'Folder',
          //    icon: const Icon(FontAwesomeIcons.folder),
          //    widget: Container()),
        ],
        super(key: key);

  final Folder folder;
  final List<TabMeta> _widgetOptions;

  @override
  State<TabbedEntriesPage> createState() => _TabbedEntriesPageState();
}

class _TabbedEntriesPageState extends State<TabbedEntriesPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget._widgetOptions.length,
      child: Scaffold(
        body: Center(
          child: widget._widgetOptions.elementAt(_selectedIndex).widget,
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            items: widget._widgetOptions
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
  }
}
