import 'package:freezed_annotation/freezed_annotation.dart';

part 'yearly_schedule_pdf_view_state.freezed.dart';
part 'yearly_schedule_pdf_view_state.g.dart';

@freezed
class YearlySchedulePdfViewState with _$YearlySchedulePdfViewState {
  const factory YearlySchedulePdfViewState(
    int year,
  ) = _YearlySchedulePdfViewState;
  factory YearlySchedulePdfViewState.fromJson(Map<String, dynamic> json) =>
      _$YearlySchedulePdfViewStateFromJson(json);
}
