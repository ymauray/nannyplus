// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_card_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HelpCardStatus)
final helpCardStatusProvider = HelpCardStatusFamily._();

final class HelpCardStatusProvider
    extends $AsyncNotifierProvider<HelpCardStatus, bool> {
  HelpCardStatusProvider._({
    required HelpCardStatusFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'helpCardStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$helpCardStatusHash();

  @override
  String toString() {
    return r'helpCardStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HelpCardStatus create() => HelpCardStatus();

  @override
  bool operator ==(Object other) {
    return other is HelpCardStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$helpCardStatusHash() => r'7cd3dce56edfd7d2f82ba8dec7134a22816b1f18';

final class HelpCardStatusFamily extends $Family
    with
        $ClassFamilyOverride<
          HelpCardStatus,
          AsyncValue<bool>,
          bool,
          FutureOr<bool>,
          int
        > {
  HelpCardStatusFamily._()
    : super(
        retry: null,
        name: r'helpCardStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HelpCardStatusProvider call(int code) =>
      HelpCardStatusProvider._(argument: code, from: this);

  @override
  String toString() => r'helpCardStatusProvider';
}

abstract class _$HelpCardStatus extends $AsyncNotifier<bool> {
  late final _$args = ref.$arg as int;
  int get code => _$args;

  FutureOr<bool> build(int code);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
