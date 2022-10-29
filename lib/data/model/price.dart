// ignore_for_file: public_member_api_docs, sort_constructors_first, argument_type_not_assignable
import 'dart:convert';

import 'package:flutter/widgets.dart';

@immutable
class Price {
  const Price({
    this.id,
    required this.label,
    required this.amount,
    required this.fixedPrice,
    required this.sortOrder,
    required this.deleted,
  });
  factory Price.fromJson(String source) => Price.fromMap(json.decode(source));

  factory Price.fromMap(Map<String, dynamic> map) {
    return Price(
      id: map['id']?.toInt(),
      label: map['label'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      fixedPrice: map['fixedPrice']?.toInt() ?? 0,
      sortOrder: map['sortOrder']?.toInt() ?? 0,
      deleted: map['deleted']?.toInt() ?? 0,
    );
  }

  final int? id;
  final String label;
  final double amount;
  final int fixedPrice;
  final int sortOrder;
  final int deleted;

  bool get isFixedPrice => fixedPrice == 1;

  String get detail => amount.toStringAsFixed(2) + (isFixedPrice ? '' : ' / h');

  // --------------------------------------------------

  Price copyWith({
    int? id,
    String? label,
    double? amount,
    int? fixedPrice,
    int? sortOrder,
    int? deleted,
  }) {
    return Price(
      id: id ?? this.id,
      label: label ?? this.label,
      amount: amount ?? this.amount,
      fixedPrice: fixedPrice ?? this.fixedPrice,
      sortOrder: sortOrder ?? this.sortOrder,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'amount': amount,
      'fixedPrice': fixedPrice,
      'sortOrder': sortOrder,
      'deleted': deleted,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Price(id: $id, label: $label, amount: $amount, fixedPrice: $fixedPrice, sortOrder: $sortOrder, deleted: $deleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Price &&
        other.id == id &&
        other.label == label &&
        other.amount == amount &&
        other.fixedPrice == fixedPrice &&
        other.sortOrder == sortOrder &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        label.hashCode ^
        amount.hashCode ^
        fixedPrice.hashCode ^
        sortOrder.hashCode ^
        deleted.hashCode;
  }
}
