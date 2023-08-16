// ignore_for_file: public_member_api_docs, sort_constructors_first, argument_type_not_assignable
import 'dart:convert';

import 'package:flutter/widgets.dart';

@immutable
class Service {
  const Service({
    required this.childId,
    required this.date,
    required this.priceId,
    required this.total,
    this.id,
    this.priceLabel,
    this.priceAmount,
    this.isFixedPrice,
    this.hours,
    this.minutes,
    this.invoiced = 0,
    this.invoiceId,
  });
  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source));

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id']?.toInt(),
      childId: map['childId']?.toInt() ?? 0,
      date: map['date'] ?? '',
      priceId: map['priceId']?.toInt() ?? 0,
      priceLabel: map['priceLabel'],
      priceAmount: map['priceAmount']?.toDouble(),
      isFixedPrice: map['isFixedPrice']?.toInt(),
      hours: map['hours']?.toInt(),
      minutes: map['minutes']?.toInt(),
      total: map['total']?.toDouble() ?? 0.0,
      invoiced: map['invoiced']?.toInt() ?? 0,
      invoiceId: map['invoiceId']?.toInt(),
    );
  }
  final int? id;
  final int childId;
  final String date;
  final int priceId;
  final String? priceLabel;
  final double? priceAmount;
  final int? isFixedPrice;
  final int? hours;
  final int? minutes;
  final double total;
  final int invoiced;
  final int? invoiceId;

  String get priceDetail => (isFixedPrice == 1)
      ? ''
      : "${hours}h${minutes!.toString().padLeft(2, "0")} x ${priceAmount?.toStringAsFixed(2)}";

  Service copyWith({
    int? id,
    int? childId,
    String? date,
    int? priceId,
    String? priceLabel,
    double? priceAmount,
    int? isFixedPrice,
    int? hours,
    int? minutes,
    double? total,
    int? invoiced,
    int? invoiceId,
  }) {
    return Service(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      date: date ?? this.date,
      priceId: priceId ?? this.priceId,
      priceLabel: priceLabel ?? this.priceLabel,
      priceAmount: priceAmount ?? this.priceAmount,
      isFixedPrice: isFixedPrice ?? this.isFixedPrice,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      total: total ?? this.total,
      invoiced: invoiced ?? this.invoiced,
      invoiceId: invoiceId ?? this.invoiceId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childId': childId,
      'date': date,
      'priceId': priceId,
      'priceLabel': priceLabel,
      'priceAmount': priceAmount,
      'isFixedPrice': isFixedPrice,
      'hours': hours,
      'minutes': minutes,
      'total': total,
      'invoiced': invoiced,
      'invoiceId': invoiceId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Service(id: $id, childId: $childId, date: $date, priceId: $priceId, priceLabel: $priceLabel, priceAmount: $priceAmount, isFixedPrice: $isFixedPrice, hours: $hours, minutes: $minutes, total: $total, invoiced: $invoiced, invoiceId: $invoiceId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service &&
        other.id == id &&
        other.childId == childId &&
        other.date == date &&
        other.priceId == priceId &&
        other.priceLabel == priceLabel &&
        other.priceAmount == priceAmount &&
        other.isFixedPrice == isFixedPrice &&
        other.hours == hours &&
        other.minutes == minutes &&
        other.total == total &&
        other.invoiced == invoiced &&
        other.invoiceId == invoiceId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        childId.hashCode ^
        date.hashCode ^
        priceId.hashCode ^
        priceLabel.hashCode ^
        priceAmount.hashCode ^
        isFixedPrice.hashCode ^
        hours.hashCode ^
        minutes.hashCode ^
        total.hashCode ^
        invoiced.hashCode ^
        invoiceId.hashCode;
  }
}
