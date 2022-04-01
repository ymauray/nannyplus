import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nannyplus/cubit/child_list_cubit.dart';
import 'package:nannyplus/utils/encode_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/children_repository.dart';
import '../data/invoices_repository.dart';
import '../data/model/invoice.dart';
import '../utils/database_util.dart';
import '../data/model/child.dart';
import '../data/model/service.dart';
import '../data/model/price.dart';
import '../data/services_repository.dart';
import '../data/prices_repository.dart';
import '../utils/prefs_util.dart';
import '../views/price_list_view.dart';
import '../views/privacy_settings_view.dart';
import '../views/settings_view.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Image.asset('assets/img/banner1500.png'),
            ),
            ListTile(
              key: const Key('price_list_menu'),
              title: Text(
                context.t('Price list'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.payment),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PriceListView(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                context.t('Settings'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const SettingsView(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                context.t('Privacy settings'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.privacy_tip),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const PrivacySettingsView(),
                  ),
                );
              },
            ),
            const Divider(),
            if (kDebugMode)
              ListTile(
                title: Text(
                  context.t('Import data'),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: const Icon(Icons.question_mark),
                onTap: () async {
                  await importData(true);
                  Navigator.of(context).pop();
                  context.read<ChildListCubit>().loadChildList();
                },
              ),
            if (kDebugMode)
              ListTile(
                title: Text(
                  context.t('Reset database'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.delete),
                onTap: () async {
                  await DatabaseUtil.deleteDatabase();
                  (await SharedPreferences.getInstance()).clear();
                  await context.read<ChildListCubit>().loadChildList();
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }

  final semaine =
      const Price(id: 1, label: 'Heures semaine', amount: 7.0, fixedPrice: 0);
  final weekend =
      const Price(id: 2, label: 'Heures weekend', amount: 8.0, fixedPrice: 0);
  final petitRepas =
      const Price(id: 3, label: 'Petit repas', amount: 5.0, fixedPrice: 1);
  final grandRepas =
      const Price(id: 4, label: 'Grand repas', amount: 7.0, fixedPrice: 1);

  final fakeNames = const [
    {
      "firstName": "Monique",
      "lastName": "Grandbois",
      "phoneNumber": "+41 48 899 82 53",
      "parentsName": "Christelle et Gaston Grandbois",
      "address": "Hasenbühlstrasse 58\n8715 Bollingen",
    },
    {
      "firstName": "Anouk",
      "lastName": "Lampron",
      "phoneNumber": "+41 18 349 79 94",
      "parentsName": "Valérie et Olivier Lampron",
      "address": "Kammelenbergstrasse 65\n3065 Flugbrunnen",
    },
    {
      "firstName": "Thomas",
      "lastName": "Tanguay",
      "phoneNumber": "+41 26 947 58 67",
      "parentsName": "Virginie et Armand Tanguay",
      "address": "Via dalla Staziun 93\n1682 Dompierre",
    },
    {
      "firstName": "Eloise",
      "lastName": "Plaisance",
      "phoneNumber": "+41 24 216 93 91",
      "parentsName": "Catherine et Anton Plaisance",
      "address": "Piazza Indipendenza 74\n1899 Torgon",
    },
    {
      "firstName": "Honoré",
      "lastName": "Clavet",
      "phoneNumber": "+41 44 991 43 47",
      "parentsName": "Michèle et Gustave Clavet",
      "address": "Valéestrasse 60\n8913 Ottenbach",
    },
    {
      "firstName": "Carolos",
      "lastName": "Lafrenière",
      "phoneNumber": "+41 22 888 86 29",
      "parentsName": "Astrid et Éric Lafrenière",
      "address": "Via Schliffras 22\n1211 Genève",
    },
    {
      "firstName": "Thibaut",
      "lastName": "Chauvet",
      "phoneNumber": "+41 44 283 83 94",
      "parentsName": "Émilie et Gaspar Chauvet",
      "address": "Tösstalstrasse 53\n8360 Wallenwil",
    },
    {
      "firstName": "Fabien",
      "lastName": "Bossé",
      "phoneNumber": "+41 44 258 44 38",
      "parentsName": "Hélène et Alexandre Bossé",
      "address": "Möhe 62\n8307 Illnau-Effretikon",
    },
  ];

  Future<void> importData(bool anonymize) async {
    await DatabaseUtil.deleteDatabase();

    /* This will create create the database and insert the sample data. */
    await DatabaseUtil.instance;

    /* Now we can remove the sample date */
    await DatabaseUtil.clear();

    /* We also clear the showOnboarding flag */
    (await PrefsUtil.getInstance()).showOnboarding = false;

    var pricesRepository = const PricesRepository();

    pricesRepository.create(semaine);
    pricesRepository.create(weekend);
    pricesRepository.create(petitRepas);
    pricesRepository.create(grandRepas);

    var response = await http.get(
      Uri.parse(
        urlDecoder("aHR0cHM6Ly9zYW5kcmluZWtvaGxlci5jaC9hcGkvanNvbg"),
      ),
    );
    var jsonResponse = jsonDecode(response.body);
    var children = jsonResponse['children'];
    var i = 0;
    for (var c in children) {
      await processChild(c, anonymize ? fakeNames[i++] : null);
    }
  }

  Future<void> processChild(
    dynamic c,
    Map<String, String>? anonymizedData,
  ) async {
    var childrenRepository = const ChildrenRepository();
    var invoicesRepository = const InvoicesRepository();

    c['archived'] = c['archived'] ?? true ? 1 : 0;
    c['preschool'] = c['preschool'] ?? true ? 1 : 0;
    var child = Child.fromMap(c);
    if (anonymizedData != null) {
      child = child.copyWith(
        firstName: anonymizedData['firstName'],
        lastName: anonymizedData['lastName'],
        phoneNumber: anonymizedData['phoneNumber'],
        parentsName: anonymizedData['parentsName'],
        address: anonymizedData['address'],
      );
    }
    await childrenRepository.create(child);

    var entries = c['_entries'];
    for (var e in entries) {
      await processEntry(c, e);
    }

    for (var i in c['_invoices']) {
      var invoice = Invoice.fromMap(i);
      if (anonymizedData != null) {
        invoice = invoice.copyWith(
          parentsName: anonymizedData['parentsName'],
          address: anonymizedData['address'],
        );
      }
      await invoicesRepository.create(invoice);
    }
  }

  Future<void> processEntry(dynamic c, dynamic e) async {
    var servicesRepository = const ServicesRepository();

    var legacyEntry = LegacyEntry.fromMap(e);
    var date = DateFormat('yyyy-MM-dd').parse(legacyEntry.date);

    if (legacyEntry.hours + legacyEntry.minutes > 0) {
      var weekDay = (date.weekday != DateTime.sunday &&
          date.weekday != DateTime.saturday);
      var service = Service(
        childId: c['id'],
        date: legacyEntry.date,
        priceId: semaine.id!,
        priceLabel: semaine.label,
        priceAmount: semaine.amount,
        isFixedPrice: semaine.isFixedPrice ? 1 : 0,
        hours: legacyEntry.hours,
        minutes: legacyEntry.minutes,
        total: semaine.amount * (legacyEntry.hours + legacyEntry.minutes / 60),
        invoiced: legacyEntry.invoiced ? 1 : 0,
        invoiceId:
            legacyEntry.invoiced ? int.parse(legacyEntry.invoiceId) : null,
      );
      if (!weekDay) {
        service = service.copyWith(
          priceId: weekend.id!,
          priceLabel: weekend.label,
          priceAmount: weekend.amount,
          isFixedPrice: weekend.isFixedPrice ? 1 : 0,
          total:
              weekend.amount * (legacyEntry.hours + legacyEntry.minutes / 60),
        );
      }
      await servicesRepository.create(service);
    }

    if (legacyEntry.lunch) {
      var service = Service(
        childId: c['id'],
        date: legacyEntry.date,
        priceId: c['preschool'] == 1 ? petitRepas.id! : grandRepas.id!,
        priceLabel: c['preschool'] == 1 ? petitRepas.label : grandRepas.label,
        priceAmount:
            c['preschool'] == 1 ? petitRepas.amount : grandRepas.amount,
        isFixedPrice: c['preschool'] == 1
            ? (petitRepas.isFixedPrice ? 1 : 0)
            : (grandRepas.isFixedPrice ? 1 : 0),
        total: c['preschool'] == 1 ? petitRepas.amount : grandRepas.amount,
        invoiced: legacyEntry.invoiced ? 1 : 0,
        invoiceId:
            legacyEntry.invoiced ? int.parse(legacyEntry.invoiceId) : null,
      );
      await servicesRepository.create(service);
    }
  }
}

class LegacyEntry {
  final int id;
  final int childId;
  final String date;
  final int hours;
  final int minutes;
  final bool lunch;
  final bool night;
  final bool invoiced;
  final String invoiceId;

  const LegacyEntry({
    required this.id,
    required this.childId,
    required this.date,
    required this.hours,
    required this.minutes,
    required this.lunch,
    required this.night,
    required this.invoiced,
    required this.invoiceId,
  });

  LegacyEntry copyWith({
    int? id,
    int? childId,
    String? date,
    int? hours,
    int? minutes,
    bool? lunch,
    bool? night,
    bool? invoiced,
    String? invoiceId,
  }) {
    return LegacyEntry(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      date: date ?? this.date,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      lunch: lunch ?? this.lunch,
      night: night ?? this.night,
      invoiced: invoiced ?? this.invoiced,
      invoiceId: invoiceId ?? this.invoiceId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'date': date,
      'hours': hours,
      'minutes': minutes,
      'lunch': lunch,
      'night': night,
      'invoiced': invoiced,
      'invoiceId': invoiceId,
    };
  }

  factory LegacyEntry.fromMap(Map<String, dynamic> map) {
    return LegacyEntry(
      id: map['id']?.toInt() ?? 0,
      childId: map['childId']?.toInt() ?? 0,
      date: map['date'] ?? '',
      hours: map['hours']?.toInt() ?? 0,
      minutes: map['minutes']?.toInt() ?? 0,
      lunch: map['lunch'] ?? false,
      night: map['night'] ?? false,
      invoiced: map['invoiced'] ?? false,
      invoiceId: map['invoiceId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LegacyEntry.fromJson(String source) =>
      LegacyEntry.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LegacyEntry(id: $id, childId: $childId, date: $date, hours: $hours, minutes: $minutes, lunch: $lunch, night: $night, invoiced: $invoiced, invoiceId: $invoiceId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LegacyEntry &&
        other.id == id &&
        other.childId == childId &&
        other.date == date &&
        other.hours == hours &&
        other.minutes == minutes &&
        other.lunch == lunch &&
        other.night == night &&
        other.invoiced == invoiced &&
        other.invoiceId == invoiceId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        childId.hashCode ^
        date.hashCode ^
        hours.hashCode ^
        minutes.hashCode ^
        lunch.hashCode ^
        night.hashCode ^
        invoiced.hashCode ^
        invoiceId.hashCode;
  }
}
