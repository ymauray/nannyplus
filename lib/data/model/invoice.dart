import 'dart:convert';

class Invoice {
  final int id;
  final int number;
  final int childId;
  final String date;
  final double total;
  final String parentsName;
  final String address;

  Invoice({
    required this.id,
    required this.number,
    required this.childId,
    required this.date,
    required this.total,
    required this.parentsName,
    required this.address,
  });

  Invoice copyWith({
    int? id,
    int? number,
    int? childId,
    String? date,
    double? total,
    String? parentsName,
    String? address,
  }) {
    return Invoice(
      id: id ?? this.id,
      number: number ?? this.number,
      childId: childId ?? this.childId,
      date: date ?? this.date,
      total: total ?? this.total,
      parentsName: parentsName ?? this.parentsName,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'childId': childId,
      'date': date,
      'total': total,
      'parentsName': parentsName,
      'address': address,
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['id']?.toInt() ?? 0,
      number: map['number']?.toInt() ?? 0,
      childId: map['childId']?.toInt() ?? 0,
      date: map['date'] ?? '',
      total: map['total']?.toDouble() ?? 0.0,
      parentsName: map['parentsName'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) =>
      Invoice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Invoice(id: $id, number: $number, childId: $childId, date: $date, total: $total, parentsName: $parentsName, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Invoice &&
        other.id == id &&
        other.number == number &&
        other.childId == childId &&
        other.date == date &&
        other.total == total &&
        other.parentsName == parentsName &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        number.hashCode ^
        childId.hashCode ^
        date.hashCode ^
        total.hashCode ^
        parentsName.hashCode ^
        address.hashCode;
  }
}
