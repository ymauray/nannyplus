import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/settings_cubit.dart';
import 'settings_form.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SettingsCubit>().loadSettings();

    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) =>
          previous is SettingsInitial && current is SettingsLoaded,
      builder: (context, state) {
        return state is SettingsLoaded
            ? SettingsForm(state)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
