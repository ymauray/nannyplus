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
    await db.insert('children', child.toMap());
    var created =
        await db.query('children', where: 'id = ?', whereArgs: [child.id]);
    return Child.fromMap(created.first);
  }
}
