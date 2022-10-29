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
  );

  final bool sortListByLastName;
  final bool showFirstNameBeforeLastName;

  AppSettingsLoaded copyWith({
    bool? sortListByLastName,
    bool? showFirstNameBeforeLastName,
  }) {
    return AppSettingsLoaded(
      sortListByLastName ?? this.sortListByLastName,
      showFirstNameBeforeLastName ?? this.showFirstNameBeforeLastName,
    );
  }
}
