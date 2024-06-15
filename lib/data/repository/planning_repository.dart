import 'package:nannyplus/data/model/planning.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'planning_repository.g.dart';

class PlanningRepository {
  PlanningRepository._();

  FutureOr<List<Planning>> load() async {
    final database = await DatabaseUtil.instance;
    final rows = await database.query('planning');
    rows.sort((a, b) {
      final aStart = a['planningStart'] as String?;
      final bStart = b['planningStart'] as String?;
      if (aStart == null && bStart != null) {
        return 1;
      }
      if (aStart != null && bStart == null) {
        return -1;
      }
      if (aStart == null && bStart == null) {
        return 0;
      }
      return aStart!.compareTo(bStart!);
    });
    return rows.map(Planning.fromJson).toList();
  }
}

@riverpod
PlanningRepository planningRepository(PlanningRepositoryRef ref) {
  return PlanningRepository._();
}
