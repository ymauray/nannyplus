import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nannyplus/data/model/vacation_period.dart';

part 'vacation_planning_view_state.freezed.dart';
part 'vacation_planning_view_state.g.dart';

@freezed
class VacationPlanningViewState with _$VacationPlanningViewState {
  const factory VacationPlanningViewState({
    required int year,
    required List<VacationPeriod> periods,
  }) = _VacationPlanningViewState;
  factory VacationPlanningViewState.fromJson(Map<String, dynamic> json) =>
      _$VacationPlanningViewStateFromJson(json);
}
