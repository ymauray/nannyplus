part of 'service_list_cubit.dart';

@immutable
abstract class ServiceListState {
  const ServiceListState();
}

class ServiceListInitial extends ServiceListState {
  const ServiceListInitial();
}

class ServiceListLoaded extends ServiceListState {
  final List<Service> services;
  final Child child;
  const ServiceListLoaded(this.child, this.services);
}

class ServiceListError extends ServiceListState {
  final String message;
  const ServiceListError(this.message);
}
