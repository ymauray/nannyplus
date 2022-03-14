import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/model/child.dart';

part 'child_list_state.dart';

class ChildListCubit extends Cubit<ChildListState> {
  final ChildrenRepository _childrenRepository;

  ChildListCubit(this._childrenRepository) : super(const ChildListInitial());

  Future<void> getChildList() async {
    try {
      final childList = await _childrenRepository.getChildList();
      emit(ChildListLoaded(childList));
    } on Exception catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> update(Child child) async {
    try {
      await _childrenRepository.update(child);
      getChildList();
    } catch (e) {
      emit(ChildListError(e.toString()));
    }
  }
}
