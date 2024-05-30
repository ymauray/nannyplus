// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanningImpl _$$PlanningImplFromJson(Map<String, dynamic> json) =>
    _$PlanningImpl(
      id: (json['id'] as num).toInt(),
      planningStart: json['planningStart'] as String?,
      planningEnd: json['planningEnd'] as String?,
    );

Map<String, dynamic> _$$PlanningImplToJson(_$PlanningImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'planningStart': instance.planningStart,
      'planningEnd': instance.planningEnd,
    };
