import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/utils/list_extensions.dart';

import '../data/model/price.dart';
import '../data/model/service.dart';
import '../data/prices_repository.dart';
import '../data/services_repository.dart';

part 'service_form_state.dart';

class ServiceFormCubit extends Cubit<ServiceFormState> {
  final ServicesRepository _servicesRepository;
  final PricesRepository _pricesRepository;
  ServiceFormCubit(this._servicesRepository, this._pricesRepository)
      : super(const ServiceFormInitial());

  Future<void> loadRecentServices(int childId, DateTime? date, int tab) async {
    emit(const ServiceFormInitial());
    try {
      final prices = await _pricesRepository.getPriceList();
      final services = await _servicesRepository.getRecentServices(childId);
      final groups = services.groupBy((service) => service.priceId);
      final orderedServices = groups.map((group) => group.value.first).toList();

      final selectedServices = await _servicesRepository
          .getServicesForChildAndDate(childId, date ?? DateTime.now());

      emit(
        ServiceFormLoaded(tab, date, orderedServices, prices, selectedServices),
      );
    } catch (e) {
      emit(ServiceFormError(e.toString()));
    }
  }

  Future<void> selectTab(int index) async {
    emit((state as ServiceFormLoaded).copyWith(selectedTab: index));
  }

  Future<void> addService(Service service) async {
    var newService = await _servicesRepository.create(service);
    emit((state as ServiceFormLoaded).copyWith(
      selectedServices:
          (state as ServiceFormLoaded).selectedServices + [newService],
    ));
  }

  Future<void> updateService(Service service) async {
    var newService = await _servicesRepository.update(service);
    var updatedServices = ((services) sync* {
      for (service in services) {
        yield service.id == newService.id ? newService : service;
      }
    })((state as ServiceFormLoaded).selectedServices);

    emit((state as ServiceFormLoaded).copyWith(
      selectedServices: updatedServices.toList(),
    ));
  }

  void deleteService(Service service) {
    _servicesRepository.delete(service.id!);
  }
}
