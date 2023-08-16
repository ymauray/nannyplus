// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deduction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Deduction _$$_DeductionFromJson(Map<String, dynamic> json) => _$_Deduction(
      id: json['id'] as int?,
      sortOrder: json['sortOrder'] as int?,
      label: json['label'] as String,
      value: (json['value'] as num).toDouble(),
      type: json['type'] as String,
      periodicity: json['periodicity'] as String,
    );

Map<String, dynamic> _$$_DeductionToJson(_$_Deduction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sortOrder': instance.sortOrder,
      'label': instance.label,
      'value': instance.value,
      'type': instance.type,
      'periodicity': instance.periodicity,
    };
