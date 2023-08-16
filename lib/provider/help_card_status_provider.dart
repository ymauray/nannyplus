import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'help_card_status_provider.g.dart';

@riverpod
class HelpCardStatus extends _$HelpCardStatus {
  @override
  FutureOr<bool> build(int code) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('help_$code') == null;
  }

  FutureOr<void> hide() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('help_$code', false);
      return false;
    });
  }
}
