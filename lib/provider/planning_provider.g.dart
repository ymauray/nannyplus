// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Planning)
final planningProvider = PlanningProvider._();

final class PlanningProvider
    extends $AsyncNotifierProvider<Planning, List<view.Planning>> {
  PlanningProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'planningProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$planningHash();

  @$internal
  @override
  Planning create() => Planning();
}

String _$planningHash() => r'88679dc836319826795cbf89ae6461da79c72768';

abstract class _$Planning extends $AsyncNotifier<List<view.Planning>> {
  FutureOr<List<view.Planning>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<view.Planning>>, List<view.Planning>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<view.Planning>>, List<view.Planning>>,
        AsyncValue<List<view.Planning>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
