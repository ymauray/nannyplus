import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/prestation.dart';

import 'database_util.dart';

class PrestationsRepository {
  const PrestationsRepository();

  static int _id = 0;

  Future<Prestation> create(Prestation prestation) async {
    var db = await DatabaseUtil.instance;
    var p = prestation.copyWith(id: ++_id);
    await db.insert('prestations', p.toMap());
    var created =
        await db.query('prestations', where: 'id = ?', whereArgs: [p.id]);
    return Prestation.fromMap(created.first);
  }

  Future<List<Prestation>> getPrestations(Child child) async {
    var db = await DatabaseUtil.instance;

    var rows = await db.query('prestations',
        where: 'childId = ? AND invoiced = ?',
        whereArgs: [child.id, 0],
        orderBy: 'date DESC');
    return rows.map((e) => Prestation.fromMap(e)).toList();
  }
}
