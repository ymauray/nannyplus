// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_periods_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$vacationPeriodsHash() => r'33215275824caa9cbf6ecbfc6caaf3d4a9ff4477';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$VacationPeriods
    extends BuildlessAutoDisposeAsyncNotifier<List<VacationPeriod>> {
  late final int year;

  FutureOr<List<VacationPeriod>> build(
    int year,
  );
}

/// See also [VacationPeriods].
@ProviderFor(VacationPeriods)
const vacationPeriodsProvider = VacationPeriodsFamily();

/// See also [VacationPeriods].
class VacationPeriodsFamily extends Family<AsyncValue<List<VacationPeriod>>> {
  /// See also [VacationPeriods].
  const VacationPeriodsFamily();

  /// See also [VacationPeriods].
  VacationPeriodsProvider call(
    int year,
  ) {
    return VacationPeriodsProvider(
      year,
    );
  }

  @override
  VacationPeriodsProvider getProviderOverride(
    covariant VacationPeriodsProvider provider,
  ) {
    return call(
      provider.year,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'vacationPeriodsProvider';
}

/// See also [VacationPeriods].
class VacationPeriodsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    VacationPeriods, List<VacationPeriod>> {
  /// See also [VacationPeriods].
  VacationPeriodsProvider(
    int year,
  ) : this._internal(
          () => VacationPeriods()..year = year,
          from: vacationPeriodsProvider,
          name: r'vacationPeriodsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$vacationPeriodsHash,
          dependencies: VacationPeriodsFamily._dependencies,
          allTransitiveDependencies:
              VacationPeriodsFamily._allTransitiveDependencies,
          year: year,
        );

  VacationPeriodsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
  }) : super.internal();

  final int year;

  @override
  FutureOr<List<VacationPeriod>> runNotifierBuild(
    covariant VacationPeriods notifier,
  ) {
    return notifier.build(
      year,
    );
  }

  @override
  Override overrideWith(VacationPeriods Function() create) {
    return ProviderOverride(
      origin: this,
      override: VacationPeriodsProvider._internal(
        () => create()..year = year,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<VacationPeriods, List<VacationPeriod>>
      createElement() {
    return _VacationPeriodsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VacationPeriodsProvider && other.year == year;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin VacationPeriodsRef
    on AutoDisposeAsyncNotifierProviderRef<List<VacationPeriod>> {
  /// The parameter `year` of this provider.
  int get year;
}

class _VacationPeriodsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<VacationPeriods,
        List<VacationPeriod>> with VacationPeriodsRef {
  _VacationPeriodsProviderElement(super.provider);

  @override
  int get year => (origin as VacationPeriodsProvider).year;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
