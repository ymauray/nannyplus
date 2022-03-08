import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/prestation.dart';
import 'package:nannyplus/data/prestations_repository.dart';

part 'prestation_list_state.dart';

class PrestationListCubit extends Cubit<PrestationListState> {
  PrestationsRepository prestationsRepository;

  PrestationListCubit(this.prestationsRepository)
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
      prestationsRepository.create(prestation);
      getPrestations(child);
    } catch (e) {
      emit(PrestationListError(e.toString()));
    }
  }
}
