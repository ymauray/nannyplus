import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/model/child.dart';

part 'child_info_state.dart';

class ChildInfoCubit extends Cubit<ChildInfoState> {
  final ChildrenRepository _childrenRepository;
  ChildInfoCubit(this._childrenRepository) : super(const ChildInfoInitial());

  Future<void> read(int childId) async {
    emit(const ChildInfoLoading());
    try {
      emit(ChildInfoLoaded(await _childrenRepository.read(childId)));
    } catch (e) {
      emit(ChildInfoError(e.toString()));
    }
  }

  Future<void> update(Child child) async {
    emit(const ChildInfoLoading());
    try {
      emit(ChildInfoLoaded(await _childrenRepository.update(child)));
    } catch (e) {
      emit(ChildInfoError(e.toString()));
    }
  }
}
