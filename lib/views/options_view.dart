import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/src/app_settings/app_settings_view.dart';
import 'package:nannyplus/src/deductions/deductions_view.dart';
import 'package:nannyplus/src/invoice_settings/invoice_settings_view.dart';
import 'package:nannyplus/src/price_list/price_list_view.dart';
import 'package:nannyplus/src/statement_list_view/statement_list_view.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/views/weekly_schedule/weekly_schedule_view.dart';

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.leading,
    required this.label,
    required this.destination,
  });

  final Widget leading;
  final String label;
  final Widget Function() destination;

  @override
  Widget build(BuildContext context) {
    return UICard(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => destination(),
              ),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: ListTile(
            leading: leading,
            title: Text(label),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }
}

class OptionsView extends ConsumerWidget {
  const OptionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UIListView.fromChildren(
      children: [
        _OptionTile(
          leading: const Icon(Icons.payment),
          label: context.t('Price list'),
          destination: () => const PriceListView(),
        ),
        _OptionTile(
          leading: const Icon(Icons.remove_circle_outline),
          label: context.t('Deductions'),
          destination: () => const DeductionsView(),
        ),
        _OptionTile(
          leading: const Icon(Icons.app_settings_alt),
          label: context.t('Application settings'),
          destination: () => const AppSettingsView(),
        ),
        _OptionTile(
          leading: const Icon(Icons.settings),
          label: context.t('Invoice settings'),
          destination: () => const InvoiceSettingsView(),
        ),
        _OptionTile(
          leading: const Icon(Icons.description),
          label: context.t('Statements'),
          destination: () => const StatementListView(),
        ),
        _OptionTile(
          leading: const Icon(Icons.calendar_view_week),
          label: context.t('Weekly schedule'),
          destination: () => const WeeklyScheduleView(),
        ),
      ],
    );
  }
}
