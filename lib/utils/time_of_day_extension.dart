import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String formatTimeOfDay() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  int compareTo(TimeOfDay other) {
    if (hour == other.hour) {
      return minute.compareTo(other.minute);
    }
    return hour.compareTo(other.hour);
  }
}
