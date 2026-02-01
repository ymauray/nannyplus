// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deduction_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deductionRepository)
final deductionRepositoryProvider = DeductionRepositoryProvider._();

final class DeductionRepositoryProvider
    extends
        $FunctionalProvider<
          DeductionRepository,
          DeductionRepository,
          DeductionRepository
        >
    with $Provider<DeductionRepository> {
  DeductionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deductionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deductionRepositoryHash();

  @$internal
  @override
  $ProviderElement<DeductionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeductionRepository create(Ref ref) {
    return deductionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeductionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeductionRepository>(value),
    );
  }
}

String _$deductionRepositoryHash() =>
    r'61eaea93903d078c78314b8e0a5d0f3429e0d238';
