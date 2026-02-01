// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yearly_schedule_pdf_view_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(YearlySchedulePdfViewState)
final yearlySchedulePdfViewStateProvider =
    YearlySchedulePdfViewStateProvider._();

final class YearlySchedulePdfViewStateProvider
    extends
        $NotifierProvider<
          YearlySchedulePdfViewState,
          view.YearlySchedulePdfViewState
        > {
  YearlySchedulePdfViewStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'yearlySchedulePdfViewStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$yearlySchedulePdfViewStateHash();

  @$internal
  @override
  YearlySchedulePdfViewState create() => YearlySchedulePdfViewState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(view.YearlySchedulePdfViewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<view.YearlySchedulePdfViewState>(
        value,
      ),
    );
  }
}

String _$yearlySchedulePdfViewStateHash() =>
    r'7313686076613ecbdf050fbde9701989c433deb9';

abstract class _$YearlySchedulePdfViewState
    extends $Notifier<view.YearlySchedulePdfViewState> {
  view.YearlySchedulePdfViewState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              view.YearlySchedulePdfViewState,
              view.YearlySchedulePdfViewState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                view.YearlySchedulePdfViewState,
                view.YearlySchedulePdfViewState
              >,
              view.YearlySchedulePdfViewState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
