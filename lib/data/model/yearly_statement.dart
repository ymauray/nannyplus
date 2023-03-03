// ignore_for_file: public_member_api_docs, sort_constructors_first, argument_type_not_assignable
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/monthly_statement.dart';

@immutable
class YearlyStatement {
  const YearlyStatement({
    this.id,
    required this.year,
    required this.amount,
    required this.monthlyStatements,
  });
  factory YearlyStatement.fromJson(String source) =>
      YearlyStatement.fromMap(json.decode(source));

  factory YearlyStatement.fromMap(Map<String, dynamic> map) {
    return YearlyStatement(
      id: map['id']?.toInt(),
      year: map['year']?.toInt() ?? 0,
      amount: map['amount']?.toDouble() ?? 0.0,
      monthlyStatements: List<MonthlyStatement>.from(
        map['monthlyStatements']?.map(MonthlyStatement.fromMap),
      ),
    );
  }
  final int? id;
  final int year;
  final double amount;
  final List<MonthlyStatement> monthlyStatements;

  YearlyStatement copyWith({
    int? id,
    int? year,
    double? amount,
    List<MonthlyStatement>? monthlyStatements,
  }) {
    return YearlyStatement(
      id: id ?? this.id,
      year: year ?? this.year,
      amount: amount ?? this.amount,
      monthlyStatements: monthlyStatements ?? this.monthlyStatements,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'year': year,
      'amount': amount,
      'monthlyStatements': monthlyStatements.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'YearlyStatement(id: $id, year: $year, amount: $amount, monthlyStatements: $monthlyStatements)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YearlyStatement &&
        other.id == id &&
        other.year == year &&
        other.amount == amount &&
        listEquals(other.monthlyStatements, monthlyStatements);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        year.hashCode ^
        amount.hashCode ^
        monthlyStatements.hashCode;
  }
}
