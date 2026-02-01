// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Planning _$PlanningFromJson(Map<String, dynamic> json) => _Planning(
  id: (json['id'] as num).toInt(),
  planningStart: json['planningStart'] as String?,
  planningEnd: json['planningEnd'] as String?,
);

Map<String, dynamic> _$PlanningToJson(_Planning instance) => <String, dynamic>{
  'id': instance.id,
  'planningStart': instance.planningStart,
  'planningEnd': instance.planningEnd,
};
