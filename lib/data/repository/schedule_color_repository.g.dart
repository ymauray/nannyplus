// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_color_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scheduleColorRepository)
final scheduleColorRepositoryProvider = ScheduleColorRepositoryProvider._();

final class ScheduleColorRepositoryProvider extends $FunctionalProvider<
    ScheduleColorRepository,
    ScheduleColorRepository,
    ScheduleColorRepository> with $Provider<ScheduleColorRepository> {
  ScheduleColorRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'scheduleColorRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$scheduleColorRepositoryHash();

  @$internal
  @override
  $ProviderElement<ScheduleColorRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ScheduleColorRepository create(Ref ref) {
    return scheduleColorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScheduleColorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScheduleColorRepository>(value),
    );
  }
}

String _$scheduleColorRepositoryHash() =>
    r'fdad631038902b7e0437fb32ce33f9c579be2361';
