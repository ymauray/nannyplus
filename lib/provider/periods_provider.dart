import 'package:flutter/material.dart';
import 'package:nannyplus/data/model/period.dart';
import 'package:nannyplus/provider/repository/periods_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'periods_provider.g.dart';

@riverpod
class Periods extends _$Periods {
  @override
  FutureOr<List<Period>> build(int childId) async {
    final repository = ref.read(periodsRepositoryProvider);
    await repository.sortPeriods(childId);
    return repository.load(childId);
  }

  FutureOr<void> add() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(periodsRepositoryProvider);
      await repository.createPeriod(
        childId,
        '',
        const TimeOfDay(hour: 0, minute: 0),
        const TimeOfDay(hour: 0, minute: 0),
        9999,
      );
      return repository.load(childId);
    });
  }

  FutureOr<void> updateTime(int periodId, bool from, TimeOfDay? time) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(periodsRepositoryProvider);
      final period = await repository.readPeriod(periodId);
      final updatedPeriod =
          from ? period.copyWith(from: time!) : period.copyWith(to: time!);
      await repository.updatePeriod(updatedPeriod);
      return repository.load(childId);
    });
  }

  FutureOr<void> updateDay(int periodId, String day) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(periodsRepositoryProvider);
      final period = await repository.readPeriod(periodId);
      final updatedPeriod = period.copyWith(day: day);
      await repository.updatePeriod(updatedPeriod);
      return repository.load(childId);
    });
  }

  FutureOr<void> delete(int periodId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(periodsRepositoryProvider);
      await repository.deletePeriod(periodId);
      return repository.load(childId);
    });
  }
}
