// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(servicesRepository)
final servicesRepositoryProvider = ServicesRepositoryProvider._();

final class ServicesRepositoryProvider
    extends
        $FunctionalProvider<
          ServicesRepository,
          ServicesRepository,
          ServicesRepository
        >
    with $Provider<ServicesRepository> {
  ServicesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'servicesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$servicesRepositoryHash();

  @$internal
  @override
  $ProviderElement<ServicesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ServicesRepository create(Ref ref) {
    return servicesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServicesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServicesRepository>(value),
    );
  }
}

String _$servicesRepositoryHash() =>
    r'4273e456fa276af90740fe9874ca7ceef4e74a65';
