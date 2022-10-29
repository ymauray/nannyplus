part of 'invoice_view_cubit.dart';

@immutable
abstract class InvoiceViewState {
  const InvoiceViewState();
}

class InvoiceViewInitial extends InvoiceViewState {
  const InvoiceViewInitial();
}

class InvoiceViewLoaded extends InvoiceViewState {
  const InvoiceViewLoaded(
    this.services,
    this.children,
  );
  factory InvoiceViewLoaded.fromJson(String source) =>
      InvoiceViewLoaded.fromMap(json.decode(source));

  factory InvoiceViewLoaded.fromMap(Map<String, dynamic> map) {
    return InvoiceViewLoaded(
      List<Service>.from(map['services']?.map((x) => Service.fromMap(x))),
      List<Child>.from(map['children']?.map((x) => Child.fromMap(x))),
    );
  }

  final List<Service> services;
  final List<Child> children;

  InvoiceViewLoaded copyWith({
    List<Service>? services,
    List<Child>? children,
  }) {
    return InvoiceViewLoaded(
      services ?? this.services,
      children ?? this.children,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'services': services.map((x) => x.toMap()).toList(),
      'children': children.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'InvoiceViewLoaded(services: $services, children: $children)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceViewLoaded &&
        listEquals(other.services, services) &&
        listEquals(other.children, children);
  }

  @override
  int get hashCode => services.hashCode ^ children.hashCode;
}
