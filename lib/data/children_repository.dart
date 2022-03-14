import 'package:nannyplus/utils/database_util.dart';

import 'model/child.dart';

class ChildrenRepository {
  const ChildrenRepository();

  Future<List<Child>> getChildList() async {
    var db = await DatabaseUtil.instance;
    var rows = await db.query('children',
        where: 'archived = ?', whereArgs: [0], orderBy: 'firstName, lastName');
    return rows.map((row) => Child.fromMap(row)).toList();
  }

  Future<Child> create(Child child) async {
    var db = await DatabaseUtil.instance;
    var id = await db.insert('children', child.toMap());
    return read(id);
  }

  Future<Child> read(int id) async {
    var db = await DatabaseUtil.instance;
    var child = await db.query('children', where: 'id = ?', whereArgs: [id]);
    return Child.fromMap(child.first);
  }

  Future<Child> update(Child child) async {
    var db = await DatabaseUtil.instance;
    await db.update('children', child.toMap(),
        where: 'id = ?', whereArgs: [child.id]);
    return read(child.id!);
  }
}
