import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart';

class DatabaseUtil {
  static sqlite.Database? _database;

  DatabaseUtil._();

  static Future<String> get _databasePath async =>
      join(await sqlite.getDatabasesPath(), 'childcare.db');

  static Future<void> deleteDatabase() async {
    await sqlite.deleteDatabase(await _databasePath);
    _database?.close();
    _database = null;
  }

  static Future<sqlite.Database> get instance async {
    if (_database != null) return _database!;

    _database = await sqlite.openDatabase(
      await _databasePath,
      version: 1,
      onCreate: (db, version) {
        _create(db);
        for (var i = 2; i <= version; i++) {
          _upgradeTo(i, db);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) {
        for (var i = oldVersion + 1; i <= newVersion; i++) {
          _upgradeTo(i, db);
        }
      },
      onDowngrade: (db, oldVersion, newVersion) =>
          throw Exception('Downgrade not supported'),
    );

    return _database!;
  }

  static void _create(sqlite.Database db) async {
    await db.execute('''
      CREATE TABLE children (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        firstName TEXT NOT NULL,
        lastName TEXT,
        phoneNumber TEXT,
        alergies TEXT,
        parentsName TEXT,
        address TEXT,
        archived INTEGER NOT NULL DEFAULT 0
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
        isFixedPrice INTEGER,
        hours INTEGER,
        minutes INTEGER,
        price DOUBLE,
        invoiced INTEGER,
        invoiceId INTEGER
      )
      ''');
  }

  static void _upgradeTo(int version, sqlite.Database db) async {}
}
