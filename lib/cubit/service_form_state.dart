part of 'service_form_cubit.dart';

@immutable
abstract class ServiceFormState {
  const ServiceFormState();
}

class ServiceFormInitial extends ServiceFormState {
  const ServiceFormInitial() : super();
}

class ServiceFormLoaded extends ServiceFormState {
  final int selectedTab;
  final List<Service> services;
  final List<Price> prices;
  const ServiceFormLoaded(
    this.selectedTab,
    this.services,
    this.prices,
  ) : super();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceFormLoaded &&
        other.selectedTab == selectedTab &&
        listEquals(other.services, services) &&
        listEquals(other.prices, prices);
  }

  @override
  int get hashCode =>
      selectedTab.hashCode ^ services.hashCode ^ prices.hashCode;

  ServiceFormLoaded copyWith({
    int? selectedTab,
    List<Service>? services,
    List<Price>? prices,
  }) {
    return ServiceFormLoaded(
      selectedTab ?? this.selectedTab,
      services ?? this.services,
      prices ?? this.prices,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selectedTab': selectedTab,
      'services': services.map((x) => x.toMap()).toList(),
      'prices': prices.map((x) => x.toMap()).toList(),
    };
  }

  factory ServiceFormLoaded.fromMap(Map<String, dynamic> map) {
    return ServiceFormLoaded(
      map['selectedTab']?.toInt() ?? 0,
      List<Service>.from(map['services']?.map((x) => Service.fromMap(x))),
      List<Price>.from(map['prices']?.map((x) => Price.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceFormLoaded.fromJson(String source) =>
      ServiceFormLoaded.fromMap(json.decode(source));

  @override
  String toString() =>
      'ServiceFormLoaded(selectedTab: $selectedTab, services: $services, prices: $prices)';
}

class ServiceFormError extends ServiceFormState {
  final String _message;
  const ServiceFormError(this._message) : super();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceFormError && other._message == _message;
  }

  @override
  int get hashCode => _message.hashCode;
}
