// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_planning_view_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VacationPlanningViewState)
final vacationPlanningViewStateProvider = VacationPlanningViewStateProvider._();

final class VacationPlanningViewStateProvider
    extends
        $AsyncNotifierProvider<
          VacationPlanningViewState,
          view.VacationPlanningViewState
        > {
  VacationPlanningViewStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vacationPlanningViewStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vacationPlanningViewStateHash();

  @$internal
  @override
  VacationPlanningViewState create() => VacationPlanningViewState();
}

String _$vacationPlanningViewStateHash() =>
    r'eae742bcef383ea6239dae41ffd09afb8c0f6753';

abstract class _$VacationPlanningViewState
    extends $AsyncNotifier<view.VacationPlanningViewState> {
  FutureOr<view.VacationPlanningViewState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<view.VacationPlanningViewState>,
              view.VacationPlanningViewState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<view.VacationPlanningViewState>,
                view.VacationPlanningViewState
              >,
              AsyncValue<view.VacationPlanningViewState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
