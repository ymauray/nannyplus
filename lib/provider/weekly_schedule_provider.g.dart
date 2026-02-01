// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_schedule_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weeklySchedule)
final weeklyScheduleProvider = WeeklyScheduleProvider._();

final class WeeklyScheduleProvider extends $FunctionalProvider<
        AsyncValue<Schedule>, Schedule, FutureOr<Schedule>>
    with $FutureModifier<Schedule>, $FutureProvider<Schedule> {
  WeeklyScheduleProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'weeklyScheduleProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$weeklyScheduleHash();

  @$internal
  @override
  $FutureProviderElement<Schedule> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Schedule> create(Ref ref) {
    return weeklySchedule(ref);
  }
}

String _$weeklyScheduleHash() => r'f31550bd5dc40dcac4b631a0f4abbffc9aa87bc2';
