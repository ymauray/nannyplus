import 'package:nannyplus/data/model/vacation_period.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vacation_period_repository.g.dart';

class VacationPeriodRepository {
  const VacationPeriodRepository._();

  FutureOr<void> create(String start, [String? end]) async {
    final database = await DatabaseUtil.instance;

    await database.insert(
      'vacation_period',
      VacationPeriod(
        start: start,
        end: end,
        sortOrder: 9999,
      ).toJson(),
    );
  }

  FutureOr<VacationPeriod> read(int id) async {
    final database = await DatabaseUtil.instance;
    final result = await database.query(
      'vacation_period',
      where: 'id = ?',
      whereArgs: [id],
    );
    return VacationPeriod.fromJson(result.first);
  }

  FutureOr<void> update(VacationPeriod period) async {
    final database = await DatabaseUtil.instance;
    await database.update(
      'vacation_period',
      period.toJson(),
      where: 'id = ?',
      whereArgs: [period.id],
    );
  }

  FutureOr<void> delete(int id) async {
    final database = await DatabaseUtil.instance;
    await database.delete(
      'vacation_period',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  FutureOr<List<VacationPeriod>> loadForYear(int year) async {
    final database = await DatabaseUtil.instance;
    final result = await database.query(
      'vacation_period',
      where: 'start LIKE ?',
      whereArgs: ['$year%'],
      orderBy: 'sortOrder',
    );
    return result.map(VacationPeriod.fromJson).toList();
  }

  FutureOr<List<VacationPeriod>> loadAll() async {
    final database = await DatabaseUtil.instance;
    final result = await database.query(
      'vacation_period',
      orderBy: 'sortOrder',
    );
    return result.map(VacationPeriod.fromJson).toList();
  }
}

@riverpod
VacationPeriodRepository vacationPeriodRepository(
  VacationPeriodRepositoryRef ref,
) {
  return const VacationPeriodRepository._();
}
