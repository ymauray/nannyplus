// ignore_for_file: public_member_api_docs, sort_constructors_first, argument_type_not_assignable
import 'dart:convert';

import 'package:flutter/widgets.dart';

@immutable
class Invoice {
  const Invoice({
    required this.number,
    required this.childId,
    required this.childFirstName,
    required this.childLastName,
    required this.date,
    required this.total,
    required this.parentsName,
    required this.address,
    required this.paid,
    required this.hourCredits,
    this.id,
  });
  factory Invoice.fromJson(String source) =>
      Invoice.fromMap(json.decode(source));

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['id']?.toInt(),
      number: map['number']?.toInt() ?? 0,
      childId: map['childId']?.toInt() ?? 0,
      childFirstName: map['childFirstName'] ?? '',
      childLastName: map['childLastName'] ?? '',
      date: map['date'] ?? '',
      total: map['total']?.toDouble() ?? 0.0,
      parentsName: map['parentsName'] ?? '',
      address: map['address'] ?? '',
      paid: map['paid']?.toInt() ?? 0,
      hourCredits: map['hourCredits'] ?? '',
    );
  }
  final int? id;
  final int number;
  final int childId;
  final String childFirstName;
  final String childLastName;
  final String date;
  final double total;
  final String parentsName;
  final String address;
  final int paid;
  final String hourCredits;

  Invoice copyWith({
    int? id,
    int? number,
    int? childId,
    String? childFirstName,
    String? childLastName,
    String? date,
    double? total,
    String? parentsName,
    String? address,
    int? paid,
    String? hourCredits,
  }) {
    return Invoice(
      id: id ?? this.id,
      number: number ?? this.number,
      childId: childId ?? this.childId,
      childFirstName: childFirstName ?? this.childFirstName,
      childLastName: childLastName ?? this.childLastName,
      date: date ?? this.date,
      total: total ?? this.total,
      parentsName: parentsName ?? this.parentsName,
      address: address ?? this.address,
      paid: paid ?? this.paid,
      hourCredits: hourCredits ?? this.hourCredits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'childId': childId,
      'childFirstName': childFirstName,
      'childLastName': childLastName,
      'date': date,
      'total': total,
      'parentsName': parentsName,
      'address': address,
      'paid': paid,
      'hourCredits': hourCredits,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Invoice(id: $id, number: $number, childId: $childId, childFirstName: $childFirstName, childLastName: $childLastName, date: $date, total: $total, parentsName: $parentsName, address: $address, paid: $paid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Invoice &&
        other.id == id &&
        other.number == number &&
        other.childId == childId &&
        other.childFirstName == childFirstName &&
        other.childLastName == childLastName &&
        other.date == date &&
        other.total == total &&
        other.parentsName == parentsName &&
        other.address == address &&
        other.paid == paid &&
        other.hourCredits == hourCredits;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        number.hashCode ^
        childId.hashCode ^
        childFirstName.hashCode ^
        childLastName.hashCode ^
        date.hashCode ^
        total.hashCode ^
        parentsName.hashCode ^
        address.hashCode ^
        paid.hashCode ^
        hourCredits.hashCode;
  }
}
