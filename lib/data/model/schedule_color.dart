import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_color.freezed.dart';
part 'schedule_color.g.dart';

@freezed
class ScheduleColor with _$ScheduleColor {
  factory ScheduleColor({
    required int id,
    required int childId,
    required int color,
  }) = _ScheduleColor;

  factory ScheduleColor.fromJson(Map<String, dynamic> json) =>
      _$ScheduleColorFromJson(json);
}
