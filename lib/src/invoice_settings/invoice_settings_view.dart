import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nannyplus/cubit/settings_cubit.dart';
import 'package:nannyplus/src/invoice_settings/invoice_settings_form.dart';

class InvoiceSettingsView extends StatelessWidget {
  const InvoiceSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SettingsCubit>().loadSettings();

    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) =>
          previous is SettingsInitial && current is SettingsLoaded,
      builder: (context, state) {
        return state is SettingsLoaded
            ? InvoiceSettingsForm(state)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
