import 'package:nannyplus/data/schedule_color_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_color_repository_provider.g.dart';

@riverpod
ScheduleColorRepository scheduleColorRepository(
  ScheduleColorRepositoryRef ref,
) {
  return ScheduleColorRepository();
}
