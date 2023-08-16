// ignore_for_file: public_member_api_docs, sort_constructors_first, argument_type_not_assignable
import 'dart:convert';

import 'package:flutter/widgets.dart';

@immutable
class MonthlyStatement {
  const MonthlyStatement({
    required this.date,
    required this.amount,
    required this.netAmount,
    this.id,
  });
  factory MonthlyStatement.fromJson(String source) =>
      MonthlyStatement.fromMap(json.decode(source));

  factory MonthlyStatement.fromMap(Map<String, dynamic> map) {
    return MonthlyStatement(
      id: map['id']?.toInt(),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      amount: map['amount']?.toDouble() ?? 0.0,
      netAmount: map['netAmount']?.toDouble() ?? 0.0,
    );
  }
  final int? id;
  final DateTime date;
  final double amount;
  final double netAmount;

  MonthlyStatement copyWith({
    int? id,
    DateTime? date,
    double? amount,
    double? netAmount,
  }) {
    return MonthlyStatement(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      netAmount: netAmount ?? this.netAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
      'netAmount': netAmount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'MonthlyStatement(id: $id, date: $date, amount: $amount, netAmount: $netAmount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MonthlyStatement &&
        other.id == id &&
        other.date == date &&
        other.amount == amount &&
        other.netAmount == netAmount;
  }

  @override
  int get hashCode =>
      id.hashCode ^ date.hashCode ^ amount.hashCode ^ netAmount.hashCode;
}
