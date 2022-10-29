import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:nannyplus/utils/prefs_util.dart';

class ChildrenRepository {
  const ChildrenRepository();

  Future<List<Child>> getChildList(bool showArchived) async {
    final db = await DatabaseUtil.instance;
    final prefs = await PrefsUtil.getInstance();

    final rows = await db.query(
      'children',
      where: 'archived <= ?',
      whereArgs: [if (showArchived) 1 else 0],
      orderBy: prefs.sortListByLastName
          ? 'lastName, firstName'
          : 'firstName, lastname',
    );

    return rows.map((row) => Child.fromMap(row)).toList();
  }

  Future<Child> create(Child child) async {
    final db = await DatabaseUtil.instance;
    final id = await db.insert('children', child.toMap());

    return read(id);
  }

  Future<Child> read(int id) async {
    final db = await DatabaseUtil.instance;
    final child = await db.query('children', where: 'id = ?', whereArgs: [id]);

    return Child.fromMap(child.first);
  }

  Future<Child> update(Child child) async {
    final db = await DatabaseUtil.instance;
    await db.update(
      'children',
      child.toMap(),
      where: 'id = ?',
      whereArgs: [child.id],
    );

    return await read(child.id!);
  }

  Future<void> delete(Child child) async {
    final db = await DatabaseUtil.instance;
    await db.delete('invoices', where: 'childId = ?', whereArgs: [child.id]);
    await db.delete('services', where: 'childId = ?', whereArgs: [child.id]);
    await db.delete('children', where: 'id = ?', whereArgs: [child.id]);
  }
}
