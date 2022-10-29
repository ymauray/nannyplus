part of 'invoice_form_cubit.dart';

@immutable
class InvoiceFormChild {
  const InvoiceFormChild(
    this.child,
    this.checked,
  );
  factory InvoiceFormChild.fromJson(String source) =>
      InvoiceFormChild.fromMap(json.decode(source));

  factory InvoiceFormChild.fromMap(Map<String, dynamic> map) {
    return InvoiceFormChild(
      Child.fromMap(map['child']),
      map['checked'] ?? false,
    );
  }

  final Child child;
  final bool checked;

  InvoiceFormChild copyWith({
    Child? child,
    bool? checked,
  }) {
    return InvoiceFormChild(
      child ?? this.child,
      checked ?? this.checked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'child': child.toMap(),
      'checked': checked,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'InvoiceFormChild(child: $child, checked: $checked)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceFormChild &&
        other.child == child &&
        other.checked == checked;
  }

  @override
  int get hashCode => child.hashCode ^ checked.hashCode;
}

@immutable
abstract class InvoiceFormState {
  const InvoiceFormState();
}

class InvoiceFormInitial extends InvoiceFormState {
  const InvoiceFormInitial();
}

class InvoiceFormLoaded extends InvoiceFormState {
  const InvoiceFormLoaded({
    required this.child,
    required this.children,
  });
  factory InvoiceFormLoaded.fromJson(String source) =>
      InvoiceFormLoaded.fromMap(json.decode(source));

  factory InvoiceFormLoaded.fromMap(Map<String, dynamic> map) {
    return InvoiceFormLoaded(
      child: Child.fromMap(map['child']),
      children: List<InvoiceFormChild>.from(
        map['children']?.map((x) => InvoiceFormChild.fromMap(x)),
      ),
    );
  }

  final Child child;
  final List<InvoiceFormChild> children;

  InvoiceFormLoaded copyWith({
    Child? child,
    List<InvoiceFormChild>? children,
  }) {
    return InvoiceFormLoaded(
      child: child ?? this.child,
      children: children ?? this.children,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'child': child.toMap(),
      'children': children.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'InvoiceFormLoaded(child: $child, children: $children)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceFormLoaded &&
        other.child == child &&
        listEquals(other.children, children);
  }

  @override
  int get hashCode => child.hashCode ^ children.hashCode;
}
