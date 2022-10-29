import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service.dart';
import 'package:nannyplus/data/prices_repository.dart';
import 'package:nannyplus/data/services_repository.dart';

part 'service_list_state.dart';

class ServiceListCubit extends Cubit<ServiceListState> {
  ServiceListCubit(
    this.servicesRepository,
    this.pricesRepository,
    this.childrenRepository,
  ) : super(const ServiceListInitial());
  ServicesRepository servicesRepository;
  PricesRepository pricesRepository;
  ChildrenRepository childrenRepository;

  Future<void> loadServices(int childId) async {
    try {
      final child = await childrenRepository.read(childId);
      final prices = await pricesRepository.getPriceList();
      final services = await servicesRepository.getServices(child);
      services
        ..removeWhere((service) => service.priceId < 0)
        ..sort(
          (a, b) =>
              prices.firstWhere((price) => price.id == a.priceId).sortOrder -
              prices.firstWhere((price) => price.id == b.priceId).sortOrder,
        );
      emit(ServiceListLoaded(child, services));
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }

  Future<void> create(Service service, int childId) async {
    try {
      final price = await pricesRepository.read(service.priceId);
      service = service.copyWith(
        childId: childId,
        priceLabel: price.label,
        isFixedPrice: price.isFixedPrice ? 1 : 0,
        total: price.isFixedPrice
            ? price.amount
            : price.amount * (service.hours! + service.minutes! / 60),
      );
      await servicesRepository.create(service);
      await loadServices(childId);
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }

  Future<void> update(Service service, int childId) async {
    try {
      final price = await pricesRepository.read(service.priceId);
      service = service.copyWith(
        priceLabel: price.label,
        isFixedPrice: price.isFixedPrice ? 1 : 0,
        total: price.isFixedPrice
            ? price.amount
            : price.amount * (service.hours! + service.minutes! / 60),
      );
      await servicesRepository.update(service);
      await loadServices(childId);
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }

  Future<void> delete(Service service, int childId) async {
    try {
      await servicesRepository.delete(service.id!);
      await loadServices(childId);
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }

  Future<void> deleteDay(int childId, String date) async {
    try {
      await servicesRepository.deleteForChildAndDate(childId, date);
      await loadServices(childId);
    } catch (e) {
      emit(ServiceListError(e.toString()));
    }
  }
}
