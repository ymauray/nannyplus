import 'package:nannyplus/data/model/child.dart';
import 'package:nannyplus/provider/repository/children_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'child_info_provider.g.dart';

@riverpod
FutureOr<Child> childInfo(ChildInfoRef ref, int childId) async {
  final childrenRepository = ref.read(childrenRepositoryProvider);
  return childrenRepository.read(childId);
}
