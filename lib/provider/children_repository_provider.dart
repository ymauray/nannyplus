import 'package:nannyplus/data/children_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'children_repository_provider.g.dart';

@riverpod
ChildrenRepository childrenRepository(
  ChildrenRepositoryRef ref,
) {
  return const ChildrenRepository();
}
