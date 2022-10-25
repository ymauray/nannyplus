part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsLoaded extends SettingsState {
  final String line1;
  final String line1FontFamily;
  final String line1FontAsset;
  final String line2;
  final String line2FontFamily;
  final String line2FontAsset;
  final String conditions;
  final String bankDetails;
  final String name;
  final String address;

  const SettingsLoaded(
    this.line1,
    this.line1FontFamily,
    this.line1FontAsset,
    this.line2,
    this.line2FontFamily,
    this.line2FontAsset,
    this.conditions,
    this.bankDetails,
    this.name,
    this.address,
  );

  FontItem get line1Font => line1FontFamily.isEmpty
      ? FontUtils.defaultFontItem
      : FontItem(line1FontFamily, line1FontAsset);
  FontItem get line2Font => line2FontFamily.isEmpty
      ? FontUtils.defaultFontItem
      : FontItem(line2FontFamily, line2FontAsset);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsLoaded &&
        other.line1 == line1 &&
        other.line1FontFamily == line1FontFamily &&
        other.line1FontAsset == line1FontAsset &&
        other.line2 == line2 &&
        other.line2FontFamily == line2FontFamily &&
        other.line2FontAsset == line2FontAsset &&
        other.conditions == conditions &&
        other.bankDetails == bankDetails &&
        other.name == name &&
        other.address == address;
  }

  @override
  int get hashCode {
    return line1.hashCode ^
        line1FontFamily.hashCode ^
        line1FontAsset.hashCode ^
        line2.hashCode ^
        line2FontFamily.hashCode ^
        line2FontAsset.hashCode ^
        conditions.hashCode ^
        bankDetails.hashCode ^
        name.hashCode ^
        address.hashCode;
  }

  SettingsLoaded copyWith({
    String? line1,
    String? line1FontFamily,
    String? line1FontAsset,
    String? line2,
    String? line2FontFamily,
    String? line2FontAsset,
    String? conditions,
    String? bankDetails,
    String? name,
    String? address,
  }) {
    return SettingsLoaded(
      line1 ?? this.line1,
      line1FontFamily ?? this.line1FontFamily,
      line1FontAsset ?? this.line1FontAsset,
      line2 ?? this.line2,
      line2FontFamily ?? this.line2FontFamily,
      line2FontAsset ?? this.line2FontAsset,
      conditions ?? this.conditions,
      bankDetails ?? this.bankDetails,
      name ?? this.name,
      address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'line1': line1,
      'line1FontFamily': line1FontFamily,
      'line1FontAsset': line1FontAsset,
      'line2': line2,
      'line2FontFamily': line2FontFamily,
      'line2FontAsset': line2FontAsset,
      'conditions': conditions,
      'bankDetails': bankDetails,
      'name': name,
      'address': address,
    };
  }

  factory SettingsLoaded.fromMap(Map<String, dynamic> map) {
    return SettingsLoaded(
      map['line1'] ?? '',
      map['line1FontFamily'] ?? '',
      map['line1FontAsset'] ?? '',
      map['line2'] ?? '',
      map['line2FontFamily'] ?? '',
      map['line2FontAsset'] ?? '',
      map['conditions'] ?? '',
      map['bankDetails'] ?? '',
      map['name'] ?? '',
      map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsLoaded.fromJson(String source) =>
      SettingsLoaded.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SettingsLoaded(line1: $line1, line1FontFamily: $line1FontFamily, line1FontAsset: $line1FontAsset, line2: $line2, line2FontFamily: $line2FontFamily, line2FontAsset: $line2FontAsset, conditions: $conditions, bankDetails: $bankDetails, name: $name, address: $address)';
  }
}
