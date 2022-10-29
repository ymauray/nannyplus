import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/price.dart';
import 'package:nannyplus/data/prices_repository.dart';

part 'price_list_state.dart';

class PriceListCubit extends Cubit<PriceListState> {
  PriceListCubit(this._pricesRepository) : super(const PriceListInitial());
  final PricesRepository _pricesRepository;

  Future<void> getPriceList() async {
    final priceList = await _pricesRepository.getPriceList();
    //final inUse = await _pricesRepository.getPricesInUse();

    emit(PriceListLoaded(priceList /*, inUse*/));
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    await _pricesRepository.reorder(oldIndex, newIndex);

    return getPriceList();
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
