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
  final String? labelExtraPhoneNumber1;
  final String? extraPhoneNumber1;
  final String? labelExtraPhoneNumber2;
  final String? extraPhoneNumber2;
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
    this.labelExtraPhoneNumber1,
    this.extraPhoneNumber1,
    this.labelExtraPhoneNumber2,
    this.extraPhoneNumber2,
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
    String? labelExtraPhoneNumber1,
    String? extraPhoneNumber1,
    String? labelExtraPhoneNumber2,
    String? extraPhoneNumber2,
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
      labelExtraPhoneNumber1:
          labelExtraPhoneNumber1 ?? this.labelExtraPhoneNumber1,
      extraPhoneNumber1: extraPhoneNumber1 ?? this.extraPhoneNumber1,
      labelExtraPhoneNumber2:
          labelExtraPhoneNumber2 ?? this.labelExtraPhoneNumber2,
      extraPhoneNumber2: extraPhoneNumber2 ?? this.extraPhoneNumber2,
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
      'labelExtraPhoneNumber1': labelExtraPhoneNumber1,
      'extraPhoneNumber1': extraPhoneNumber1,
      'labelExtraPhoneNumber2': labelExtraPhoneNumber2,
      'extraPhoneNumber2': extraPhoneNumber2,
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
      labelExtraPhoneNumber1: map['labelExtraPhoneNumber1'],
      extraPhoneNumber1: map['extraPhoneNumber1'],
      labelExtraPhoneNumber2: map['labelExtraPhoneNumber2'],
      extraPhoneNumber2: map['extraPhoneNumber2'],
      freeText: map['freeText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Child.fromJson(String source) => Child.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Child(id: $id, firstName: $firstName, lastName: $lastName, birthdate: $birthdate, phoneNumber: $phoneNumber, allergies: $allergies, parentsName: $parentsName, address: $address, preschool: $preschool, archived: $archived, labelExtraPhoneNumber1: $labelExtraPhoneNumber1, extraPhoneNumber1: $extraPhoneNumber1, labelExtraPhoneNumber2: $labelExtraPhoneNumber2, extraPhoneNumber2: $extraPhoneNumber2, freeText: $freeText)';
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
        other.labelExtraPhoneNumber1 == labelExtraPhoneNumber1 &&
        other.extraPhoneNumber1 == extraPhoneNumber1 &&
        other.labelExtraPhoneNumber2 == labelExtraPhoneNumber2 &&
        other.extraPhoneNumber2 == extraPhoneNumber2 &&
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
        labelExtraPhoneNumber1.hashCode ^
        extraPhoneNumber1.hashCode ^
        labelExtraPhoneNumber2.hashCode ^
        extraPhoneNumber2.hashCode ^
        freeText.hashCode;
  }
}
