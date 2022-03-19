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
      builder: (context, state) {
        if (state is SettingsLoaded) {
          return SettingsForm(state);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
