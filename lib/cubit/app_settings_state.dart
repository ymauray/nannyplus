// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_settings_cubit.dart';

@immutable
abstract class AppSettingsState {}

class AppSettingsInitial extends AppSettingsState {}

@immutable
class AppSettingsLoaded extends AppSettingsState {
  AppSettingsLoaded(
    this.sortListByLastName,
    this.showFirstNameBeforeLastName,
    this.daysBeforeUnpaidInvoiceNotification,
    this.notificationMessage,
  );

  final bool sortListByLastName;
  final bool showFirstNameBeforeLastName;
  final int daysBeforeUnpaidInvoiceNotification;
  final String notificationMessage;

  AppSettingsLoaded copyWith({
    bool? sortListByLastName,
    bool? showFirstNameBeforeLastName,
    int? daysBeforeUnpaidInvoiceNotification,
    String? notificationMessage,
  }) {
    return AppSettingsLoaded(
      sortListByLastName ?? this.sortListByLastName,
      showFirstNameBeforeLastName ?? this.showFirstNameBeforeLastName,
      daysBeforeUnpaidInvoiceNotification ??
          this.daysBeforeUnpaidInvoiceNotification,
      notificationMessage ?? this.notificationMessage,
    );
  }
}
