part of 'statement_list_cubit.dart';

@immutable
abstract class StatementListState {}

class StatementListInitial extends StatementListState {}

class StatementListLoaded extends StatementListState {
  StatementListLoaded(this.statements);
  final List<YearlyStatement> statements;
}

class StatementListGenerating extends StatementListState {}
