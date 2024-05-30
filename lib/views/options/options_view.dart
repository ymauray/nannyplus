import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/src/app_settings/app_settings_view.dart';
import 'package:nannyplus/src/deductions/deductions_view.dart';
import 'package:nannyplus/src/invoice_settings/invoice_settings_view.dart';
import 'package:nannyplus/src/price_list/price_list_view.dart';
import 'package:nannyplus/src/statement_list_view/statement_list_view.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/views/options/option_tile.dart';
import 'package:nannyplus/views/vacation_planning/vacation_planning_view.dart';
import 'package:nannyplus/views/weekly_schedule_pdf.dart';
import 'package:nannyplus/views/yearly_schedule/yearly_schedule_pdf_view.dart';

class OptionsView extends ConsumerWidget {
  const OptionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UIListView.fromChildren(
      children: [
        OptionTile(
          leading: const Icon(Icons.payment),
          label: context.t('Price list'),
          destinationBuilder: () => const PriceListView(),
        ),
        OptionTile(
          leading: const Icon(Icons.remove_circle_outline),
          label: context.t('Deductions'),
          destinationBuilder: () => const DeductionsView(),
        ),
        OptionTile(
          leading: const Icon(Icons.app_settings_alt),
          label: context.t('Application settings'),
          destinationBuilder: () => const AppSettingsView(),
        ),
        OptionTile(
          leading: const Icon(Icons.settings),
          label: context.t('Invoice settings'),
          destinationBuilder: () => const InvoiceSettingsView(),
        ),
        OptionTile(
          leading: const Icon(Icons.description),
          label: context.t('Statements'),
          destinationBuilder: () => const StatementListView(),
        ),
        //OptionTile(
        //  leading: const Icon(Icons.calendar_today),
        //  label: context.t('Schedule options'),
        //  destinationBuilder: () => const ScheduleOptionsView(),
        //),
        OptionTile(
          leading: const Icon(Icons.calendar_view_week),
          label: context.t('Weekly schedule'),
          destinationBuilder: () => const WeeklySchedulePdf(),
        ),
        OptionTile(
          leading: const Icon(FontAwesomeIcons.calendar),
          label: context.t('Yearly schedule'),
          destinationBuilder: () => const YearlySchedulePdfView(),
        ),
        OptionTile(
          leading: const Icon(FontAwesomeIcons.calendar),
          label: context.t('Vacation planning'),
          destinationBuilder: () {
            return const VacationPlanningView();
          },
        ),
      ],
    );
  }
}
