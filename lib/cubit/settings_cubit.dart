import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../utils/font_utils.dart';
import '../utils/prefs_util.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsInitial());

  Future<void> loadSettings() async {
    var prefs = await PrefsUtil.getInstance();
    var settingsLoaded = SettingsLoaded(
      prefs.line1,
      prefs.line1FontFamily,
      prefs.line1FontAsset,
      prefs.line2,
      prefs.line2FontFamily,
      prefs.line2FontAsset,
      prefs.conditions,
      prefs.bankDetails,
      prefs.name,
      prefs.address,
    );
    emit(settingsLoaded);
  }

  Future<void> saveSettings(Map<String, dynamic> values) async {
    var prefs = await PrefsUtil.getInstance();
    prefs.line1 = values['line1'] ?? '';
    prefs.line1FontFamily = (values['line1Font'] as FontItem?)?.family ??
        FontUtils.defaultFontItem.family;
    prefs.line1FontAsset = (values['line1Font'] as FontItem?)?.asset ??
        FontUtils.defaultFontItem.asset;
    prefs.line2 = values['line2'] ?? '';
    prefs.line2FontFamily = (values['line2Font'] as FontItem?)?.family ??
        FontUtils.defaultFontItem.family;
    prefs.line2FontAsset = (values['line2Font'] as FontItem?)?.asset ??
        FontUtils.defaultFontItem.asset;
    prefs.conditions = values['conditions'] ?? '';
    prefs.bankDetails = values['bankDetails'] ?? '';
    prefs.name = values['name'] ?? '';
    prefs.address = values['address'] ?? '';
    loadSettings();
  }

  Future<void> setLine1Font(FontItem? value) async {
    var prefs = await PrefsUtil.getInstance();
    if (value == null) {
      prefs.line1FontFamily = "";
      prefs.line1FontAsset = "";
    } else {
      prefs.line1FontFamily = value.family;
      prefs.line1FontAsset = value.asset;
    }
    loadSettings();
  }

  Future<void> setLine2Font(FontItem? value) async {
    var prefs = await PrefsUtil.getInstance();
    if (value == null) {
      prefs.line2FontFamily = "";
      prefs.line2FontAsset = "";
    } else {
      prefs.line2FontFamily = value.family;
      prefs.line2FontAsset = value.asset;
    }
    loadSettings();
  }

  void setLine1(String? value) {
    if (state is SettingsLoaded) {
      emit((state as SettingsLoaded).copyWith(line1: value));
    }
  }
}
