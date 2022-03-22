import 'dart:convert';

class Service {
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

  Service({
    this.id,
    required this.childId,
    required this.date,
    required this.priceId,
    this.priceLabel,
    this.priceAmount,
    this.isFixedPrice,
    this.hours,
    this.minutes,
    required this.total,
    this.invoiced = 0,
    this.invoiceId,
  });

  String get priceDetail =>
      total.toStringAsFixed(2) +
      ((isFixedPrice == 1)
          ? ""
          : " (${hours}h$minutes x ${priceAmount?.toStringAsFixed(2)})");

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

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source));

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
