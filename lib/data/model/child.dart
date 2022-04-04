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
  final String? labelForPhoneNumber2;
  final String? phoneNumber2;
  final String? labelForPhoneNumber3;
  final String? phoneNumber3;
  final String? freeText;

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
    this.labelForPhoneNumber2,
    this.phoneNumber2,
    this.labelForPhoneNumber3,
    this.phoneNumber3,
    this.freeText,
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
    String? labelForPhoneNumber2,
    String? phoneNumber2,
    String? labelForPhoneNumber3,
    String? phoneNumber3,
    String? freeText,
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
      labelForPhoneNumber2: labelForPhoneNumber2 ?? this.labelForPhoneNumber2,
      phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
      labelForPhoneNumber3: labelForPhoneNumber3 ?? this.labelForPhoneNumber3,
      phoneNumber3: phoneNumber3 ?? this.phoneNumber3,
      freeText: freeText ?? this.freeText,
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
      'labelForPhoneNumber2': labelForPhoneNumber2,
      'phoneNumber2': phoneNumber2,
      'labelForPhoneNumber3': labelForPhoneNumber3,
      'phoneNumber3': phoneNumber3,
      'freeText': freeText,
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
      labelForPhoneNumber2: map['labelForPhoneNumber2'],
      phoneNumber2: map['phoneNumber2'],
      labelForPhoneNumber3: map['labelForPhoneNumber3'],
      phoneNumber3: map['phoneNumber3'],
      freeText: map['freeText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Child.fromJson(String source) => Child.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Child(id: $id, firstName: $firstName, lastName: $lastName, birthdate: $birthdate, phoneNumber: $phoneNumber, allergies: $allergies, parentsName: $parentsName, address: $address, preschool: $preschool, archived: $archived, labelForPhoneNumber2: $labelForPhoneNumber2, phoneNumber2: $phoneNumber2, labelForPhoneNumber3: $labelForPhoneNumber3, phoneNumber3: $phoneNumber3, freeText: $freeText)';
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
        other.archived == archived &&
        other.labelForPhoneNumber2 == labelForPhoneNumber2 &&
        other.phoneNumber2 == phoneNumber2 &&
        other.labelForPhoneNumber3 == labelForPhoneNumber3 &&
        other.phoneNumber3 == phoneNumber3 &&
        other.freeText == freeText;
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
        archived.hashCode ^
        labelForPhoneNumber2.hashCode ^
        phoneNumber2.hashCode ^
        labelForPhoneNumber3.hashCode ^
        phoneNumber3.hashCode ^
        freeText.hashCode;
  }
}
