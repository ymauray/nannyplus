// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_period_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vacationPeriodRepository)
final vacationPeriodRepositoryProvider = VacationPeriodRepositoryProvider._();

final class VacationPeriodRepositoryProvider extends $FunctionalProvider<
    VacationPeriodRepository,
    VacationPeriodRepository,
    VacationPeriodRepository> with $Provider<VacationPeriodRepository> {
  VacationPeriodRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'vacationPeriodRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vacationPeriodRepositoryHash();

  @$internal
  @override
  $ProviderElement<VacationPeriodRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VacationPeriodRepository create(Ref ref) {
    return vacationPeriodRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VacationPeriodRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VacationPeriodRepository>(value),
    );
  }
}

String _$vacationPeriodRepositoryHash() =>
    r'278f621be4816b42306e4dce84002d64dc292872';
