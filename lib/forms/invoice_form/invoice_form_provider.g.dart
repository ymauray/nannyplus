// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_form_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvoiceFormChild _$InvoiceFormChildFromJson(Map<String, dynamic> json) =>
    _InvoiceFormChild(
      child: Child.fromJson(json['child'] as String),
      selected: json['selected'] as bool,
    );

Map<String, dynamic> _$InvoiceFormChildToJson(_InvoiceFormChild instance) =>
    <String, dynamic>{'child': instance.child, 'selected': instance.selected};

_InvoiceFormState _$InvoiceFormStateFromJson(Map<String, dynamic> json) =>
    _InvoiceFormState(
      child: Child.fromJson(json['child'] as String),
      children: (json['children'] as List<dynamic>)
          .map((e) => InvoiceFormChild.fromJson(e as Map<String, dynamic>))
          .toList(),
      months: (json['months'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      selectedMonth: json['selectedMonth'] as String?,
    );

Map<String, dynamic> _$InvoiceFormStateToJson(_InvoiceFormState instance) =>
    <String, dynamic>{
      'child': instance.child,
      'children': instance.children,
      'months': instance.months,
      'selectedMonth': instance.selectedMonth,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InvoiceForm)
final invoiceFormProvider = InvoiceFormFamily._();

final class InvoiceFormProvider
    extends $AsyncNotifierProvider<InvoiceForm, InvoiceFormState> {
  InvoiceFormProvider._({
    required InvoiceFormFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'invoiceFormProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$invoiceFormHash();

  @override
  String toString() {
    return r'invoiceFormProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  InvoiceForm create() => InvoiceForm();

  @override
  bool operator ==(Object other) {
    return other is InvoiceFormProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$invoiceFormHash() => r'51acdf2fe7e1382da1c154b6ca725260ae1bbc38';

final class InvoiceFormFamily extends $Family
    with
        $ClassFamilyOverride<
          InvoiceForm,
          AsyncValue<InvoiceFormState>,
          InvoiceFormState,
          FutureOr<InvoiceFormState>,
          int
        > {
  InvoiceFormFamily._()
    : super(
        retry: null,
        name: r'invoiceFormProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  InvoiceFormProvider call(int childId) =>
      InvoiceFormProvider._(argument: childId, from: this);

  @override
  String toString() => r'invoiceFormProvider';
}

abstract class _$InvoiceForm extends $AsyncNotifier<InvoiceFormState> {
  late final _$args = ref.$arg as int;
  int get childId => _$args;

  FutureOr<InvoiceFormState> build(int childId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<InvoiceFormState>, InvoiceFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<InvoiceFormState>, InvoiceFormState>,
              AsyncValue<InvoiceFormState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
