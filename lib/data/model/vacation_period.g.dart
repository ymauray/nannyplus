// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VacationPeriodImpl _$$VacationPeriodImplFromJson(Map<String, dynamic> json) =>
    _$VacationPeriodImpl(
      sortOrder: json['sortOrder'] as int,
      start: json['start'] as String,
      id: json['id'] as int?,
      end: json['end'] as String?,
    );

Map<String, dynamic> _$$VacationPeriodImplToJson(
        _$VacationPeriodImpl instance) =>
    <String, dynamic>{
      'sortOrder': instance.sortOrder,
      'start': instance.start,
      'id': instance.id,
      'end': instance.end,
    };
