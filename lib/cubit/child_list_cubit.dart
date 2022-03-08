import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/model/child.dart';

part 'child_list_state.dart';

class ChildListCubit extends Cubit<ChildListState> {
  final ChildrenRepository _childRepository;

  ChildListCubit(this._childRepository) : super(const ChildListInitial());

  Future<void> getChildList() async {
    try {
      final childList = await _childRepository.getChildList();
      emit(ChildListLoaded(childList));
    } on Exception catch (e) {
      emit(ChildListError(e.toString()));
    }
  }
}
