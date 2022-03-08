import 'dart:convert';

class Price {
  final int? id;
  final String label;
  final double amount;
  final int fixedPrice;

  const Price({
    this.id,
    required this.label,
    required this.amount,
    required this.fixedPrice,
  });

  bool get isFixedPrice => fixedPrice == 1;

  // --------------------------------------------------

  Price copyWith({
    int? id,
    String? label,
    double? amount,
    int? fixedPrice,
  }) {
    return Price(
      id: id ?? this.id,
      label: label ?? this.label,
      amount: amount ?? this.amount,
      fixedPrice: fixedPrice ?? this.fixedPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'amount': amount,
      'fixedPrice': fixedPrice,
    };
  }

  factory Price.fromMap(Map<String, dynamic> map) {
    return Price(
      id: map['id']?.toInt(),
      label: map['label'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      fixedPrice: map['fixedPrice']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Price.fromJson(String source) => Price.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Price(id: $id, label: $label, amount: $amount, fixedPrice: $fixedPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Price &&
        other.id == id &&
        other.label == label &&
        other.amount == amount &&
        other.fixedPrice == fixedPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^ label.hashCode ^ amount.hashCode ^ fixedPrice.hashCode;
  }
}
