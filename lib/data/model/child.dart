import 'dart:convert';

class Child {
  final int? id;
  final String firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? alergies;
  final String? parentsName;
  final String? address;
  final int archived;

  Child({
    this.id,
    required this.firstName,
    this.lastName,
    this.phoneNumber,
    this.alergies,
    this.parentsName,
    this.address,
    this.archived = 0,
  });

  String get displayName => "$firstName ${lastName ?? ''}".trim();

  bool get hasPhoneNumber => !(phoneNumber?.isEmpty ?? true);

  bool get hasAllergies => !(alergies?.isEmpty ?? true);

  // ---------------------------------------------------------------------------

  Child copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? alergies,
    String? parentsName,
    String? address,
    int? archived,
  }) {
    return Child(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      alergies: alergies ?? this.alergies,
      parentsName: parentsName ?? this.parentsName,
      address: address ?? this.address,
      archived: archived ?? this.archived,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'alergies': alergies,
      'parentsName': parentsName,
      'address': address,
      'archived': archived,
    };
  }

  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
      id: map['id']?.toInt(),
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      alergies: map['alergies'],
      parentsName: map['parentsName'],
      address: map['address'],
      archived: map['archived']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Child.fromJson(String source) => Child.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Child(id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, alergies: $alergies, parentsName: $parentsName, address: $address, archived: $archived)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Child &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.alergies == alergies &&
        other.parentsName == parentsName &&
        other.address == address &&
        other.archived == archived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        alergies.hashCode ^
        parentsName.hashCode ^
        address.hashCode ^
        archived.hashCode;
  }
}
