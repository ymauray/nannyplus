import 'package:nannyplus/data/model/schedule.dart';
import 'package:nannyplus/data/repository/children_repository.dart';
import 'package:nannyplus/data/repository/schedule_color_repository.dart';
import 'package:nannyplus/data/repository/schedule_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_schedule_provider.g.dart';

@riverpod
Future<Schedule> weeklySchedule(WeeklyScheduleRef ref) async {
  final scheduleRepository = ref.read(scheduleRepositoryProvider);
  final childrenRepository = ref.read(childrenRepositoryProvider);

  final periods = await scheduleRepository.readPeriods();

  final childIds = periods.fold(<int>{}, (value, element) {
    value.add(element.childId);
    return value;
  }).toList();

  final childList = await childrenRepository.getChildList(false);

  final orderedChildIds = childList
      .where((child) => childIds.contains(child.id))
      .map((child) => child.id!)
      .toList();

  final scheduleColorRepository = ref.read(scheduleColorRepositoryProvider);
  final scheduleColors = await scheduleColorRepository.readScheduleColors();

  final childrenNames = await childrenRepository.readChildrenNGrams();

  final schedule = Schedule(
    childIds: orderedChildIds,
    periods: periods,
    scheduleColors: scheduleColors,
    childrenNames: childrenNames,
  );

  return schedule;
}
