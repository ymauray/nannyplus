part of 'statement_view_cubit.dart';

@immutable
abstract class StatementViewState {}

class StatementViewInitial extends StatementViewState {}

class StatementViewLoaded extends StatementViewState {
  final Statement statement;
  StatementViewLoaded(this.statement);
}

class StatementViewGenerating extends StatementViewState {}
