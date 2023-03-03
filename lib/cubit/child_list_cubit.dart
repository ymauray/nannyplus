import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/data/children_repository.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/model/service_info.dart';
import 'package:nannyplus/data/services_repository.dart';
import 'package:nannyplus/utils/prefs_util.dart';

part 'child_list_state.dart';

class ChildListCubit extends Cubit<ChildListState> {
  ChildListCubit(this._childrenRepository, this._servicesRepository)
      : super(const ChildListInitial());
  final ChildrenRepository _childrenRepository;
  final ServicesRepository _servicesRepository;

  Future<void> loadChildList({bool loadArchivedFolders = false}) async {
    try {
      final childList =
          await _childrenRepository.getChildList(loadArchivedFolders);
      final servicesInfo = await _servicesRepository.getServiceInfoPerChild();

      final pendingTotal =
          servicesInfo.values.fold<double>(0, (total, service) {
        return total + service.pendingTotal;
      });

      emit(
        ChildListLoaded(
          childList,
          pendingTotal,
          servicesInfo,
          showArchived: loadArchivedFolders,
          showOnboarding: (await PrefsUtil.getInstance()).showOnboarding,
        ),
      );
    } on Exception catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> create(Child child) async {
    try {
      await _childrenRepository.create(child);
      await loadChildList();
    } catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> update(Child child) async {
    try {
      await _childrenRepository.update(child);
      await loadChildList();
    } catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> delete(Child child) async {
    try {
      await _childrenRepository.delete(child);
      await loadChildList();
    } catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> archive(Child child) async {
    try {
      child = child.copyWith(archived: 1);
      await _childrenRepository.update(child);
      //loadChildList();
    } catch (e) {
      emit(ChildListError(e.toString()));
    }
  }

  Future<void> unarchive(Child child) async {
    try {
      child = child.copyWith(archived: 0);
      await _childrenRepository.update(child);
      //loadChildList();
    } catch (e) {
      emit(ChildListError(e.toString()));
    }
  }
}
