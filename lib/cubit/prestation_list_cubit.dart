import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/prestation.dart';
import 'package:nannyplus/data/prestations_repository.dart';
import 'package:nannyplus/data/prices_repository.dart';

part 'prestation_list_state.dart';

class PrestationListCubit extends Cubit<PrestationListState> {
  PrestationsRepository prestationsRepository;
  PricesRepository pricesRepository;

  PrestationListCubit(this.prestationsRepository, this.pricesRepository)
      : super(const PrestationListInitial());

  Future<void> getPrestations(Child child) async {
    emit(const PrestationListLoading());
    try {
      final prestations = await prestationsRepository.getPrestations(child);
      emit(PrestationListLoaded(prestations));
    } catch (e) {
      emit(PrestationListError(e.toString()));
    }
  }

  Future<void> create(Prestation prestation, Child child) async {
    try {
      var price = await pricesRepository.read(prestation.priceId);
      prestation = prestation.copyWith(
        childId: child.id,
        priceLabel: price.label,
        isFixedPrice: price.isFixedPrice ? 1 : 0,
        price: price.isFixedPrice
            ? price.amount
            : price.amount * (prestation.hours! + prestation.minutes! / 60),
      );
      prestationsRepository.create(prestation);
      getPrestations(child);
    } catch (e) {
      emit(PrestationListError(e.toString()));
    }
  }
}
