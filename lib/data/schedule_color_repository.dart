import 'package:flutter/material.dart';
import 'package:nannyplus/utils/database_util.dart';

class ScheduleColorRepository {
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
}
