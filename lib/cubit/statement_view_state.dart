part of 'statement_view_cubit.dart';

@immutable
abstract class StatementViewState {}

class StatementViewInitial extends StatementViewState {}

class StatementViewLoaded extends StatementViewState {
  StatementViewLoaded(this.statement);
  final Statement statement;
}

class StatementViewGenerating extends StatementViewState {}
