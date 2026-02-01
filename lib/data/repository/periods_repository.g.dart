// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periods_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(periodsRepository)
final periodsRepositoryProvider = PeriodsRepositoryProvider._();

final class PeriodsRepositoryProvider
    extends
        $FunctionalProvider<
          PeriodsRepository,
          PeriodsRepository,
          PeriodsRepository
        >
    with $Provider<PeriodsRepository> {
  PeriodsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'periodsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$periodsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PeriodsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PeriodsRepository create(Ref ref) {
    return periodsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PeriodsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PeriodsRepository>(value),
    );
  }
}

String _$periodsRepositoryHash() => r'b4f9b5925c85aa104ea6f4e6a5de2c74f58336ba';
