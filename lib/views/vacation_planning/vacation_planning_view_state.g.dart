// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_planning_view_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VacationPlanningViewStateImpl _$$VacationPlanningViewStateImplFromJson(
        Map<String, dynamic> json) =>
    _$VacationPlanningViewStateImpl(
      year: json['year'] as int,
      periods: (json['periods'] as List<dynamic>)
          .map((e) => VacationPeriod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VacationPlanningViewStateImplToJson(
        _$VacationPlanningViewStateImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'periods': instance.periods,
    };
