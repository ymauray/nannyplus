import 'package:nannyplus/data/model/period.dart';
import 'package:nannyplus/data/model/schedule_color.dart';

class Schedule {
  Schedule({
    required this.childIds,
    required this.periods,
    required this.scheduleColors,
    required this.childrenNames,
  });

  final List<int> childIds;
  final List<Period> periods;
  final List<ScheduleColor> scheduleColors;
  final Map<int, String> childrenNames;

  List<Period> periodsByDay(String day) {
    return periods.where((period) => period.day == day.toLowerCase()).toList();
  }
}
