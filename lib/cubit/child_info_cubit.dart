import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../data/children_repository.dart';
import '../data/model/child.dart';

part 'child_info_state.dart';

class ChildInfoCubit extends Cubit<ChildInfoState> {
  final ChildrenRepository _childrenRepository;
  ChildInfoCubit(this._childrenRepository) : super(const ChildInfoInitial());

  Future<void> read(int childId) async {
    try {
      var child = await _childrenRepository.read(childId);
      emit(ChildInfoLoaded(child));
    } catch (e) {
      emit(ChildInfoError(e.toString()));
    }
  }

  Future<void> update(Child child) async {
    try {
      var updatedChild = await _childrenRepository.update(child);
      emit(ChildInfoLoaded(updatedChild));
    } catch (e) {
      emit(ChildInfoError(e.toString()));
    }
  }

  void addFile(int id, String label, String path) async {
    try {
      await _childrenRepository.addFile(id, label, path);
    } catch (e) {
      emit(ChildInfoError(e.toString()));
    }
  }
}
