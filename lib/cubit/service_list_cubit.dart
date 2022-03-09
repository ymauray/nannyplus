import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/data/services_repository.dart';
import 'package:nannyplus/data/prices_repository.dart';

part 'service_list_state.dart';

class ServiceListCubit extends Cubit<ServiceListState> {
  ServicesRepository servicesRepository;
  PricesRepository pricesRepository;

  ServiceListCubit(this.servicesRepository, this.pricesRepository)
      : super(const ServiceListInitial());

  Future<void> loadServices(Child child) async {
    emit(const ServiceListLoading());
    try {
      final services = await servicesRepository.getServices(child);
      emit(ServiceListLoaded(services));
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }

  Future<void> create(Service service, Child child) async {
    try {
      var price = await pricesRepository.read(service.priceId);
      service = service.copyWith(
        childId: child.id,
        priceLabel: price.label,
        isFixedPrice: price.isFixedPrice ? 1 : 0,
        price: price.isFixedPrice
            ? price.amount
            : price.amount * (service.hours! + service.minutes! / 60),
      );
      servicesRepository.create(service);
      loadServices(child);
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }

  Future<void> delete(Service service, Child child) async {
    try {
      await servicesRepository.delete(service.id!);
      loadServices(child);
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }
}
