import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nannyplus/utils/font_utils.dart';
import 'package:nannyplus/utils/prefs_util.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsInitial());

  Future<void> loadSettings() async {
    final prefs = await PrefsUtil.getInstance();
    final settingsLoaded = SettingsLoaded(
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
    final prefs = await PrefsUtil.getInstance();
    prefs
      ..line1 = values['line1'] as String? ?? ''
      ..line1FontFamily = (values['line1Font'] as FontItem?)?.family ??
          FontUtils.defaultFontItem.family
      ..line1FontAsset = (values['line1Font'] as FontItem?)?.asset ??
          FontUtils.defaultFontItem.asset
      ..line2 = values['line2'] as String? ?? ''
      ..line2FontFamily = (values['line2Font'] as FontItem?)?.family ??
          FontUtils.defaultFontItem.family
      ..line2FontAsset = (values['line2Font'] as FontItem?)?.asset ??
          FontUtils.defaultFontItem.asset
      ..conditions = values['conditions'] as String? ?? ''
      ..bankDetails = values['bankDetails'] as String? ?? ''
      ..name = values['name'] as String? ?? ''
      ..address = values['address'] as String? ?? '';
    await loadSettings();
  }

  Future<void> setLine1Font(FontItem? value) async {
    final prefs = await PrefsUtil.getInstance();
    if (value == null) {
      prefs
        ..line1FontFamily = ''
        ..line1FontAsset = '';
    } else {
      prefs
        ..line1FontFamily = value.family
        ..line1FontAsset = value.asset;
    }
    await loadSettings();
  }

  Future<void> setLine2Font(FontItem? value) async {
    final prefs = await PrefsUtil.getInstance();
    if (value == null) {
      prefs
        ..line2FontFamily = ''
        ..line2FontAsset = '';
    } else {
      prefs
        ..line2FontFamily = value.family
        ..line2FontAsset = value.asset;
    }
    await loadSettings();
  }

  void setLine1(String? value) {
    if (state is SettingsLoaded) {
      emit((state as SettingsLoaded).copyWith(line1: value));
    }
  }
}
