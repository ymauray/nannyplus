import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/repository/children_repository.dart';

part 'child_info_state.dart';

class ChildInfoCubit extends Cubit<ChildInfoState> {
  ChildInfoCubit(this._childrenRepository) : super(const ChildInfoInitial());
  final ChildrenRepository _childrenRepository;

  Future<void> read(int childId) async {
    try {
      final child = await _childrenRepository.read(childId);
      emit(ChildInfoLoaded(child));
    } catch (e) {
      emit(ChildInfoError(e.toString()));
    }
  }

  Future<void> update(Child child) async {
    try {
      final updatedChild = await _childrenRepository.update(child);
      emit(ChildInfoLoaded(updatedChild));
    } catch (e) {
      emit(ChildInfoError(e.toString()));
    }
  }
}
