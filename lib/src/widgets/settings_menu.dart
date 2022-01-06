import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nannyplus/src/models/invoice.dart';
import 'package:provider/provider.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/entry.dart';
import '../models/rates.dart';
import '../pages/rates_page.dart';
import '../models/folder.dart';
import '../models/app_theme.dart';
import '../utils/database_utils.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  Timer? _timer;
  int _tapCount = 0;
  bool _showExtraMenu = kDebugMode;

  @override
  Widget build(BuildContext context) {
    var themes = context.read<AppTheme>();
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: GestureDetector(
                onTap: () {
                  _tapCount += 1;
                  if (_tapCount == 7) {
                    setState(() {
                      _showExtraMenu = true;
                    });
                  }
                  if (_timer != null) {
                    _timer!.cancel();
                  }
                  _timer = Timer(const Duration(milliseconds: 200), () {
                    _tapCount = 0;
                  });
                },
                child: Text(
                  context.t('Settings'),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
            const Divider(),
            //
            // Use dark mode
            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.t('Use dark mode')),
                  Switch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) {
                      themes.useDarkMode = value;
                      SharedPreferences.getInstance()
                          .then((prefs) => prefs.setBool("useDarkMode", value));
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(context.t("Rates")),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RatesPage(),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            const Divider(),
            //
            // Reset database
            //
            Consumer<Folders>(
              builder: (context, folders, _) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ElevatedButton(
                  onPressed: () async {
                    await DatabaseUtils.databaseUtils.deleteDatabase();
                    final prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    context.read<Folders>().reload();
                  },
                  child: Text(context.t('Reset database')),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                ),
              ),
            ),
            if (kDebugMode) ...[
              Consumer<Rates>(
                builder: (_, rates, __) => Consumer<Folders>(
                  builder: (context, folders, _) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () async {
                        await folders.addFolders([
                          Folder.create(
                              firstName: 'Catherine',
                              lastName: 'Chaussée',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Anne',
                              lastName: 'Rochefort',
                              preSchool: true,
                              archived: false,
                              phoneNumber: "+41786481543"),
                          Folder.create(
                              firstName: 'Arnaud',
                              lastName: 'Houle',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Georgette',
                              lastName: 'Gingras',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Antoine',
                              lastName: 'Vachon',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Didier',
                              lastName: 'Courtois',
                              preSchool: true,
                              archived: true),
                          Folder.create(
                              firstName: 'Roland',
                              lastName: 'Duperré',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Morgana',
                              lastName: 'Louineaux',
                              preSchool: true,
                              archived: true),
                          Folder.create(
                              firstName: 'Hardouin',
                              lastName: 'Leroux',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Sibyla',
                              lastName: 'Bouvier',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Anouk',
                              lastName: 'Lavoie',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Lucas',
                              lastName: 'Devost',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Solaine',
                              lastName: 'Franchet',
                              preSchool: true,
                              archived: true),
                          Folder.create(
                              firstName: 'Charlotte',
                              lastName: 'Desaulniers',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Laurene',
                              lastName: 'Faucher',
                              preSchool: true,
                              archived: false),
                          Folder.create(
                              firstName: 'Yolette',
                              lastName: 'Rouze',
                              preSchool: true,
                              archived: false)
                        ]);
                        var entries = Entries.load(folders.getData(true)[0]);
                        //var rates = context.read<Rates>();
                        await entries.addEntries([
                          rates.createEntry(DateTime.parse('2021-10-28'), 1, 00,
                              false, false, false, true)
                            ..invoiceId = 1,
                          rates.createEntry(DateTime.parse('2021-10-26'), 1, 15,
                              false, false, false, true)
                            ..invoiceId = 1,
                          rates.createEntry(DateTime.parse('2021-10-14'), 1, 15,
                              false, false, false, true)
                            ..invoiceId = 1,
                          rates.createEntry(DateTime.parse('2021-10-13'), 1, 30,
                              false, true, false, true)
                            ..invoiceId = 1,
                          rates.createEntry(DateTime.parse('2021-10-12'), 1, 30,
                              false, false, false, true)
                            ..invoiceId = 1,
                          rates.createEntry(DateTime.parse('2021-10-06'), 1, 00,
                              false, false, false, true)
                            ..invoiceId = 1,
                          rates.createEntry(DateTime.parse('2021-10-05'), 1, 00,
                              false, false, false, true)
                            ..invoiceId = 1,
                          rates.createEntry(DateTime.parse('2021-10-04'), 7, 45,
                              false, true, false, true)
                            ..invoiceId = 1,
                          rates.createEntry(DateTime.parse('2021-11-04'), 0, 45,
                              false, false, false, true),
                          rates.createEntry(DateTime.parse('2021-11-09'), 1, 15,
                              false, false, false, true),
                          rates.createEntry(DateTime.parse('2021-11-17'), 1, 00,
                              false, false, false, true),
                          rates.createEntry(DateTime.parse('2021-11-18'), 2, 00,
                              false, true, false, true),
                          rates.createEntry(DateTime.parse('2021-11-21'), 4, 00,
                              false, false, false, true),
                          rates.createEntry(DateTime.parse('2021-11-23'), 2, 00,
                              false, true, false, true),
                          rates.createEntry(DateTime.parse('2021-11-30'), 2, 00,
                              false, true, false, true),
                        ]);
                      },
                      child: Text(context.t('Insert test data')),
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
            if (_showExtraMenu) ...[
              Consumer<Rates>(
                builder: (_, rates, __) => Consumer<Folders>(
                  builder: (context, folders, _) => ElevatedButton(
                    onPressed: () async {
                      final response = await http.get(
                        Uri.parse('https://sandrinekohler.ch/api/json'),
                        headers: {
                          'authorization': basicAuth,
                        },
                      );
                      Map<String, dynamic> jsonData = jsonDecode(response.body);

                      // Get price list
                      var priceList =
                          jsonData['pricelist'] as Map<String, dynamic>;
                      var rates = context.read<Rates>();
                      rates.weekHours = 1.0 * priceList['week'];
                      rates.weekendHours = 1.0 * priceList['weekend'];
                      rates.mealPreschool = 1.0 * priceList['lunch'];
                      rates.mealPreschool = 1.0 * priceList['diner'];
                      rates.night = 1.0 * priceList['night'];
                      rates.commit();

                      // Iterate of children in json file
                      var children = jsonData['children'] as List;
                      for (var child in children) {
                        // Create a folder from json data
                        var folder =
                            await folders.createFolder(Folder.fromJson(child));

                        // Create invoices from json data, mapping them to newly created folder
                        // Also create a map of old ids => new ids
                        var idMap = <int, int>{};
                        var invoices = Invoices.load(folder);
                        var invoicesData = child['_invoices'] as List;
                        for (var invoiceData in invoicesData) {
                          var invoice = Invoice.fromJson(invoiceData);
                          var oldId = invoice.id!;
                          invoice = await invoices.createInvoice(invoice);
                          idMap[oldId] = invoice.id!;
                        }

                        // Create entries from json data, mapping old invoice ids to new ones
                        var entries = Entries.load(folder);
                        var entriesData = child['_entries'] as List;
                        for (var entryData in entriesData) {
                          var entry =
                              rates.createEntryFromJson(entryData, true);
                          entry.invoiceId =
                              idMap[int.tryParse(entryData['invoiceId'])!];
                          entry = await entries.createEntry(entry);
                        }
                      }

                      /*
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ImportPage(),
                    ),
                  );
                  */
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Text(
                      context.t("Import data"),
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
