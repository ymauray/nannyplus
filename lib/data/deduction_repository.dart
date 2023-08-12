import 'package:nannyplus/data/model/deduction.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deduction_repository.g.dart';

class DeductionRepository {
  FutureOr<List<Deduction>> readAll() async {
    final db = await DatabaseUtil.instance;
    final rows = await db.query(
      'deductions',
      orderBy: 'sortOrder ASC',
    );
    return rows.map(Deduction.fromJson).toList();
  }

  FutureOr<Deduction> read(int id) async {
    final db = await DatabaseUtil.instance;
    final rows = await db.query(
      'deductions',
      where: 'id = ?',
      whereArgs: [id],
    );
    return Deduction.fromJson(rows.first);
  }

  FutureOr<Deduction> create(Deduction deduction) async {
    final db = await DatabaseUtil.instance;
    final id = await db.insert(
      'deductions',
      deduction.copyWith(sortOrder: 999999).toJson(),
    );
    reorder();

    return read(id);
  }

  FutureOr<void> delete(Deduction deduction) async {
    final db = await DatabaseUtil.instance;
    await db.delete(
      'deductions',
      where: 'id = ?',
      whereArgs: [deduction.id],
    );
    reorder();
  }

  FutureOr<void> reorder({int oldIndex = -1, int newIndex = -1}) async {
    final db = await DatabaseUtil.instance;
    final rows = await db.query(
      'deductions',
      orderBy: 'sortOrder ASC',
    );
    final deductions = rows.map(Deduction.fromJson).toList();

    if (oldIndex > -1) {
      final deduction = deductions.removeAt(oldIndex);
      if (newIndex > oldIndex) {
        newIndex--;
      }
      deductions.insert(newIndex, deduction);
    }

    for (var i = 0; i < deductions.length; i++) {
      await db.update(
        'deductions',
        deductions[i].copyWith(sortOrder: i + 1).toJson(),
        where: 'id = ?',
        whereArgs: [deductions[i].id],
      );
    }
  }
}

@riverpod
DeductionRepository deductionRepository(DeductionRepositoryRef ref) {
  return DeductionRepository();
}
