import 'package:nannyplus/cubit/child_list_state.dart';
import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/repository/children_repository.dart';
import 'package:nannyplus/data/repository/invoices_repository.dart';
import 'package:nannyplus/data/repository/services_repository.dart';
import 'package:nannyplus/utils/prefs_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'child_list_provider.g.dart';

@riverpod
class ChildListController extends _$ChildListController {
  @override
  ChildListState build() {
    return const ChildListInitial();
  }

  void reinitialize() {
    state = const ChildListInitial();
  }

  Future<void> loadChildList({
    bool loadArchivedFolders = false,
  }) async {
    final childrenRepository = ref.read(childrenRepositoryProvider);
    final servicesRepository = ref.read(servicesRepositoryProvider);
    final invoicesRepository = ref.read(invoicesRepositoryProvider);

    final childList =
        await childrenRepository.getChildList(loadArchivedFolders);
    final servicesInfo = await servicesRepository.getServiceInfoPerChild();
    final invoicesInfo = await invoicesRepository.getInvoicesInfoPerChild();

    final pendingTotal = servicesInfo.values.fold<double>(0, (total, service) {
      return total + service.pendingTotal;
    });

    final newState = ChildListLoaded(
      childList,
      pendingTotal,
      servicesInfo,
      invoicesInfo,
      showArchived: loadArchivedFolders,
      showOnboarding: (await PrefsUtil.getInstance()).showOnboarding,
    );

    if (newState != state) {
      state = newState;
    }
  }

  Future<void> create(Child child) async {
    final childrenRepository = ref.read(childrenRepositoryProvider);
    try {
      await childrenRepository.create(child);
      await loadChildList();
    } catch (e) {
      state = ChildListError(e.toString());
    }
  }

  Future<void> archive(Child child) async {
    final childrenRepository = ref.read(childrenRepositoryProvider);
    try {
      child = child.copyWith(archived: 1);
      await childrenRepository.update(child);
      //loadChildList();
    } catch (e) {
      state = ChildListError(e.toString());
    }
  }

  Future<void> unarchive(Child child) async {
    final childrenRepository = ref.read(childrenRepositoryProvider);
    try {
      child = child.copyWith(archived: 0);
      await childrenRepository.update(child);
      //loadChildList();
    } catch (e) {
      state = ChildListError(e.toString());
    }
  }

  Future<void> delete(Child child) async {
    final childrenRepository = ref.read(childrenRepositoryProvider);
    try {
      await childrenRepository.delete(child);
      await loadChildList();
    } catch (e) {
      state = ChildListError(e.toString());
    }
  }
}
