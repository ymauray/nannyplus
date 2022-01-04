import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqlite;

extension DbBoolExt on bool? {
  int? toDbInt() => this == null ? null : (this! ? 1 : 0);
}

extension DbObjectExt on Object? {
  bool? toBool() => this == null ? null : (this! == 1);
}

class DatabaseUtils {
  DatabaseUtils._();

  static final DatabaseUtils databaseUtils = DatabaseUtils._();
  sqlite.Database? _database;

  Future<String>? _path;
  Future<String> get _databasePath async =>
      _path ??
      (_path =
          Future.value(join(await sqlite.getDatabasesPath(), 'nannyplus.db')));

  Future<sqlite.Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await sqlite.openDatabase(await _databasePath,
        version: 1, onCreate: _create);

    return _database!;
  }

  Future<void> _create(sqlite.Database db, int version) async {
    await db.execute('''
        CREATE TABLE folder(
          id INTEGER PRIMARY KEY,
          firstName TEXT,
          lastName TEXT,
          birthDate TEXT,
          preSchool INTEGER,
          kinderGarden INTEGER,
          allergies TEXT,
          parentsName TEXT,
          address TEXT,
          phoneNumber TEXT,
          misc TEXT,
          archived INTEGER
        )
        ''');

    await db.execute('''
        CREATE TABLE entry(
          id INTEGER PRIMARY KEY,
          folderId INTEGER,
          date TEXT,
          total DOUBLE,
          hours INTEGER,
          minutes INTEGER,
          lunch INTEGER,
          diner INTEGER,
          night INTEGER,
          invoiceId INTEGER
        )
        ''');

    await db.execute('''
        CREATE TABLE invoice(
          id INTEGER PRIMARY KEY,
          folderId INTEGER,
          number INTEGER,
          date TEXT,
          total DOUBLE,
          parents TEXT,
          address TEXT
        )
    ''');
  }

  Future<void> deleteDatabase() async {
    if (_database != null) {
      _database!.close();
      _database = null;
    }
    sqlite.deleteDatabase(await _databasePath);
  }
}
