// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(childList)
final childListProvider = ChildListFamily._();

final class ChildListProvider
    extends
        $FunctionalProvider<
          Raw<FutureOr<List<Child>>>,
          Raw<FutureOr<List<Child>>>,
          Raw<FutureOr<List<Child>>>
        >
    with $Provider<Raw<FutureOr<List<Child>>>> {
  ChildListProvider._({
    required ChildListFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'childListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$childListHash();

  @override
  String toString() {
    return r'childListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Raw<FutureOr<List<Child>>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Raw<FutureOr<List<Child>>> create(Ref ref) {
    final argument = this.argument as int?;
    return childList(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Raw<FutureOr<List<Child>>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Raw<FutureOr<List<Child>>>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChildListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$childListHash() => r'28fa96fa9c2f0ed5d4fe10948ad1a9d09ca419a5';

final class ChildListFamily extends $Family
    with $FunctionalFamilyOverride<Raw<FutureOr<List<Child>>>, int?> {
  ChildListFamily._()
    : super(
        retry: null,
        name: r'childListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChildListProvider call(int? excludeId) =>
      ChildListProvider._(argument: excludeId, from: this);

  @override
  String toString() => r'childListProvider';
}
