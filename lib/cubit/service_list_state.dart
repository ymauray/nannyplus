part of 'service_list_cubit.dart';

@immutable
abstract class ServiceListState {
  const ServiceListState();
}

class ServiceListInitial extends ServiceListState {
  const ServiceListInitial();
}

class ServiceListLoading extends ServiceListState {
  const ServiceListLoading();
}

class ServiceListLoaded extends ServiceListState {
  final List<Service> services;
  const ServiceListLoaded(this.services);
}

class ServiceListError extends ServiceListState {
  final String message;
  const ServiceListError(this.message);
}
