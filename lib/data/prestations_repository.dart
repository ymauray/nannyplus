import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/prestation.dart';

import '../utils/database_util.dart';

class PrestationsRepository {
  const PrestationsRepository();

  Future<Prestation> create(Prestation prestation) async {
    var db = await DatabaseUtil.instance;
    var id = await db.insert('prestations', prestation.toMap());
    return read(id);
  }

  Future<Prestation> read(int id) async {
    var db = await DatabaseUtil.instance;
    var prestation =
        await db.query('prestations', where: 'id = ?', whereArgs: [id]);
    return Prestation.fromMap(prestation.first);
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
