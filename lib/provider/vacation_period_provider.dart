import 'package:nannyplus/data/model/vacation_period.dart';
import 'package:nannyplus/data/repository/vacation_period_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vacation_period_provider.g.dart';

@riverpod
class VacationPeriods extends _$VacationPeriods {
  @override
  Future<List<VacationPeriod>> build(int year) async {
    final vacationPeriodRepository = ref.read(vacationPeriodRepositoryProvider);
    final periods = await vacationPeriodRepository.loadForYear(year);
    periods.sort((a, b) => a.start.compareTo(b.start));

    return periods;
  }
}
