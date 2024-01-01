import 'package:flutter/material.dart';
import 'package:nannyplus/data/model/schedule_color.dart';
import 'package:nannyplus/utils/database_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_color_repository.g.dart';

class ScheduleColorRepository {
  const ScheduleColorRepository._();

  Future<Color> createColor(int childId, Color color) async {
    final database = await DatabaseUtil.instance;
    await database.insert(
      'schedule_colors',
      {'childId': childId, 'color': color.value},
    );
    return color;
  }

  Future<Color> readColor(int childId) async {
    final database = await DatabaseUtil.instance;
    final rows = await database.query(
      'schedule_colors',
      where: 'childId = ?',
      whereArgs: [childId],
    );

    if (rows.isEmpty) {
      await createColor(childId, Colors.purple);
      return Colors.purple;
    }

    return Color(rows.first['color'] as int);
  }

  Future<void> updateColor(int childId, Color selectedColor) async {
    final database = await DatabaseUtil.instance;
    await database.update(
      'schedule_colors',
      {'color': selectedColor.value},
      where: 'childId = ?',
      whereArgs: [childId],
    );
  }

  Future<List<ScheduleColor>> readScheduleColors() async {
    final database = await DatabaseUtil.instance;
    final rows = await database.query('schedule_colors');
    final colors = rows.map(ScheduleColor.fromJson).toList();

    return colors;
  }
}

@riverpod
ScheduleColorRepository scheduleColorRepository(
  ScheduleColorRepositoryRef ref,
) {
  return const ScheduleColorRepository._();
}
