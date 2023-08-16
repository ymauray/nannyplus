import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/model/monthly_statement.dart';
import 'package:nannyplus/data/model/yearly_statement.dart';
import 'package:nannyplus/data/services_repository.dart';
import 'package:nannyplus/utils/list_extensions.dart';

part 'statement_list_state.dart';

class StatementListCubit extends Cubit<StatementListState> {
  StatementListCubit(
    ServicesRepository servicesRepository,
  )   : _servicesRepository = servicesRepository,
        super(StatementListInitial());

  final ServicesRepository _servicesRepository;

  Future<void> loadStatements() async {
    final summaries = await _servicesRepository.getStatementsSummary();

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
    //final children = await _childrenRepository.getChildList(true);
    //var invoices = <Invoice>[];
    //for (final child in children) {
    //  invoices.addAll(
    //    await _invoicesRepository.getInvoiceList(
    //      child.id!,
    //      loadPaidInvoices: true,
    //    ),
    //  );
    //}
    //final invoiceGroups = invoices.groupBy<int>(
    //  (invoice) => DateFormat('yyyy-MM-dd').parse(invoice.date).year,
    //  groupComparator: (a, b) => b.compareTo(a),
    //);
    //final statements = invoiceGroups
    //    .map(
    //      (group) => YearlyStatement(
    //        year: group.key,
    //        amount: group.value.fold(
    //          0.0,
    //          (total, invoice) => total + invoice.total,
    //        ),
    //        monthlyStatements: group.value
    //            .groupBy<DateTime>(
    //              (invoice) {
    //                final invoiceDate =
    //                    DateFormat('yyyy-MM-dd').parse(invoice.date);

    //                return DateTime(invoiceDate.year, invoiceDate.month, 1);
    //              },
    //              groupComparator: (a, b) => b.compareTo(a),
    //            )
    //            .map(
    //              (group) => MonthlyStatement(
    //                date: group.key,
    //                amount: group.value
    //                    .fold(0.0, (total, invoice) => total + invoice.total),
    //              ),
    //            )
    //            .toList(),
    //      ),
    //    )
    //    .toList();

    emit(StatementListLoaded(statements));
  }

  Future<void> generateStatements() async {
    emit(StatementListGenerating());
    await Future<void>.delayed(const Duration(seconds: 10));
    await loadStatements();
  }
}
