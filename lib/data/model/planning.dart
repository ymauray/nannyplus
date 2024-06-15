import 'package:freezed_annotation/freezed_annotation.dart';

part 'planning.freezed.dart';
part 'planning.g.dart';

@freezed
class Planning with _$Planning {
  const factory Planning({
    required int id,
    required String? planningStart,
    required String? planningEnd,
  }) = _Planning;
  factory Planning.fromJson(Map<String, dynamic> json) =>
      _$PlanningFromJson(json);
}
