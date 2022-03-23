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
  }

  static void _upgradeTo(int version, sqlite.Database db) async {
    /* Not implemented yet */
  }
}
