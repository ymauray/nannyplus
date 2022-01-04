import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'folder.dart';
import '../utils/database_utils.dart';

extension DateTimeExt on DateTime {
  bool isWeekend() {
    return weekday == DateTime.sunday || weekday == DateTime.saturday;
  }
}

class Entry {
  Entry.create(this.date, this.hours, this.minutes, this.lunch, this.diner,
      this.night, this.total);

  Entry.empty();

  int? id;
  int? folderId;
  DateTime? date;
  int? hours;
  int? minutes;
  bool? lunch;
  bool? diner;
  bool? night;
  double? total;
  int? invoiceId;

  Entry.fromDbMap(Map<String, Object?> row)
      : id = row['id'] as int,
        folderId = row['folderId'] as int,
        date =
            row['date'] == null ? null : DateTime.parse(row['date'] as String),
        total = row['total'] as double,
        hours = row['hours'] as int,
        minutes = row['minutes'] as int,
        lunch = row['lunch'].toBool(),
        diner = row['diner'].toBool(),
        night = row['night'].toBool(),
        invoiceId = row['invoiceId'] as int?;

  Map<String, Object?> toDbMap() {
    return {
      'folderId': folderId,
      'date': date == null ? null : DateFormat('yyyy-MM-dd').format(date!),
      'total': total,
      'hours': hours,
      'minutes': minutes,
      'lunch': lunch.toDbInt(),
      'diner': diner.toDbInt(),
      'night': night.toDbInt(),
      'invoiceId': invoiceId,
    };
  }
}

extension EntriesExt on List<Entry> {
  sortByDate() {
    sort((a, b) => b.date!.isBefore(a.date!) ? -1 : 1);
  }
}

class Entries extends ChangeNotifier {
  Entries.load(Folder folder) : _folder = folder {
    reload();
  }

  final _data = <Entry>[];
  final Folder _folder;

  List<Entry> get data => UnmodifiableListView(
      _data.where((element) => (element.invoiceId == null)));

  double total() {
    return data.isEmpty
        ? 0
        : data.map((e) => e.total!).reduce((value, element) => value + element);
  }

  Future<Entry> createEntry(Entry entry) async {
    entry.folderId = _folder.id;
    var db = await DatabaseUtils.databaseUtils.database;
    var id = await db.insert('entry', entry.toDbMap());
    entry.id = id;
    reload();
    return entry;
  }

  Future<void> addEntries(List<Entry> entries) async {
    var db = await DatabaseUtils.databaseUtils.database;
    for (var entry in entries) {
      entry.folderId = _folder.id;
      await db.insert('entry', entry.toDbMap());
    }
    reload();
  }

  void updateEntry(Entry entry) async {
    entry.folderId = _folder.id;
    var db = await DatabaseUtils.databaseUtils.database;
    await db.update('entry', entry.toDbMap());
    reload();
  }

  void deleteEntry(Entry entry) async {
    var db = await DatabaseUtils.databaseUtils.database;
    await db.delete('entry', where: 'folderId = ?', whereArgs: [_folder.id]);
    reload();
  }

  void reload() {
    DatabaseUtils.databaseUtils.database.then((db) {
      return db.query('entry', where: 'folderId = ?', whereArgs: [_folder.id]);
    }).then((rows) {
      _data.clear();
      _data.addAll(rows.map((row) => Entry.fromDbMap(row)).toList());
      _data.sortByDate();
      notifyListeners();
    });
  }
}
