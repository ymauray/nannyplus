import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/invoices_repository.dart';
import 'package:nannyplus/data/model/yearly_statement.dart';
import 'package:nannyplus/utils/list_extensions.dart';

import '../data/model/invoice.dart';
import '../data/model/monthly_statement.dart';

part 'yearly_statements_state.dart';

class YearlyStatementsCubit extends Cubit<YearlyStatementsState> {
  YearlyStatementsCubit(
    ChildrenRepository childrenRepository,
    InvoicesRepository invoicesRepository,
  )   : _childrenRepository = childrenRepository,
        _invoicesRepository = invoicesRepository,
        super(YearlyStatementsInitial());

  final ChildrenRepository _childrenRepository;
  final InvoicesRepository _invoicesRepository;

  Future<void> loadStatements() async {
    final children = await _childrenRepository.getChildList(true);
    var invoices = <Invoice>[];
    for (final child in children) {
      invoices.addAll(
        await _invoicesRepository.getInvoiceList(
          child.id!,
          loadPaidInvoices: true,
        ),
      );
    }
    final invoiceGroups = invoices.groupBy<int>(
      (invoice) => DateFormat('yyyy-MM-dd').parse(invoice.date).year,
      groupComparator: (a, b) => b.compareTo(a),
    );
    final statements = invoiceGroups
        .map(
          (group) => YearlyStatement(
            year: group.key,
            amount: group.value.fold(
              0.0,
              (total, invoice) => total + invoice.total,
            ),
            monthlyStatements: group.value
                .groupBy<DateTime>(
                  (invoice) {
                    final invoiceDate =
                        DateFormat('yyyy-MM-dd').parse(invoice.date);

                    return DateTime(invoiceDate.year, invoiceDate.month, 1);
                  },
                  groupComparator: (a, b) => b.compareTo(a),
                )
                .map(
                  (group) => MonthlyStatement(
                    date: group.key,
                    amount: group.value
                        .fold(0.0, (total, invoice) => total + invoice.total),
                  ),
                )
                .toList(),
          ),
        )
        .toList();

    emit(YearlyStatementsLoaded(statements));
  }

  Future<void> generateStatements() async {
    emit(YearlyStatementsGenerating());
    loadStatements();
  }
}
