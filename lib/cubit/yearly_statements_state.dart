part of 'yearly_statements_cubit.dart';

@immutable
abstract class YearlyStatementsState {}

class YearlyStatementsInitial extends YearlyStatementsState {}

class YearlyStatementsLoaded extends YearlyStatementsState {
  final List<YearlyStatement> statements;
  YearlyStatementsLoaded(this.statements);
}

class YearlyStatementsGenerating extends YearlyStatementsState {}
