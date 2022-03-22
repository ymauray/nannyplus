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

  Future<void> loadRecentServices(int childId) async {
    emit(const ServiceFormInitial());
    try {
      // final pricesMap =
      //     Map<int, Price>.fromIterable(prices, key: (prices) => prices.id);

      final prices = await _pricesRepository.getPriceList();
      final services = await _servicesRepository.getRecentServices(childId);
      final groups = services.groupBy((service) => service.priceId);
      final orderedServices = groups.map((group) => group.value.first).toList();

      // final orderedPrices =
      //     groups.map((group) => pricesMap[group.key]!).toList();

      // emit(ServiceFormLoaded(orderedPrices));
      emit(ServiceFormLoaded(0, orderedServices, prices, const []));
    } catch (e) {
      emit(ServiceFormError(e.toString()));
    }
  }

  Future<void> selectTab(int index) async {
    emit((state as ServiceFormLoaded).copyWith(selectedTab: index));
  }

  Future<void> addService(Service service) async {
    emit((state as ServiceFormLoaded)
        .copyWith(services: (state as ServiceFormLoaded).services + [service]));
  }
}
