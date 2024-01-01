import 'package:nannyplus/data/repository/periods_repository.dart' as data;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'periods_repository_provider.g.dart';

@riverpod
class PeriodsRepository extends _$PeriodsRepository {
  @override
  data.PeriodRepository build() {
    return data.PeriodRepository();
  }
}
