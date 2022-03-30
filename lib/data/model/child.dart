import 'dart:convert';

class Child {
  final int? id;
  final String firstName;
  final String? lastName;
  final String? birthdate;
  final String? phoneNumber;
  final String? allergies;
  final String? parentsName;
  final String? address;
  final int preschool;
  final int archived;

  Child({
    this.id,
    required this.firstName,
    this.lastName,
    this.birthdate,
    this.phoneNumber,
    this.allergies,
    this.parentsName,
    this.address,
    this.preschool = 1,
    this.archived = 0,
  });

  String get displayName => "$firstName ${lastName ?? ''}".trim();

  bool get hasPhoneNumber => !(phoneNumber?.isEmpty ?? true);

  bool get hasAllergies => !(allergies?.isEmpty ?? true);

  bool get isArchived => archived == 1;

  // ---------------------------------------------------------------------------

  Child copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? birthdate,
    String? phoneNumber,
    String? allergies,
    String? parentsName,
    String? address,
    int? preschool,
    int? archived,
  }) {
    return Child(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthdate: birthdate ?? this.birthdate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      allergies: allergies ?? this.allergies,
      parentsName: parentsName ?? this.parentsName,
      address: address ?? this.address,
      preschool: preschool ?? this.preschool,
      archived: archived ?? this.archived,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'birthdate': birthdate,
      'phoneNumber': phoneNumber,
      'allergies': allergies,
      'parentsName': parentsName,
      'address': address,
      'preschool': preschool,
      'archived': archived,
    };
  }

  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
      id: map['id']?.toInt(),
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'],
      birthdate: map['birthdate'],
      phoneNumber: map['phoneNumber'],
      allergies: map['allergies'],
      parentsName: map['parentsName'],
      address: map['address'],
      preschool: map['preschool']?.toInt() ?? 0,
      archived: map['archived']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Child.fromJson(String source) => Child.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Child(id: $id, firstName: $firstName, lastName: $lastName, birthdate: $birthdate, phoneNumber: $phoneNumber, allergies: $allergies, parentsName: $parentsName, address: $address, preschool: $preschool, archived: $archived)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Child &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.birthdate == birthdate &&
        other.phoneNumber == phoneNumber &&
        other.allergies == allergies &&
        other.parentsName == parentsName &&
        other.address == address &&
        other.preschool == preschool &&
        other.archived == archived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        birthdate.hashCode ^
        phoneNumber.hashCode ^
        allergies.hashCode ^
        parentsName.hashCode ^
        address.hashCode ^
        preschool.hashCode ^
        archived.hashCode;
  }
}
