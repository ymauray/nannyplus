import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nannyplus/cubit/app_settings_cubit.dart';
import 'package:nannyplus/src/app_settings/app_settings_form.dart';

class AppSettingsView extends StatelessWidget {
  const AppSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AppSettingsCubit>().loadSettings();

    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      buildWhen: (previous, current) =>
          previous is AppSettingsInitial && current is AppSettingsLoaded,
      builder: (context, state) {
        return state is AppSettingsLoaded
            ? AppSettingsForm(state)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
