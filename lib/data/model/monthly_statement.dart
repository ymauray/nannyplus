import 'dart:convert';

class MonthlyStatement {
  final int? id;
  final DateTime date;
  final double amount;
  MonthlyStatement({
    this.id,
    required this.date,
    required this.amount,
  });

  MonthlyStatement copyWith({
    int? id,
    DateTime? date,
    double? amount,
  }) {
    return MonthlyStatement(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
    };
  }

  factory MonthlyStatement.fromMap(Map<String, dynamic> map) {
    return MonthlyStatement(
      id: map['id']?.toInt(),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      amount: map['amount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MonthlyStatement.fromJson(String source) =>
      MonthlyStatement.fromMap(json.decode(source));

  @override
  String toString() =>
      'MonthlyStatement(id: $id, date: $date, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MonthlyStatement &&
        other.id == id &&
        other.date == date &&
        other.amount == amount;
  }

  @override
  int get hashCode => id.hashCode ^ date.hashCode ^ amount.hashCode;
}