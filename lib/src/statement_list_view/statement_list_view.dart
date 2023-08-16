import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
// ignore: implementation_imports
import 'package:gettext_i18n/src/gettext_localizations.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/cubit/statement_list_cubit.dart';
import 'package:nannyplus/data/model/deduction.dart';
import 'package:nannyplus/data/model/monthly_statement.dart';
import 'package:nannyplus/data/model/yearly_statement.dart';
import 'package:nannyplus/provider/deductions_provider.dart';
import 'package:nannyplus/src/constants.dart';
import 'package:nannyplus/src/statement_view/statement_view.dart';
import 'package:nannyplus/src/ui/list_view.dart';
import 'package:nannyplus/src/ui/sliver_curved_persistent_header.dart';
import 'package:nannyplus/src/ui/ui_card.dart';
import 'package:nannyplus/src/ui/view.dart';
import 'package:nannyplus/utils/text_extension.dart';

class StatementListView extends ConsumerWidget {
  const StatementListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    context.read<StatementListCubit>().loadStatements();
    final deductions = ref.watch(deductionsProvider);

    return BlocBuilder<StatementListCubit, StatementListState>(
      builder: (context, state) {
        return UIView(
          title: Text(context.t('Statements')),
          help: context.t('statements_help'),
          persistentHeader:
              const UISliverCurvedPersistenHeader(child: Text('')),
          body: deductions.when(
            data: (deductions) => UIListView.fromChildren(
              horizontalPadding: kdDefaultPadding,
              children: [
                if (state is StatementListLoaded)
                  ...(() sync* {
                    for (final statement in state.statements) {
                      yield _YearlyStatementCard(
                        statement: statement,
                        deductions: deductions,
                      );
                    }
                  })(),
              ],
            ),
            error: (_, __) => const Text('Error'),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

class _YearlyStatementCard extends ConsumerWidget {
  const _YearlyStatementCard({
    required this.statement,
    required this.deductions,
  });

  final YearlyStatement statement;
  final List<Deduction> deductions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copies = <MonthlyStatement>[];
    var netTotal = 0.0;

    for (final monthlyStatement in statement.monthlyStatements) {
      var amount = monthlyStatement.amount;
      for (final deduction in deductions) {
        if (deduction.periodicity == 'monthly') {
          if (deduction.type == 'percent') {
            amount -= monthlyStatement.amount * deduction.value / 100.0;
          } else {
            amount -= deduction.value;
          }
        }
      }
      copies.add(monthlyStatement.copyWith(netAmount: amount));
      netTotal += amount;
    }

    return UICard(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${statement.year}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(netTotal.toStringAsFixed(2)),
              ),
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                onPressed: () => openPDF(context, DateTime(statement.year)),
              ),
            ],
          ),
        ),
        const Divider(height: 2),
        ...copies.map(
          (statement) => _MonthlyStatementCard(
            statement: statement,
            deductions: deductions,
          ),
        ),
      ],
    );
  }

  void openPDF(BuildContext context, DateTime date) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => StatementView(
          type: StatementViewType.yearly,
          date: date,
          gettext: GettextLocalizations.of(context),
        ),
      ),
    );
  }
}

class _MonthlyStatementCard extends StatelessWidget {
  const _MonthlyStatementCard({
    required this.statement,
    required this.deductions,
  });

  final MonthlyStatement statement;
  final List<Deduction> deductions;

  @override
  Widget build(BuildContext context) {
    final month = DateFormat('MMMM').format(statement.date).capitalize();

    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              month,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              statement.netAmount.toStringAsFixed(2),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => openPDF(context, statement.date),
          ),
        ],
      ),
    );
  }

  void openPDF(BuildContext context, DateTime date) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => StatementView(
          type: StatementViewType.monthly,
          date: date,
          gettext: GettextLocalizations.of(context),
        ),
      ),
    );
  }
}
