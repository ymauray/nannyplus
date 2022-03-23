import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/services_repository.dart';

part 'child_list_state.dart';

class ChildListCubit extends Cubit<ChildListState> {
  final ChildrenRepository _childrenRepository;
  final ServicesRepository _servicesRepository;

  ChildListCubit(this._childrenRepository, this._servicesRepository)
      : super(const ChildListInitial());

  Future<void> loadChildList() async {
    try {
      final childList =
          await _childrenRepository.getChildList(state.showArchivedItems);
      final pendingTotal = await _servicesRepository.getPendingTotal();
      final pendingTotalPerChild =
          await _servicesRepository.getPendingTotalPerChild();
      emit(
        ChildListLoaded(
          childList,
          pendingTotal,
          pendingTotalPerChild,
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

  Future<void> unarchive(Child child) async {
    try {
      child = child.copyWith(archived: 0);
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
        final pendingTotal = await _servicesRepository.getPendingTotal();
        final pendingTotalPerChild =
            await _servicesRepository.getPendingTotalPerChild();

        emit(ChildListLoaded(
          childList,
          pendingTotal,
          pendingTotalPerChild,
          showArchived: true,
        ));
      }
    } on Exception catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> hideArchivedItems() async {
    try {
      if (state is ChildListLoaded) {
        final childList = await _childrenRepository.getChildList(false);
        final pendingTotal = await _servicesRepository.getPendingTotal();
        final pendingTotalPerChild =
            await _servicesRepository.getPendingTotalPerChild();

        emit(ChildListLoaded(
          childList,
          pendingTotal,
          pendingTotalPerChild,
          showArchived: false,
        ));
      }
    } on Exception catch (e) {
      emit(ChildListError(e.toString()));
    }
  }
}
