import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/provider/repository/children_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'children.g.dart';

@riverpod
FutureOr<Child> childInfo(ChildInfoRef ref, int childId) async {
  final childrenRepository = ref.read(childrenRepositoryProvider);
  final child = await childrenRepository.read(childId);
  return child;
}

@riverpod
FutureOr<List<Child>> childList(ChildListRef ref, int? excludeId) async {
  final childrenRepository = ref.read(childrenRepositoryProvider);
  final children = await childrenRepository.getChildList(false);
  if (excludeId != null) {
    return children.where((child) => child.id != excludeId).toList();
  }
  return children;
}
