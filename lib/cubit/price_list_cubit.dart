import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:nannyplus/data/prices_repository.dart';

part 'price_list_state.dart';

class PriceListCubit extends Cubit<PriceListState> {
  final PricesRepository _pricesRepository;
  PriceListCubit(this._pricesRepository) : super(const PriceListInitial());

  Future<void> getPriceList() async {
    final priceList = await _pricesRepository.getPriceList();
    final inUse = await _pricesRepository.getPricesInUse();

    emit(PriceListLoaded(priceList, inUse));
  }

  Future<void> create(Price price) async {
    await _pricesRepository.create(price);
    await getPriceList();
  }

  Future<void> update(Price price) async {
    await _pricesRepository.update(price);
    await getPriceList();
  }

  Future<void> delete(int priceId) async {
    await _pricesRepository.delete(priceId);
    await getPriceList();
  }
}
