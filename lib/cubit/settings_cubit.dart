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
    );
    emit(settingsLoaded);
  }

  Future<void> saveSettings(String line1, String line2) async {
    PrefsUtil.getInstance().line1 = line1;
    PrefsUtil.getInstance().line2 = line2;
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
}
