// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deduction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeductionImpl _$$DeductionImplFromJson(Map<String, dynamic> json) =>
    _$DeductionImpl(
      id: (json['id'] as num?)?.toInt(),
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      label: json['label'] as String,
      value: (json['value'] as num).toDouble(),
      type: json['type'] as String,
      periodicity: json['periodicity'] as String,
    );

Map<String, dynamic> _$$DeductionImplToJson(_$DeductionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sortOrder': instance.sortOrder,
      'label': instance.label,
      'value': instance.value,
      'type': instance.type,
      'periodicity': instance.periodicity,
    };
