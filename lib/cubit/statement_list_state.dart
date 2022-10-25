part of 'statement_list_cubit.dart';

@immutable
abstract class StatementListState {}

class StatementListInitial extends StatementListState {}

class StatementListLoaded extends StatementListState {
  final List<YearlyStatement> statements;
  StatementListLoaded(this.statements);
}

class StatementListGenerating extends StatementListState {}
