import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimeOfDayJsonConverter extends JsonConverter<TimeOfDay, List<int>> {
  const TimeOfDayJsonConverter();

  @override
  TimeOfDay fromJson(List<int> json) {
    return TimeOfDay(hour: json[0], minute: json[1]);
  }

  @override
  List<int> toJson(TimeOfDay object) {
    return [object.hour, object.minute];
  }
}
