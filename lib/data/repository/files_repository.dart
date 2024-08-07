import 'dart:typed_data';

import 'package:nannyplus/data/model/document.dart';
import 'package:nannyplus/utils/database_util.dart';

class FilesRepository {
  const FilesRepository();

  Future<int> addFile(int childId, String label, Uint8List bytes) async {
    final db = await DatabaseUtil.instance;

    final id = await db.insert('documents', {
      'childId': childId,
      'label': label,
      'path': '',
      'bytes': bytes,
    });

    return id;
  }

  Future<Iterable<Document>> getFiles(int childId) async {
    final db = await DatabaseUtil.instance;
    final rows = await db.query(
      'documents',
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'label',
    );

    return rows.map(Document.fromMap);
  }

  Future<void> removeFile(Document document) async {
    final db = await DatabaseUtil.instance;
    await db.delete('documents', where: 'id = ?', whereArgs: [document.id]);
  }

  Future<void> editFile(Document file, String newLabel) async {
    final db = await DatabaseUtil.instance;
    await db.update(
      'documents',
      {'label': newLabel},
      where: 'id = ?',
      whereArgs: [file.id],
    );
  }
}
