import 'package:nannyplus/data/model/document.dart';

import '../utils/database_util.dart';

class FilesRepository {
  const FilesRepository();

  Future<int> addFile(int childId, String label, String path) async {
    var db = await DatabaseUtil.instance;
    var id = await db.insert('documents', {
      'childId': childId,
      'label': label,
      'path': path,
    });

    return id;
  }

  Future<Iterable<Document>> getFiles(int childId) async {
    var db = await DatabaseUtil.instance;
    var rows = await db.query(
      'documents',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'label',
    );

    return rows.map((row) => Document.fromMap(row));
  }

  Future<void> removeFile(Document document) async {
    var db = await DatabaseUtil.instance;
    await db.delete('documents', where: 'id = ?', whereArgs: [document.id]);
  }

  Future<void> editFile(Document file, String newLabel) async {
    var db = await DatabaseUtil.instance;
    await db.update(
      'documents',
      {'label': newLabel},
      where: 'id = ?',
      whereArgs: [file.id],
    );
  }
}