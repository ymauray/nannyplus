part of 'service_list_cubit.dart';

@immutable
abstract class ServiceListState {
  const ServiceListState();
}

class ServiceListInitial extends ServiceListState {
  const ServiceListInitial();
}

class ServiceListLoaded extends ServiceListState {
  const ServiceListLoaded(this.child, this.services);
  final List<Service> services;
  final Child child;
}

class ServiceListError extends ServiceListState {
  const ServiceListError(this.message);
  final String message;
}
