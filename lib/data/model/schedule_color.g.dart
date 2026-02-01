// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScheduleColor _$ScheduleColorFromJson(Map<String, dynamic> json) =>
    _ScheduleColor(
      id: (json['id'] as num).toInt(),
      childId: (json['childId'] as num).toInt(),
      color: (json['color'] as num).toInt(),
    );

Map<String, dynamic> _$ScheduleColorToJson(_ScheduleColor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'childId': instance.childId,
      'color': instance.color,
    };
