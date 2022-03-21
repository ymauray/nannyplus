part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsLoaded extends SettingsState {
  final String _invoiceMetaLine1;
  final String _line1FontFamily;
  final String _line1FontAsset;
  final String _invoiceMetaLine2;
  final String _line2FontFamily;
  final String _line2FontAsset;

  const SettingsLoaded(
    this._invoiceMetaLine1,
    this._line1FontFamily,
    this._line1FontAsset,
    this._invoiceMetaLine2,
    this._line2FontFamily,
    this._line2FontAsset,
  );

  String get line1 => _invoiceMetaLine1;
  String get line1FontFamily => _line1FontFamily;
  String get line1FontAsset => _line1FontAsset;
  FontItem get line1Font => FontItem(_line1FontFamily, _line1FontAsset);
  String get line2 => _invoiceMetaLine2;
  String get line2FontFamily => _line2FontFamily;
  String get line2FontAsset => _line2FontAsset;
  FontItem get line2Font => _line2FontFamily.isEmpty
      ? FontUtils.defaultFontItem
      : FontItem(_line2FontFamily, _line2FontAsset);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsLoaded &&
        other._invoiceMetaLine1 == _invoiceMetaLine1 &&
        other._line1FontFamily == _line1FontFamily &&
        other._line1FontAsset == _line1FontAsset &&
        other._invoiceMetaLine2 == _invoiceMetaLine2 &&
        other._line2FontFamily == _line2FontFamily &&
        other._line2FontAsset == _line2FontAsset;
  }

  @override
  int get hashCode {
    return _invoiceMetaLine1.hashCode ^
        _line1FontFamily.hashCode ^
        _line1FontAsset.hashCode ^
        _invoiceMetaLine2.hashCode ^
        _line2FontFamily.hashCode ^
        _line2FontAsset.hashCode;
  }
}
