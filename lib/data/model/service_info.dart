// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class ServiceInfo {
  const ServiceInfo({
    required this.pendingTotal,
    this.lastEnty,
    required this.pendingInvoice,
  });

  final double pendingTotal;
  final DateTime? lastEnty;
  final double pendingInvoice;

  ServiceInfo copyWith({
    double? pendingTotal,
    DateTime? lastEnty,
    double? pendingInvoice,
  }) {
    return ServiceInfo(
      pendingTotal: pendingTotal ?? this.pendingTotal,
      lastEnty: lastEnty ?? this.lastEnty,
      pendingInvoice: pendingInvoice ?? this.pendingInvoice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTotal': pendingTotal,
      'lastEnty': lastEnty?.millisecondsSinceEpoch,
      'pendingInvoice': pendingInvoice,
    };
  }

  factory ServiceInfo.fromMap(Map<String, dynamic> map) {
    return ServiceInfo(
      pendingTotal: map['pendingTotal'] as double,
      lastEnty: map['lastEnty'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastEnty'] as int)
          : null,
      pendingInvoice: map['pendingInvoice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceInfo.fromJson(String source) =>
      ServiceInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ServiceInfo(pendingTotal: $pendingTotal, lastEnty: $lastEnty, pendingInvoice: $pendingInvoice)';

  @override
  bool operator ==(covariant ServiceInfo other) {
    if (identical(this, other)) return true;

    return other.pendingTotal == pendingTotal &&
        other.lastEnty == lastEnty &&
        other.pendingInvoice == pendingInvoice;
  }

  @override
  int get hashCode =>
      pendingTotal.hashCode ^ lastEnty.hashCode ^ pendingInvoice.hashCode;
}
