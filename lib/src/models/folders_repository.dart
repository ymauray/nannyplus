import 'package:nannyplus/src/utils/database_utils.dart';

import 'folder.dart';

class FoldersRepository {
  Future<List<Folder>> getFolders(bool showArchives) async {
    var database = await DatabaseUtils.databaseUtils.database;
    var rows = await database.query('folder');
    var folders = rows.map((row) => Folder.fromDbMap(row));
    if (!showArchives) {
      folders = folders.where((folder) => !(folder.archived ?? false));
    }
    return folders.toList();
  }
}
