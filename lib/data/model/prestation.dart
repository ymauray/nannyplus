import 'dart:convert';

class Prestation {
  final int? id;
  final int childId;
  final String date;
  final int priceId;
  final String? priceLabel;
  final int? isFixedPrice;
  final int? hours;
  final int? minutes;
  final double price;
  final int invoiced;
  final int? invoiceId;

  Prestation({
    this.id,
    required this.childId,
    required this.date,
    required this.priceId,
    this.priceLabel,
    this.isFixedPrice,
    this.hours,
    this.minutes,
    required this.price,
    this.invoiced = 0,
    this.invoiceId,
  });

  Prestation copyWith({
    int? id,
    int? childId,
    String? date,
    int? priceId,
    String? priceLabel,
    int? isFixedPrice,
    int? hours,
    int? minutes,
    double? price,
    int? invoiced,
    int? invoiceId,
  }) {
    return Prestation(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      date: date ?? this.date,
      priceId: priceId ?? this.priceId,
      priceLabel: priceLabel ?? this.priceLabel,
      isFixedPrice: isFixedPrice ?? this.isFixedPrice,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      price: price ?? this.price,
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
      'isFixedPrice': isFixedPrice,
      'hours': hours,
      'minutes': minutes,
      'price': price,
      'invoiced': invoiced,
      'invoiceId': invoiceId,
    };
  }

  factory Prestation.fromMap(Map<String, dynamic> map) {
    return Prestation(
      id: map['id']?.toInt(),
      childId: map['childId']?.toInt() ?? 0,
      date: map['date'] ?? '',
      priceId: map['priceId']?.toInt() ?? 0,
      priceLabel: map['priceLabel'],
      isFixedPrice: map['isFixedPrice']?.toInt(),
      hours: map['hours']?.toInt(),
      minutes: map['minutes']?.toInt(),
      price: map['price']?.toDouble() ?? 0.0,
      invoiced: map['invoiced']?.toInt() ?? 0,
      invoiceId: map['invoiceId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Prestation.fromJson(String source) =>
      Prestation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Prestation(id: $id, childId: $childId, date: $date, priceId: $priceId, priceLabel: $priceLabel, isFixedPrice: $isFixedPrice, hours: $hours, minutes: $minutes, price: $price, invoiced: $invoiced, invoiceId: $invoiceId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Prestation &&
        other.id == id &&
        other.childId == childId &&
        other.date == date &&
        other.priceId == priceId &&
        other.priceLabel == priceLabel &&
        other.isFixedPrice == isFixedPrice &&
        other.hours == hours &&
        other.minutes == minutes &&
        other.price == price &&
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
        isFixedPrice.hashCode ^
        hours.hashCode ^
        minutes.hashCode ^
        price.hashCode ^
        invoiced.hashCode ^
        invoiceId.hashCode;
  }
}
