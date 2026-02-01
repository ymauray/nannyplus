// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(childrenRepository)
final childrenRepositoryProvider = ChildrenRepositoryProvider._();

final class ChildrenRepositoryProvider extends $FunctionalProvider<
    ChildrenRepository,
    ChildrenRepository,
    ChildrenRepository> with $Provider<ChildrenRepository> {
  ChildrenRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'childrenRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childrenRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChildrenRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChildrenRepository create(Ref ref) {
    return childrenRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChildrenRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChildrenRepository>(value),
    );
  }
}

String _$childrenRepositoryHash() =>
    r'26c5f3d6503da00d38a69a2f07827cb47abdebd2';
