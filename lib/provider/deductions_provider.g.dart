// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deductions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Deductions)
final deductionsProvider = DeductionsProvider._();

final class DeductionsProvider
    extends $AsyncNotifierProvider<Deductions, List<Deduction>> {
  DeductionsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'deductionsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$deductionsHash();

  @$internal
  @override
  Deductions create() => Deductions();
}

String _$deductionsHash() => r'5875e6770ab1eecb27e37d2b085b3fbae7f0f739';

abstract class _$Deductions extends $AsyncNotifier<List<Deduction>> {
  FutureOr<List<Deduction>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Deduction>>, List<Deduction>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Deduction>>, List<Deduction>>,
        AsyncValue<List<Deduction>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
