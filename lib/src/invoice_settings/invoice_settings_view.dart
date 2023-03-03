import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nannyplus/cubit/invoice_settings_cubit.dart';
import 'package:nannyplus/src/invoice_settings/invoice_settings_form.dart';

class InvoiceSettingsView extends StatelessWidget {
  const InvoiceSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<InvoiceSettingsCubit>().loadSettings();

    return BlocBuilder<InvoiceSettingsCubit, InvoiceSettingsState>(
      buildWhen: (previous, current) =>
          previous is InvoiceSettingsInitial &&
          current is InvoiceSettingsLoaded,
      builder: (context, state) {
        return state is InvoiceSettingsLoaded
            ? InvoiceSettingsForm(state)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
