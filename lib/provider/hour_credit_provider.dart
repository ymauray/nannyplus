import 'package:nannyplus/data/repository/children_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hour_credit_provider.g.dart';

@riverpod
class HourCredit extends _$HourCredit {
  @override
  FutureOr<int> build(int childId) async {
    final childrenRepository = ref.read(childrenRepositoryProvider);
    final child = await childrenRepository.read(childId);
    return child.hourCredits;
  }

  FutureOr<void> addHourCredit() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final childrenRepository = ref.read(childrenRepositoryProvider);
      var child = await childrenRepository.read(childId);
      child = child.copyWith(hourCredits: child.hourCredits + 1);
      await childrenRepository.update(child);
      return child.hourCredits;
    });
  }

  FutureOr<void> subtractHourCredit() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final childrenRepository = ref.read(childrenRepositoryProvider);
      var child = await childrenRepository.read(childId);
      child = child.copyWith(hourCredits: child.hourCredits - 1);
      await childrenRepository.update(child);
      return child.hourCredits;
    });
  }
}
