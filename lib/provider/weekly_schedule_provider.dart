import 'package:nannyplus/data/model/schedule.dart';
import 'package:nannyplus/data/repository/children_repository.dart';
import 'package:nannyplus/data/repository/schedule_color_repository.dart';
import 'package:nannyplus/data/repository/schedule_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_schedule_provider.g.dart';

@riverpod
Future<Schedule> weeklySchedule(WeeklyScheduleRef ref) async {
  final scheduleRepository = ref.read(scheduleRepositoryProvider);
  final periods = await scheduleRepository.readPeriods();

  final childIds = periods.fold(<int>{}, (value, element) {
    value.add(element.childId);
    return value;
  }).toList();

  final scheduleColorRepository = ref.read(scheduleColorRepositoryProvider);
  final scheduleColors = await scheduleColorRepository.readScheduleColors();

  final childrenRepository = ref.read(childrenRepositoryProvider);
  final childrenNames = await childrenRepository.readChildrenNGrams();

  final schedule = Schedule(
    childIds: childIds,
    periods: periods,
    scheduleColors: scheduleColors,
    childrenNames: childrenNames,
  );

  return schedule;
}
