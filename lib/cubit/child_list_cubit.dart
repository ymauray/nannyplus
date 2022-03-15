import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/model/child.dart';

part 'child_list_state.dart';

class ChildListCubit extends Cubit<ChildListState> {
  final ChildrenRepository _childrenRepository;

  ChildListCubit(this._childrenRepository) : super(const ChildListInitial());

  Future<void> loadChildList() async {
    try {
      final childList =
          await _childrenRepository.getChildList(state.showArchivedItems);
      emit(
        ChildListLoaded(
          childList,
          showArchived: state.showArchivedItems,
        ),
      );
    } on Exception catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> create(Child child) async {
    try {
      await _childrenRepository.create(child);
      loadChildList();
    } catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> update(Child child) async {
    try {
      await _childrenRepository.update(child);
      loadChildList();
    } catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> delete(Child child) async {
    try {
      await _childrenRepository.delete(child);
      loadChildList();
    } catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> archive(Child child) async {
    try {
      child = child.copyWith(archived: 1);
      await _childrenRepository.update(child);
      loadChildList();
    } catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> showArchivedItems() async {
    try {
      if (state is ChildListLoaded) {
        final childList = await _childrenRepository.getChildList(true);
        emit(ChildListLoaded(childList, showArchived: true));
      }
    } on Exception catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> hideArchivedItems() async {
    try {
      if (state is ChildListLoaded) {
        final childList = await _childrenRepository.getChildList(false);
        emit(ChildListLoaded(childList, showArchived: false));
      }
    } on Exception catch (e) {
      emit(ChildListError(e.toString()));
    }
  }
}
