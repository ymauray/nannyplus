import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nannyplus/utils/prefs_util.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsInitial());

  Future<void> loadSettings() async {
    emit(SettingsLoaded(
      PrefsUtil.getInstance().line1,
      PrefsUtil.getInstance().line2,
    ));
  }

  Future<void> saveSettings(String line1, String line2) async {
    PrefsUtil.getInstance().line1 = line1;
    PrefsUtil.getInstance().line2 = line2;
    loadSettings();
  }
}
