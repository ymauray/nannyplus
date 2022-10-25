import 'dart:convert';

class StatementSummary {
  String month;
  double total;
  StatementSummary({
    required this.month,
    required this.total,
  });

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

  factory StatementSummary.fromMap(Map<String, dynamic> map) {
    return StatementSummary(
      month: map['month'] ?? '',
      total: map['total']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatementSummary.fromJson(String source) =>
      StatementSummary.fromMap(json.decode(source));

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