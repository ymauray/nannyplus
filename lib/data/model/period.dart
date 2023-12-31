import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'period.freezed.dart';

@freezed
class Period with _$Period {
  factory Period({
    required int childId,
    required String day,
    required TimeOfDay to,
    required TimeOfDay from,
    int? sortOrder,
    int? id,
  }) = _Period;

  const Period._();

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      id: json['id'] as int?,
      childId: json['childId'] as int,
      day: json['day'] as String,
      from: TimeOfDay(
        hour: json['hourFrom'] as int,
        minute: json['minuteFrom'] as int,
      ),
      to: TimeOfDay(
        hour: json['hourTo'] as int,
        minute: json['minuteTo'] as int,
      ),
      sortOrder: json['sortOrder'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'childId': childId,
        'day': day,
        'hourFrom': from.hour,
        'minuteFrom': from.minute,
        'hourTo': to.hour,
        'minuteTo': to.minute,
        'sortOrder': sortOrder ?? 0,
      };

  int compareTo(Period other) {
    if (_mapDay(day) != _mapDay(other.day)) {
      final ret = _mapDay(day).compareTo(_mapDay(other.day));
      return ret;
    }

    if (from.hour != other.from.hour) {
      final ret = from.hour.compareTo(other.from.hour);
      return ret;
    }

    if (from.minute != other.from.minute) {
      final ret = from.minute.compareTo(other.from.minute);
      return ret;
    }

    if (to.hour != other.to.hour) {
      final ret = to.hour.compareTo(other.to.hour);
      return ret;
    }

    final ret = to.minute.compareTo(other.to.minute);
    return ret;
  }

  int _mapDay(String day) {
    switch (day) {
      case 'monday':
        return 1;
      case 'tuesday':
        return 2;
      case 'wednesday':
        return 3;
      case 'thursday':
        return 4;
      case 'friday':
        return 5;
      case 'saturday':
        return 6;
      case 'sunday':
        return 7;
      default:
        return 9999;
    }
  }
}
