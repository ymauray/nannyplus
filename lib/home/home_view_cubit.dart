import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit() : super(const HomeViewState(0));

  changeTab(int tab) {
    emit(HomeViewState(tab));
  }
}
