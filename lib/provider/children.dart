import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/data/repository/children_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'children.g.dart';

@riverpod
Raw<FutureOr<List<Child>>> childList(ChildListRef ref, int? excludeId) async {
  final childrenRepository = ref.read(childrenRepositoryProvider);
  final children = await childrenRepository.getChildList(false);
  if (excludeId != null) {
    return children.where((child) => child.id != excludeId).toList();
  }
  return children;
}
