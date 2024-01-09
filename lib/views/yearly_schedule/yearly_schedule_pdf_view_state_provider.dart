import 'package:nannyplus/views/yearly_schedule/yearly_schedule_pdf_view_state.dart'
    as view;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'yearly_schedule_pdf_view_state_provider.g.dart';

@riverpod
class YearlySchedulePdfViewState extends _$YearlySchedulePdfViewState {
  @override
  view.YearlySchedulePdfViewState build() {
    return view.YearlySchedulePdfViewState(DateTime.now().year);
  }

  void decrement() {
    state = state.copyWith(year: state.year - 1);
  }

  void increment() {
    state = state.copyWith(year: state.year + 1);
  }

  void reset() {
    state = build();
  }
}
