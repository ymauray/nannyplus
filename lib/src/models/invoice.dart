import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/src/models/folder.dart';
import 'package:nannyplus/src/utils/database_utils.dart';

class Invoice {
  Invoice.create(this.number, this.date, this.parents, this.address);

  Invoice.empty();

  int? id;
  int? folderId;
  int? number;
  DateTime? date;
  double? total;
  String? parents;
  String? address;

  Invoice.fromDbMap(Map<String, Object?> row)
      : id = row['id'] as int,
        folderId = row['folderId'] as int,
        number = row['folderId'] as int,
        date =
            row['date'] == null ? null : DateTime.parse(row['date'] as String),
        total = row['total'] as double?,
        parents = row['parents'] as String,
        address = row['address'] as String;

  Invoice.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        number = json['number'],
        date = DateTime.parse(json['date']),
        total = 1.0 * json['total'],
        parents = json['parentsName'],
        address = json['address'];

  Map<String, Object?> toDbMap() {
    return {
      'folderId': folderId,
      'number': number,
      'date': date == null ? null : DateFormat('yyyy-MM-dd').format(date!),
      'total': total,
      'parents': parents,
      'address': address,
    };
  }
}

extension EntriesExt on List<Invoice> {
  sortByDate() {
    sort((a, b) => b.date!.isBefore(a.date!) ? -1 : 1);
  }
}

class Invoices extends ChangeNotifier {
  Invoices.load(Folder folder) : _folder = folder {
    reload();
  }

  final _data = <Invoice>[];
  final Folder _folder;

  List<Invoice> get data => UnmodifiableListView(_data);

  Future<Invoice> createInvoice(Invoice invoice) async {
    invoice.folderId = _folder.id;
    var db = await DatabaseUtils.databaseUtils.database;
    var id = await db.insert('invoice', invoice.toDbMap());
    invoice.id = id;
    reload();
    return invoice;
  }

  void reload() {
    DatabaseUtils.databaseUtils.database.then((db) {
      return db
          .query('invoice', where: 'folderId = ?', whereArgs: [_folder.id]);
    }).then((rows) {
      _data.clear();
      _data.addAll(rows.map((row) => Invoice.fromDbMap(row)).toList());
      _data.sortByDate();
      notifyListeners();
    });
  }
}
