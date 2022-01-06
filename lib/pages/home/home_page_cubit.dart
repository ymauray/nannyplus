import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(bool priceListSet) : super(HomePageState(0, priceListSet));

  set priceListSet(bool isSet) {
    emit(HomePageState(state.tab, isSet));
  }

  changeTab(int tab) {
    emit(HomePageState(tab, state.priceListSet));
  }
}
