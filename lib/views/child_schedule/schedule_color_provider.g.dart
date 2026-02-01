// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_color_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScheduleColor)
final scheduleColorProvider = ScheduleColorFamily._();

final class ScheduleColorProvider
    extends $AsyncNotifierProvider<ScheduleColor, Color> {
  ScheduleColorProvider._(
      {required ScheduleColorFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'scheduleColorProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$scheduleColorHash();

  @override
  String toString() {
    return r'scheduleColorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ScheduleColor create() => ScheduleColor();

  @override
  bool operator ==(Object other) {
    return other is ScheduleColorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$scheduleColorHash() => r'19f2b242d4970c703b921d8372e20f9797e60f03';

final class ScheduleColorFamily extends $Family
    with
        $ClassFamilyOverride<ScheduleColor, AsyncValue<Color>, Color,
            FutureOr<Color>, int> {
  ScheduleColorFamily._()
      : super(
          retry: null,
          name: r'scheduleColorProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ScheduleColorProvider call(
    int childId,
  ) =>
      ScheduleColorProvider._(argument: childId, from: this);

  @override
  String toString() => r'scheduleColorProvider';
}

abstract class _$ScheduleColor extends $AsyncNotifier<Color> {
  late final _$args = ref.$arg as int;
  int get childId => _$args;

  FutureOr<Color> build(
    int childId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Color>, Color>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Color>, Color>,
        AsyncValue<Color>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
