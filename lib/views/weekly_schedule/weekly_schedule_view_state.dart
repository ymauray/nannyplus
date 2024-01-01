import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_schedule_view_state.freezed.dart';

@freezed
class WeeklyScheduleViewState with _$WeeklyScheduleViewState {
  const factory WeeklyScheduleViewState({
    required int index,
  }) = _WeeklyScheduleViewState;

  const WeeklyScheduleViewState._();

  static const days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  String get day => days[index];
}
