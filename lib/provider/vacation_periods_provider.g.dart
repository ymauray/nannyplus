// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_periods_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VacationPeriods)
final vacationPeriodsProvider = VacationPeriodsFamily._();

final class VacationPeriodsProvider
    extends $AsyncNotifierProvider<VacationPeriods, List<VacationPeriod>> {
  VacationPeriodsProvider._(
      {required VacationPeriodsFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'vacationPeriodsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vacationPeriodsHash();

  @override
  String toString() {
    return r'vacationPeriodsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VacationPeriods create() => VacationPeriods();

  @override
  bool operator ==(Object other) {
    return other is VacationPeriodsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vacationPeriodsHash() => r'a7c0424725a7752dc04815e196cc28a037021c98';

final class VacationPeriodsFamily extends $Family
    with
        $ClassFamilyOverride<VacationPeriods, AsyncValue<List<VacationPeriod>>,
            List<VacationPeriod>, FutureOr<List<VacationPeriod>>, int> {
  VacationPeriodsFamily._()
      : super(
          retry: null,
          name: r'vacationPeriodsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  VacationPeriodsProvider call(
    int year,
  ) =>
      VacationPeriodsProvider._(argument: year, from: this);

  @override
  String toString() => r'vacationPeriodsProvider';
}

abstract class _$VacationPeriods extends $AsyncNotifier<List<VacationPeriod>> {
  late final _$args = ref.$arg as int;
  int get year => _$args;

  FutureOr<List<VacationPeriod>> build(
    int year,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<VacationPeriod>>, List<VacationPeriod>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<VacationPeriod>>, List<VacationPeriod>>,
        AsyncValue<List<VacationPeriod>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
