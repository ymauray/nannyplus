import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/data/services_repository.dart';
import 'package:nannyplus/data/prices_repository.dart';

part 'service_list_state.dart';

class ServiceListCubit extends Cubit<ServiceListState> {
  ServicesRepository servicesRepository;
  PricesRepository pricesRepository;
  ChildrenRepository childrenRepository;

  ServiceListCubit(
    this.servicesRepository,
    this.pricesRepository,
    this.childrenRepository,
  ) : super(const ServiceListInitial());

  Future<void> loadServices(int childId) async {
    try {
      final child = await childrenRepository.read(childId);
      final services = await servicesRepository.getServices(child);
      emit(ServiceListLoaded(child, services));
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }

  Future<void> create(Service service, int childId) async {
    try {
      var price = await pricesRepository.read(service.priceId);
      service = service.copyWith(
        childId: childId,
        priceLabel: price.label,
        isFixedPrice: price.isFixedPrice ? 1 : 0,
        total: price.isFixedPrice
            ? price.amount
            : price.amount * (service.hours! + service.minutes! / 60),
      );
      servicesRepository.create(service);
      loadServices(childId);
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }

  Future<void> update(Service service, int childId) async {
    try {
      var price = await pricesRepository.read(service.priceId);
      service = service.copyWith(
        priceLabel: price.label,
        isFixedPrice: price.isFixedPrice ? 1 : 0,
        total: price.isFixedPrice
            ? price.amount
            : price.amount * (service.hours! + service.minutes! / 60),
      );
      servicesRepository.update(service);
      loadServices(childId);
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }

  Future<void> delete(Service service, int childId) async {
    try {
      await servicesRepository.delete(service.id!);
      loadServices(childId);
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }

  Future<void> deleteDay(int childId, String date) async {
    try {
      await servicesRepository.deleteForChildAndDate(childId, date);
      loadServices(childId);
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }
}
