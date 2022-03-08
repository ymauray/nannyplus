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
    emit(PriceListLoaded(priceList));
  }
}
