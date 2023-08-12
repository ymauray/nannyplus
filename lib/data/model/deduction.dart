import 'package:freezed_annotation/freezed_annotation.dart';

part 'deduction.freezed.dart';
part 'deduction.g.dart';

@freezed
class Deduction with _$Deduction {
  factory Deduction({
    required int? id,
    required int? sortOrder,
    required String label,
    required double value,
    required String type,
    required String periodicity,
  }) = _Deduction;

  factory Deduction.fromJson(Map<String, dynamic> json) =>
      _$DeductionFromJson(json);
}
