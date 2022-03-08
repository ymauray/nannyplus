part of 'prestation_list_cubit.dart';

@immutable
abstract class PrestationListState {
  const PrestationListState();
}

class PrestationListInitial extends PrestationListState {
  const PrestationListInitial();
}

class PrestationListLoading extends PrestationListState {
  const PrestationListLoading();
}

class PrestationListLoaded extends PrestationListState {
  final List<Prestation> prestations;
  const PrestationListLoaded(this.prestations);
}

class PrestationListError extends PrestationListState {
  final String message;
  const PrestationListError(this.message);
}
