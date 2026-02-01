// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periods_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Periods)
final periodsProvider = PeriodsFamily._();

final class PeriodsProvider
    extends $AsyncNotifierProvider<Periods, List<Period>> {
  PeriodsProvider._(
      {required PeriodsFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'periodsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$periodsHash();

  @override
  String toString() {
    return r'periodsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Periods create() => Periods();

  @override
  bool operator ==(Object other) {
    return other is PeriodsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$periodsHash() => r'2e5ca4e368298dca5b59a0b53a61724e0cbf195c';

final class PeriodsFamily extends $Family
    with
        $ClassFamilyOverride<Periods, AsyncValue<List<Period>>, List<Period>,
            FutureOr<List<Period>>, int> {
  PeriodsFamily._()
      : super(
          retry: null,
          name: r'periodsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PeriodsProvider call(
    int childId,
  ) =>
      PeriodsProvider._(argument: childId, from: this);

  @override
  String toString() => r'periodsProvider';
}

abstract class _$Periods extends $AsyncNotifier<List<Period>> {
  late final _$args = ref.$arg as int;
  int get childId => _$args;

  FutureOr<List<Period>> build(
    int childId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Period>>, List<Period>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Period>>, List<Period>>,
        AsyncValue<List<Period>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
