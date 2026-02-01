// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(childInfo)
final childInfoProvider = ChildInfoFamily._();

final class ChildInfoProvider
    extends $FunctionalProvider<AsyncValue<Child>, Child, FutureOr<Child>>
    with $FutureModifier<Child>, $FutureProvider<Child> {
  ChildInfoProvider._(
      {required ChildInfoFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'childInfoProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childInfoHash();

  @override
  String toString() {
    return r'childInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Child> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Child> create(Ref ref) {
    final argument = this.argument as int;
    return childInfo(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChildInfoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$childInfoHash() => r'c0fe1eea445efee6cfd0cd68f97e584c56b281a9';

final class ChildInfoFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Child>, int> {
  ChildInfoFamily._()
      : super(
          retry: null,
          name: r'childInfoProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ChildInfoProvider call(
    int childId,
  ) =>
      ChildInfoProvider._(argument: childId, from: this);

  @override
  String toString() => r'childInfoProvider';
}
