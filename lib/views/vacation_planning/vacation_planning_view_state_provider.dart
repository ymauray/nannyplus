import 'package:nannyplus/data/model/vacation_period.dart';
import 'package:nannyplus/data/repository/vacation_period_repository.dart';
import 'package:nannyplus/views/vacation_planning/vacation_planning_view_state.dart'
    as view;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vacation_planning_view_state_provider.g.dart';

@riverpod
class VacationPlanningViewState extends _$VacationPlanningViewState {
  @override
  FutureOr<view.VacationPlanningViewState> build() async {
    return await load(DateTime.now().year);
  }

  FutureOr<view.VacationPlanningViewState> load(int year) async {
    final vacationPeriodRepository = ref.read(vacationPeriodRepositoryProvider);
    final periods = await vacationPeriodRepository.loadForYear(year);
    return view.VacationPlanningViewState(
      year: year,
      periods: periods,
    );
  }

  FutureOr<void> decrement() async {
    state =
        await AsyncValue.guard(() async => load(state.requireValue.year - 1));
  }

  FutureOr<void> reset() async {
    state = await AsyncValue.guard(() async => load(DateTime.now().year));
  }

  FutureOr<void> increment() async {
    state =
        await AsyncValue.guard(() async => load(state.requireValue.year + 1));
  }

  FutureOr<void> addPeriod(String lastDay) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final vacationPeriodRepository =
          ref.read(vacationPeriodRepositoryProvider);
      await vacationPeriodRepository.create(lastDay);
      return load(state.requireValue.year);
    });
  }

  Future<void> duplicatePeriod(VacationPeriod period) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final vacationPeriodRepository =
          ref.read(vacationPeriodRepositoryProvider);
      await vacationPeriodRepository.create(period.start, period.end);
      return load(state.requireValue.year);
    });
  }

  FutureOr<void> deletePeriod(VacationPeriod period) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final vacationPeriodRepository =
          ref.read(vacationPeriodRepositoryProvider);
      await vacationPeriodRepository.delete(period.id!);
      return load(state.requireValue.year);
    });
  }

  Future<void> setPeriodEnd(int index, String? end) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final period = state.requireValue.periods[index];
      final vacationPeriodRepository =
          ref.read(vacationPeriodRepositoryProvider);
      var newPeriod = period.copyWith(end: end);
      if (end != null && newPeriod.start.compareTo(end) > 0) {
        newPeriod = newPeriod.copyWith(start: end);
      }
      await vacationPeriodRepository.update(newPeriod);
      return load(state.requireValue.year);
    });
  }

  Future<void> setPeriodStart(int index, String start) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final period = state.requireValue.periods[index];
      final vacationPeriodRepository =
          ref.read(vacationPeriodRepositoryProvider);
      var newPeriod = period.copyWith(start: start);
      if (period.end != null && period.end!.compareTo(start) < 0) {
        newPeriod = newPeriod.copyWith(end: start);
      }
      await vacationPeriodRepository.update(newPeriod);
      return load(state.requireValue.year);
    });
  }

  FutureOr<void> sort() async {
    final mutablePeriods = List<VacationPeriod>.from(state.requireValue.periods)
      ..sort((a, b) {
        final aStart = a.start;
        final bStart = b.start;
        final aCompare = aStart.compareTo(bStart);
        if (aCompare != 0) {
          return aCompare;
        }
        final aEnd = a.end;
        final bEnd = b.end;
        if (aEnd == null && bEnd == null) {
          return 0;
        }
        if (aEnd == null) {
          return -1;
        }
        if (bEnd == null) {
          return 1;
        }
        return aEnd.compareTo(bEnd);
      });
    // update period with sortOrder
    var sortOrder = 0;

    for (final period in mutablePeriods) {
      final newPeriod = period.copyWith(sortOrder: sortOrder++);
      await ref.read(vacationPeriodRepositoryProvider).update(newPeriod);
    }
  }
}
