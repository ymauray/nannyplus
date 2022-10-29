import 'dart:convert';

import 'package:flutter/widgets.dart';

@immutable
class StatementLine {
  const StatementLine({
    required this.priceLabel,
    required this.priceAmount,
    required this.isFixedPrice,
    required this.hours,
    required this.minutes,
    required this.count,
    required this.total,
  });
  factory StatementLine.fromJson(String source) =>
      StatementLine.fromMap(json.decode(source));

  factory StatementLine.fromMap(Map<String, dynamic> map) {
    return StatementLine(
      priceLabel: map['priceLabel'] ?? '',
      priceAmount: map['priceAmount']?.toDouble() ?? 0.0,
      isFixedPrice: map['isFixedPrice']?.toInt() ?? 0,
      hours: map['hours']?.toInt() ?? 0,
      minutes: map['minutes']?.toInt() ?? 0,
      count: map['count']?.toInt() ?? 0,
      total: map['total']?.toDouble() ?? 0.0,
    );
  }
  final String priceLabel;
  final double priceAmount;
  final int isFixedPrice;
  final int hours;
  final int minutes;
  final int count;
  final double total;

  StatementLine copyWith({
    String? priceLabel,
    double? priceAmount,
    int? isFixedPrice,
    int? hours,
    int? minutes,
    int? count,
    double? total,
  }) {
    return StatementLine(
      priceLabel: priceLabel ?? this.priceLabel,
      priceAmount: priceAmount ?? this.priceAmount,
      isFixedPrice: isFixedPrice ?? this.isFixedPrice,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      count: count ?? this.count,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'priceLabel': priceLabel,
      'priceAmount': priceAmount,
      'isFixedPrice': isFixedPrice,
      'hours': hours,
      'minutes': minutes,
      'count': count,
      'total': total,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'StatementLine(priceLabel: $priceLabel, priceAmount: $priceAmount, isFixedPrice: $isFixedPrice, hours: $hours, minutes: $minutes, count: $count, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatementLine &&
        other.priceLabel == priceLabel &&
        other.priceAmount == priceAmount &&
        other.isFixedPrice == isFixedPrice &&
        other.hours == hours &&
        other.minutes == minutes &&
        other.count == count &&
        other.total == total;
  }

  @override
  int get hashCode {
    return priceLabel.hashCode ^
        priceAmount.hashCode ^
        isFixedPrice.hashCode ^
        hours.hashCode ^
        minutes.hashCode ^
        count.hashCode ^
        total.hashCode;
  }
}
