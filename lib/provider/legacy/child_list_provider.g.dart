// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChildListController)
final childListControllerProvider = ChildListControllerProvider._();

final class ChildListControllerProvider
    extends $NotifierProvider<ChildListController, ChildListState> {
  ChildListControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'childListControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childListControllerHash();

  @$internal
  @override
  ChildListController create() => ChildListController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChildListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChildListState>(value),
    );
  }
}

String _$childListControllerHash() =>
    r'296bc2542649a36ce2f5e7ae43c64ceb7742c79c';

abstract class _$ChildListController extends $Notifier<ChildListState> {
  ChildListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ChildListState, ChildListState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ChildListState, ChildListState>,
        ChildListState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
