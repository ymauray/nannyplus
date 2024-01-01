import 'package:nannyplus/data/model/period.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_repository.g.dart';

class ScheduleRepository {
  const ScheduleRepository._();

  FutureOr<List<Period>> readPeriods() async {
    final database = await DatabaseUtil.instance;
    final rows = await database.query('periods');
    final periods = rows.map(Period.fromJson).toList();

    return periods;
  }
}

@riverpod
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) {
  return const ScheduleRepository._();
}
