import 'package:nannyplus/views/weekly_schedule/weekly_schedule_view_state.dart'
    as s;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_schedule_view_state_provider.g.dart';

@riverpod
class WeeklyScheduleViewState extends _$WeeklyScheduleViewState {
  @override
  s.WeeklyScheduleViewState build() {
    return const s.WeeklyScheduleViewState(index: 0);
  }

  void nextDay() {
    state = state.copyWith(
      index: (state.index + 1) % s.WeeklyScheduleViewState.days.length,
    );
  }

  void previousDay() {
    state = state.copyWith(
      index: (state.index - 1) % s.WeeklyScheduleViewState.days.length,
    );
  }
}
