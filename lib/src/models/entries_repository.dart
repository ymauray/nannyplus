import '../utils/database_utils.dart';

import 'entry.dart';

class EntriesRepository {
  Future<List<Entry>> getEntries(int folderId) async {
    var database = await DatabaseUtils.databaseUtils.database;
    var rows = await database
        .query('entry', where: 'folderId = ?', whereArgs: [folderId]);
    var entries = rows.map((entry) => Entry.fromDbMap(entry));
    return entries.toList();
  }
}
