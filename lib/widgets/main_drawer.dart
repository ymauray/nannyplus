import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:nannyplus/data/services_repository.dart';
import 'package:nannyplus/data/prices_repository.dart';
import 'package:nannyplus/views/price_list_view.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _tapCount = 0;
    Timer? _timer;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                _tapCount += 1;
                if (_tapCount == 7) {
                  await importData();
                  Navigator.of(context).pop();
                }
                if (_timer != null) {
                  _timer!.cancel();
                }
                _timer = Timer(const Duration(milliseconds: 200), () {
                  _tapCount = 0;
                });
              },
              child: const ListTile(
                tileColor: Colors.blue,
                textColor: Colors.white,
                iconColor: Colors.white,
                title: Text('Nanny+'),
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(context.t('Settings')),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
                //Navigator.of(context).push(
                //  MaterialPageRoute(
                //    builder: (context) => const SettingsView(),
                //  ),
                //);
              },
            ),
            const Divider(),
            ListTile(
              title: Text(context.t('Price list')),
              leading: const Icon(Icons.payment),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PriceListView(),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Future<void> importData() async {
    await DatabaseUtil.deleteDatabase();
    var childrenRepository = const ChildrenRepository();
    var pricesRepository = const PricesRepository();
    var servicesRepository = const ServicesRepository();

    var response = await http.get(Uri.parse('http://10.0.2.2/api/json'));
    var jsonResponse = jsonDecode(response.body);
    var children = jsonResponse['children'];
    for (var c in children) {
      c['archived'] = c['archived'] ?? true ? 1 : 0;
      var child = Child.fromMap(c);
      await childrenRepository.create(child);
    }

    var semaine =
        const Price(id: 1, label: 'Heures semaine', amount: 7.0, fixedPrice: 0);
    pricesRepository.create(semaine);
    var weekend =
        const Price(id: 2, label: 'Heures weekend', amount: 8.0, fixedPrice: 0);
    pricesRepository.create(weekend);
    var petitRepas =
        const Price(id: 3, label: 'Petit repas', amount: 5.0, fixedPrice: 1);
    pricesRepository.create(petitRepas);
    var grandRepas =
        const Price(id: 4, label: 'Grand repas', amount: 7.0, fixedPrice: 1);
    pricesRepository.create(grandRepas);

    for (var c in children) {
      var entries = c['_entries'];
      for (var e in entries) {
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
            isFixedPrice: semaine.isFixedPrice ? 1 : 0,
            hours: legacyEntry.hours,
            minutes: legacyEntry.minutes,
            price:
                semaine.amount * (legacyEntry.hours + legacyEntry.minutes / 60),
            invoiced: legacyEntry.invoiced ? 1 : 0,
            invoiceId:
                legacyEntry.invoiced ? int.parse(legacyEntry.invoiceId) : null,
          );
          if (!weekDay) {
            service = service.copyWith(
              priceId: weekend.id!,
              priceLabel: weekend.label,
              isFixedPrice: weekend.isFixedPrice ? 1 : 0,
              price: weekend.amount *
                  (legacyEntry.hours + legacyEntry.minutes / 60),
            );
          }
          await servicesRepository.create(service);
        }

        if (legacyEntry.lunch) {
          var service = Service(
            childId: c['id'],
            date: legacyEntry.date,
            priceId: petitRepas.id!,
            priceLabel: petitRepas.label,
            isFixedPrice: petitRepas.isFixedPrice ? 1 : 0,
            price: petitRepas.amount,
            invoiced: legacyEntry.invoiced ? 1 : 0,
            invoiceId:
                legacyEntry.invoiced ? int.parse(legacyEntry.invoiceId) : null,
          );
          await servicesRepository.create(service);
        }
      }
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
