import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/monthly_statement.dart';
import 'package:nannyplus/data/model/yearly_statement.dart';
import 'package:nannyplus/data/repository/services_repository.dart';
import 'package:nannyplus/utils/list_extensions.dart';

part 'statement_list_state.dart';

class StatementListCubit extends Cubit<StatementListState> {
  StatementListCubit(
    ServicesRepository servicesRepository,
  )   : _servicesRepository = servicesRepository,
        super(StatementListInitial());

  final ServicesRepository _servicesRepository;

  Future<void> loadStatements() async {
    final formatter = DateFormat('yyyy-MM');
    final currentMonth = formatter.format(DateTime.now());

    final summaries = (await _servicesRepository.getStatementsSummary())
        .where((statement) => statement.month != currentMonth)
        .toList();

    final summaryGroups = summaries.groupBy<num>(
      (summary) => DateFormat('yyyy-MM').parse(summary.month).year,
      groupComparator: (a, b) => b.compareTo(a),
    );

    final statements = summaryGroups
        .map(
          (group) => YearlyStatement(
            year: group.key as int,
            amount: group.value.fold(
              0,
              (previousValue, summary) => previousValue + summary.total,
            ),
            monthlyStatements: group.value
                .map(
                  (summary) => MonthlyStatement(
                    date: DateFormat('yyyy-MM').parse(summary.month),
                    amount: summary.total,
                    netAmount: 0,
                  ),
                )
                .toList(),
          ),
        )
        .toList();

    emit(StatementListLoaded(statements));
  }

  Future<void> generateStatements() async {
    emit(StatementListGenerating());
    await Future<void>.delayed(const Duration(seconds: 10));
    await loadStatements();
  }
}
