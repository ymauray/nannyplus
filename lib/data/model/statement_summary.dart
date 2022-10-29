import 'dart:convert';

import 'package:flutter/widgets.dart';

@immutable
class StatementSummary {
  const StatementSummary({
    required this.month,
    required this.total,
  });
  factory StatementSummary.fromJson(String source) =>
      StatementSummary.fromMap(json.decode(source));

  factory StatementSummary.fromMap(Map<String, dynamic> map) {
    return StatementSummary(
      month: map['month'] ?? '',
      total: map['total']?.toDouble() ?? 0.0,
    );
  }
  final String month;
  final double total;

  StatementSummary copyWith({
    String? month,
    double? total,
  }) {
    return StatementSummary(
      month: month ?? this.month,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'total': total,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'StatementSummary(month: $month, total: $total)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatementSummary &&
        other.month == month &&
        other.total == total;
  }

  @override
  int get hashCode => month.hashCode ^ total.hashCode;
}
