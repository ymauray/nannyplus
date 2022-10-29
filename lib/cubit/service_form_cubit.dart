import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/data/prices_repository.dart';
import 'package:nannyplus/data/services_repository.dart';
import 'package:nannyplus/utils/list_extensions.dart';

part 'service_form_state.dart';

class ServiceFormCubit extends Cubit<ServiceFormState> {
  ServiceFormCubit(this._servicesRepository, this._pricesRepository)
      : super(const ServiceFormInitial());
  final ServicesRepository _servicesRepository;
  final PricesRepository _pricesRepository;

  Future<void> loadRecentServices(int childId, DateTime? date, int tab) async {
    try {
      final prices = await _pricesRepository.getPriceList();
      final services = await _servicesRepository.getRecentServices(childId);
      final groups = services.groupBy<num>((service) => service.priceId);
      final orderedServices = groups.map((group) => group.value.first).toList()
        ..sort(
          (a, b) =>
              prices.firstWhere((price) => price.id == a.priceId).sortOrder -
              prices.firstWhere((price) => price.id == b.priceId).sortOrder,
        );

      final selectedServices = await _servicesRepository
          .getServicesForChildAndDate(childId, date ?? DateTime.now());
      selectedServices.sort(
        (a, b) =>
            prices.firstWhere((price) => price.id == a.priceId).sortOrder -
            prices.firstWhere((price) => price.id == b.priceId).sortOrder,
      );

      emit(
        ServiceFormLoaded(
          tab,
          date ?? DateTime.now(),
          orderedServices,
          prices,
          selectedServices,
        ),
      );
    } catch (e) {
      emit(ServiceFormError(e.toString()));
    }
  }

  Future<void> selectTab(int index) async {
    emit((state as ServiceFormLoaded).copyWith(selectedTab: index));
  }

  Future<void> addService(Service service, int childId, DateTime? date) async {
    await _servicesRepository.create(service);

    return loadRecentServices(childId, date, 0);
  }

  Future<void> updateService(Service service) async {
    final newService = await _servicesRepository.update(service);
    final updatedServices = ((List<Service> services) sync* {
      for (service in services) {
        yield service.id == newService.id ? newService : service;
      }
    })((state as ServiceFormLoaded).selectedServices);

    emit(
      (state as ServiceFormLoaded).copyWith(
        selectedServices: updatedServices.toList(),
      ),
    );
  }

  void deleteService(Service service) {
    _servicesRepository.delete(service.id!);
  }
}
