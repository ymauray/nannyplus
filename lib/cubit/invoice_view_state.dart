// ignore_for_file: argument_type_not_assignable
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
    this.childFirstName,
    this.childLastName,
  );
  factory InvoiceViewLoaded.fromJson(String source) =>
      InvoiceViewLoaded.fromMap(json.decode(source));

  factory InvoiceViewLoaded.fromMap(Map<String, dynamic> map) {
    return InvoiceViewLoaded(
      List<Service>.from(map['services']?.map(Service.fromMap)),
      List<Child>.from(map['children']?.map(Child.fromMap)),
      map['childFirstName'],
      map['childLastName'],
    );
  }

  final List<Service> services;
  final List<Child> children;
  final String childFirstName;
  final String childLastName;

  InvoiceViewLoaded copyWith({
    List<Service>? services,
    List<Child>? children,
    String? childFirstName,
    String? childLastName,
  }) {
    return InvoiceViewLoaded(
      services ?? this.services,
      children ?? this.children,
      childFirstName ?? this.childFirstName,
      childLastName ?? this.childLastName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'services': services.map((x) => x.toMap()).toList(),
      'children': children.map((x) => x.toMap()).toList(),
      'childFirstName': childFirstName,
      'childLastName': childLastName,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'InvoiceViewLoaded(services: $services, children: $children, childFirstName: $childFirstName, childLastName: $childLastName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceViewLoaded &&
        listEquals(other.services, services) &&
        listEquals(other.children, children) &&
        other.childFirstName == childFirstName &&
        other.childLastName == childLastName;
  }

  @override
  int get hashCode =>
      services.hashCode ^
      children.hashCode ^
      childFirstName.hashCode ^
      childLastName.hashCode;
}
