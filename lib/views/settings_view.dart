import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nannyplus/cubit/settings_cubit.dart';

import '../forms/settings_form.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SettingsCubit>().loadSettings();

    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return state is SettingsLoaded
            ? SettingsForm(state)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
