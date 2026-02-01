// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scheduleRepository)
final scheduleRepositoryProvider = ScheduleRepositoryProvider._();

final class ScheduleRepositoryProvider extends $FunctionalProvider<
    ScheduleRepository,
    ScheduleRepository,
    ScheduleRepository> with $Provider<ScheduleRepository> {
  ScheduleRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'scheduleRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$scheduleRepositoryHash();

  @$internal
  @override
  $ProviderElement<ScheduleRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ScheduleRepository create(Ref ref) {
    return scheduleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScheduleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScheduleRepository>(value),
    );
  }
}

String _$scheduleRepositoryHash() =>
    r'be9cad8973a1f0c38371114a8b04d62c83ff24c1';
