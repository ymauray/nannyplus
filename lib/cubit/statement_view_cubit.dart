import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/statement.dart';
import 'package:nannyplus/data/repository/deduction_repository.dart';
import 'package:nannyplus/data/repository/services_repository.dart';
import 'package:nannyplus/src/statement_view/statement_view.dart';

part 'statement_view_state.dart';

class StatementViewCubit extends Cubit<StatementViewState> {
  StatementViewCubit(
    ServicesRepository servicesRepository,
    DeductionRepository deductionRepository,
  )   : _servicesRepository = servicesRepository,
        _deductionRepository = deductionRepository,
        super(StatementViewInitial());

  final ServicesRepository _servicesRepository;
  final DeductionRepository _deductionRepository;

  Future<void> loadStatement(StatementViewType type, DateTime date) async {
    emit(StatementViewGenerating());
    final lines = await _servicesRepository.getStatementLines(type, date);
    final deductions = await _deductionRepository.readAll();
    emit(StatementViewLoaded(Statement(lines: lines, deductions: deductions)));
  }
}
