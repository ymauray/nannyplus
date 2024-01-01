import 'package:flutter/material.dart';
import 'package:nannyplus/data/repository/schedule_color_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_color_provider.g.dart';

@riverpod
class ScheduleColor extends _$ScheduleColor {
  @override
  FutureOr<Color> build(int childId) async {
    final repository = ref.read(scheduleColorRepositoryProvider);
    final color = await repository.readColor(childId);
    return color;
  }

  Future<void> updateColor(Color selectedColor) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(scheduleColorRepositoryProvider);
      await repository.updateColor(childId, selectedColor);
      return selectedColor;
    });
  }
}
