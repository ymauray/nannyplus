import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nannyplus/utils/prefs_util.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit() : super(AppSettingsInitial());

  Future<void> loadSettings() async {
    final prefs = await PrefsUtil.getInstance();
    final settingsLoaded = AppSettingsLoaded(
      prefs.sortListByLastName,
      prefs.showFirstNameBeforeLastName,
    );
    emit(settingsLoaded);
  }

  Future<void> saveSettings(Map<String, dynamic> value) async {
    final prefs = await PrefsUtil.getInstance();
    prefs
      ..sortListByLastName = value['sortListByLastName'] as bool
      ..showFirstNameBeforeLastName =
          value['showFirstNameBeforeLastName'] as bool;
    await loadSettings();
  }
}
