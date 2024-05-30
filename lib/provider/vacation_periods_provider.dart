import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/vacation_period.dart';
import 'package:nannyplus/data/repository/vacation_period_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vacation_periods_provider.g.dart';

@riverpod
class VacationPeriods extends _$VacationPeriods {
  @override
  Future<List<VacationPeriod>> build(int year) async {
    final vacationPeriodRepository = ref.read(vacationPeriodRepositoryProvider);
    final periods = await vacationPeriodRepository.loadForYear(year);
    periods.sort((a, b) => a.start.compareTo(b.start));

    return periods;
  }

  FutureOr<void> sort() async {
    // sort all periods, regardless of year
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final now = DateTime.now();
    final startOfYear = dateFormatter.format(DateTime(now.year));
    final vacationPeriodRepository = ref.read(vacationPeriodRepositoryProvider);
    final periods = await vacationPeriodRepository.loadAll();
    final pastPeriods = periods.where((period) {
      final date = period.end ?? period.start;
      return date.compareTo(startOfYear) < 0;
    }).toList();
    const sortOrder = 0;
    final sortedPeriodsByStartThenEnd = periods
      ..sort((a, b) {
        final startComparison = a.start.compareTo(b.start);
        if (startComparison != 0) {
          return startComparison;
        }
        if (a.end == null) {
          return -1;
        }
        if (b.end == null) {
          return 1;
        }
        return a.end!.compareTo(b.end!);
      });
  }
}
