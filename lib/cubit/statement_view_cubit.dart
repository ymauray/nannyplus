import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/services_repository.dart';
import 'package:nannyplus/src/statement_view/statement_view.dart';

import '../data/model/statement.dart';

part 'statement_view_state.dart';

class StatementViewCubit extends Cubit<StatementViewState> {
  StatementViewCubit(
    ServicesRepository servicesRepository,
  )   : _servicesRepository = servicesRepository,
        super(StatementViewInitial());

  final ServicesRepository _servicesRepository;

  Future<void> loadStatement(StatementViewType type, DateTime date) async {
    emit(StatementViewGenerating());
    final lines = await _servicesRepository.getStatementLines(type, date);
    emit(StatementViewLoaded(Statement(lines: lines)));
  }
}
