import 'package:nannyplus/data/model/deduction.dart';
import 'package:nannyplus/data/repository/deduction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deductions_provider.g.dart';

@riverpod
class Deductions extends _$Deductions {
  @override
  FutureOr<List<Deduction>> build() async {
    final deductionRepository = ref.read(deductionRepositoryProvider);
    return deductionRepository.readAll();
  }

  FutureOr<void> add(Deduction deduction) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final deductionRepository = ref.read(deductionRepositoryProvider);
      await deductionRepository.create(deduction);
      return await deductionRepository.readAll();
    });
  }

  FutureOr<void> upd(Deduction deduction) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final deductionRepository = ref.read(deductionRepositoryProvider);
      await deductionRepository.update(deduction);
      return await deductionRepository.readAll();
    });
  }

  FutureOr<void> remove(Deduction deduction) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final deductionRepository = ref.read(deductionRepositoryProvider);
      await deductionRepository.delete(deduction);

      return await deductionRepository.readAll();
    });
  }

  FutureOr<void> reorder(int oldIndex, int newIndex) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final deductionRepository = ref.read(deductionRepositoryProvider);
      await deductionRepository.reorder(oldIndex: oldIndex, newIndex: newIndex);
      return await deductionRepository.readAll();
    });
  }
}
