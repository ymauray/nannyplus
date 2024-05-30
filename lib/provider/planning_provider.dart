import 'package:nannyplus/data/model/planning.dart' as view;
import 'package:nannyplus/data/repository/planning_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'planning_provider.g.dart';

@riverpod
class Planning extends _$Planning {
  @override
  FutureOr<List<view.Planning>> build() async {
    final repository = ref.read(planningRepositoryProvider);
    final plannings = await repository.load();
    return plannings;
  }
}
