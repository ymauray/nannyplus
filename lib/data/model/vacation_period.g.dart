// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VacationPeriod _$VacationPeriodFromJson(Map<String, dynamic> json) =>
    _VacationPeriod(
      sortOrder: (json['sortOrder'] as num).toInt(),
      start: json['start'] as String,
      id: (json['id'] as num?)?.toInt(),
      end: json['end'] as String?,
    );

Map<String, dynamic> _$VacationPeriodToJson(_VacationPeriod instance) =>
    <String, dynamic>{
      'sortOrder': instance.sortOrder,
      'start': instance.start,
      'id': instance.id,
      'end': instance.end,
    };
