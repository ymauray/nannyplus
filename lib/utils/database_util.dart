import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/utils/font_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import 'prefs_util.dart';

class DatabaseUtil {
  static sqlite.Database? _database;

  DatabaseUtil._();

  static Future<String> get _databasePath async =>
      join(await sqlite.getDatabasesPath(), 'childcare.db');

  static closeDatabase() async {
    await _database?.close();
    _database = null;
  }

  static Future<void> deleteDatabase() async {
    await closeDatabase();
    await sqlite.deleteDatabase(await _databasePath);
  }

  static Future<void> clear() async {
    await _database?.delete('children');
    await _database?.delete('prices');
    await _database?.delete('services');
    await _database?.delete('invoices');
  }

  static Future<String> get databasePath async => await _databasePath;

  static Future<sqlite.Database> get instance async {
    if (_database != null) return _database!;

    _database = await sqlite.openDatabase(
      await _databasePath,
      version: 3,
      onCreate: (db, version) async {
        await _create(db);
        for (var i = 2; i <= version; i++) {
          _upgradeTo(i, db);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (var i = oldVersion + 1; i <= newVersion; i++) {
          _upgradeTo(i, db);
        }
      },
      onDowngrade: (db, oldVersion, newVersion) async {
        throw Exception('Downgrade not supported');
      },
    );

    return _database!;
  }

  static Future<void> _create(sqlite.Database db) async {
    final locale = WidgetsBinding.instance!.window.locale;
    final GettextLocalizations gettext =
        await GettextLocalizationsDelegate().load(locale);

    await db.execute('''
      CREATE TABLE children (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        firstName TEXT NOT NULL,
        lastName TEXT,
        birthdate TEXT,
        phoneNumber TEXT,
        allergies TEXT,
        parentsName TEXT,
        address TEXT,
        archived INTEGER NOT NULL DEFAULT 0,
        preschool INTEGER NOT NULL DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE prices(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        label TEXT,
        amount DOUBLE,
        fixedPrice INTEGER
      )
      ''');

    await db.execute('''
      CREATE TABLE services(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        childId INTEGER NOT NULL,
        date TEXT,
        priceId INTEGER NOT NULL,
        priceLabel TEXT,
        priceAmount DOUBLE,
        isFixedPrice INTEGER,
        hours INTEGER,
        minutes INTEGER,
        total DOUBLE,
        invoiced INTEGER,
        invoiceId INTEGER
      )
      ''');

    await db.execute('''
      CREATE TABLE invoices(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        number INTEGER NOT NULL,
        childId INTEGER NOT NULL,
        date TEXT,
        total DOUBLE NOT NULL,
        parentsName TEXT NOT NULL,
        address TEXT NOT NULL
      )
      ''');

    await insertSampleData(db, gettext);
  }

  static Future<void> insertSampleData(
    sqlite.Database db,
    GettextLocalizations gettext,
  ) async {
    // Sample data for the first time user

    await insertSamplePrices(db, gettext);

    await insertSampleChildren(db, gettext);

    await insertSampleServices(db, gettext);

    await insertSampleInvoice(db, gettext);

    var prefsUtil = await PrefsUtil.getInstance();
    await prefsUtil.clear();
    prefsUtil.line1 = "Nanny+";
    prefsUtil.line1FontFamily = FontUtils.defaultFontItem.family;
    prefsUtil.line1FontAsset = FontUtils.defaultFontItem.asset;
    prefsUtil.line2 = gettext.t("Your name", null);
    prefsUtil.line2FontFamily = FontUtils.defaultFontItem.family;
    prefsUtil.line2FontAsset = FontUtils.defaultFontItem.asset;
    prefsUtil.conditions =
        gettext.t("Payment within 10 day via bank transfert", null);
    prefsUtil.bankDetails = gettext.t("Bank : {0}", ["Monopoly"]) +
        "\n" +
        gettext.t("IBAN : {0}", ["XY7900123456789"]);
    prefsUtil.address = "Boldistrasse 97\n2560 Nidau";

    var image = await rootBundle.load("assets/img/logo.png");
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    var appDocumentsPath = appDocumentsDirectory.path;
    var filePath = '$appDocumentsPath/logo';
    File(filePath).writeAsBytesSync(
      image.buffer.asUint8List(),
      flush: true,
      mode: FileMode.write,
    );
  }

  static Future<void> insertSampleInvoice(
    sqlite.Database db,
    GettextLocalizations gettext,
  ) async {
    await db.insert('invoices', {
      'number': 1,
      'childId': 1,
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'total': 43,
      'parentsName': "Manon et Robet Simon",
      'address': "Höhenweg 136\n8888 Heiligkreuz",
    });
  }

  // ignore: long-method
  static Future<void> insertSampleServices(
    sqlite.Database db,
    GettextLocalizations gettext,
  ) async {
    await db.insert("services", {
      "childId": 1,
      "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
      "priceId": 1,
      "priceLabel": gettext.t("Example {0}", [1]),
      "priceAmount": 5.0,
      "isFixedPrice": 1,
      "hours": 0,
      "minutes": 0,
      "total": 5.0,
      "invoiced": 0,
      "invoiceId": null,
    });

    await db.insert("services", {
      "childId": 1,
      "date": DateFormat("yyyy-MM-dd")
          .format(DateTime.now().subtract(const Duration(days: 7))),
      "priceId": 1,
      "priceLabel": gettext.t("Example {0}", [2]),
      "priceAmount": 7.0,
      "isFixedPrice": 1,
      "hours": 0,
      "minutes": 0,
      "total": 7.0,
      "invoiced": 1,
      "invoiceId": 1,
    });

    await db.insert("services", {
      "childId": 1,
      "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
      "priceId": 1,
      "priceLabel": gettext.t("Example {0}", [3]),
      "priceAmount": 7.0,
      "isFixedPrice": 0,
      "hours": 3,
      "minutes": 15,
      "total": 22.75,
      "invoiced": 0,
      "invoiceId": 0,
    });

    await db.insert("services", {
      "childId": 1,
      "date": DateFormat("yyyy-MM-dd")
          .format(DateTime.now().subtract(const Duration(days: 6))),
      "priceId": 1,
      "priceLabel": gettext.t("Example {0}", [4]),
      "priceAmount": 8.0,
      "isFixedPrice": 0,
      "hours": 4,
      "minutes": 30,
      "total": 36.00,
      "invoiced": 1,
      "invoiceId": 1,
    });
  }

  static Future<void> insertSampleChildren(
    sqlite.Database db,
    GettextLocalizations gettext,
  ) async {
    await db.insert("children", {
      "firstName": "Fabienne",
      "lastName": "Simon (Example)",
      "birthdate": "2014-08-01",
      "phoneNumber": "+41329866242",
      "allergies": gettext.t("Peanuts", null),
      "parentsName": "Manon et Robert Simon",
      "address": "Höhenweg 136\n8888 Heiligkreuz",
      "archived": 0,
      "preschool": 0,
    });
  }

  static Future<void> insertSamplePrices(
    sqlite.Database db,
    GettextLocalizations gettext,
  ) async {
    await db.insert("prices", {
      "label": gettext.t("Example {0}", [1]),
      "amount": 5.0,
      "fixedPrice": 1,
    });

    await db.insert("prices", {
      "label": gettext.t("Example {0}", [2]),
      "amount": 7.0,
      "fixedPrice": 1,
    });

    await db.insert("prices", {
      "label": gettext.t("Example {0}", [3]),
      "amount": 7.0,
      "fixedPrice": 0,
    });

    await db.insert("prices", {
      "label": gettext.t("Example {0}", [4]),
      "amount": 8.0,
      "fixedPrice": 0,
    });
  }

  static void _upgradeTo(int version, sqlite.Database db) async {
    if (version == 2) {
      await db.execute('''
      ALTER TABLE children
      ADD labelForPhoneNumber2 TEXT
      ''');
      await db.execute('''
      ALTER TABLE children
      ADD phoneNumber2 TEXT
      ''');
      await db.execute('''
      ALTER TABLE children
      ADD labelForPhoneNumber3 TEXT
      ''');
      await db.execute('''
      ALTER TABLE children
      ADD phoneNumber3 TEXT
      ''');
      await db.execute('''
      ALTER TABLE children
      ADD freeText TEXT
      ''');
    }

    if (version == 3) {
      await db.execute('''
    ALTER TABLE prices
    ADD sortOrder INTEGER NOT NULL DEFAULT 0
    ''');

      var rows = await db.query('prices', orderBy: 'label ASC');
      var sortOrder = 1;
      for (var row in rows) {
        await db.update(
          'prices',
          {
            'sortOrder': sortOrder,
          },
          where: 'id = ?',
          whereArgs: [
            row['id'],
          ],
        );
        sortOrder += 1;
      }
    }
  }
}
