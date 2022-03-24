import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nannyplus/utils/font_utils.dart';
import 'package:nannyplus/utils/prefs_util.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsInitial());

  Future<void> loadSettings() async {
    var settingsLoaded = SettingsLoaded(
      PrefsUtil.getInstance().line1,
      PrefsUtil.getInstance().line1FontFamily,
      PrefsUtil.getInstance().line1FontAsset,
      PrefsUtil.getInstance().line2,
      PrefsUtil.getInstance().line2FontFamily,
      PrefsUtil.getInstance().line2FontAsset,
      PrefsUtil.getInstance().conditions,
      PrefsUtil.getInstance().bankDetails,
      PrefsUtil.getInstance().address,
    );
    emit(settingsLoaded);
  }

  Future<void> saveSettings(Map<String, dynamic> values) async {
    PrefsUtil.getInstance().line1 = values['line1'] ?? '';
    PrefsUtil.getInstance().line1FontFamily =
        (values['line1Font'] as FontItem?)?.family ??
            FontUtils.defaultFontItem.family;
    PrefsUtil.getInstance().line1FontAsset =
        (values['line1Font'] as FontItem?)?.asset ??
            FontUtils.defaultFontItem.asset;
    PrefsUtil.getInstance().line2 = values['line2'] ?? '';
    PrefsUtil.getInstance().line2FontFamily =
        (values['line2Font'] as FontItem?)?.family ??
            FontUtils.defaultFontItem.family;
    PrefsUtil.getInstance().line2FontAsset =
        (values['line2Font'] as FontItem?)?.asset ??
            FontUtils.defaultFontItem.asset;
    PrefsUtil.getInstance().conditions = values['conditions'] ?? '';
    PrefsUtil.getInstance().bankDetails = values['bankDetails'] ?? '';
    PrefsUtil.getInstance().address = values['address'] ?? '';
    loadSettings();
  }

  Future<void> setLine1Font(FontItem? value) async {
    if (value == null) {
      PrefsUtil.getInstance().line1FontFamily = "";
      PrefsUtil.getInstance().line1FontAsset = "";
    } else {
      PrefsUtil.getInstance().line1FontFamily = value.family;
      PrefsUtil.getInstance().line1FontAsset = value.asset;
    }
    loadSettings();
  }

  Future<void> setLine2Font(FontItem? value) async {
    if (value == null) {
      PrefsUtil.getInstance().line2FontFamily = "";
      PrefsUtil.getInstance().line2FontAsset = "";
    } else {
      PrefsUtil.getInstance().line2FontFamily = value.family;
      PrefsUtil.getInstance().line2FontAsset = value.asset;
    }
    loadSettings();
  }

  void setLine1(String? value) {
    if (state is SettingsLoaded) {
      emit((state as SettingsLoaded).copyWith(line1: value));
    }
  }
}
