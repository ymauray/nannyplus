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
  final String _invoiceMetaLine2;

  const SettingsLoaded(this._invoiceMetaLine1, this._invoiceMetaLine2);

  String get line1 => _invoiceMetaLine1;
  String get line2 => _invoiceMetaLine2;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsLoaded &&
        other._invoiceMetaLine1 == _invoiceMetaLine1 &&
        other._invoiceMetaLine2 == _invoiceMetaLine2;
  }

  @override
  int get hashCode => _invoiceMetaLine1.hashCode ^ _invoiceMetaLine2.hashCode;
}
