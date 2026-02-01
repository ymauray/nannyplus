// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hour_credit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HourCredit)
final hourCreditProvider = HourCreditFamily._();

final class HourCreditProvider extends $AsyncNotifierProvider<HourCredit, int> {
  HourCreditProvider._({
    required HourCreditFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'hourCreditProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hourCreditHash();

  @override
  String toString() {
    return r'hourCreditProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HourCredit create() => HourCredit();

  @override
  bool operator ==(Object other) {
    return other is HourCreditProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hourCreditHash() => r'7ff0c697e5e5bddc6d1e78c0bd9dc6f6f3379132';

final class HourCreditFamily extends $Family
    with
        $ClassFamilyOverride<
          HourCredit,
          AsyncValue<int>,
          int,
          FutureOr<int>,
          int
        > {
  HourCreditFamily._()
    : super(
        retry: null,
        name: r'hourCreditProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HourCreditProvider call(int childId) =>
      HourCreditProvider._(argument: childId, from: this);

  @override
  String toString() => r'hourCreditProvider';
}

abstract class _$HourCredit extends $AsyncNotifier<int> {
  late final _$args = ref.$arg as int;
  int get childId => _$args;

  FutureOr<int> build(int childId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, int>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
