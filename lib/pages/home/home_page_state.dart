part of 'home_page_cubit.dart';

@immutable
class HomePageState {
  const HomePageState(this.tab, this.priceListSet);

  final int tab;
  final bool priceListSet;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomePageState &&
        other.tab == tab &&
        other.priceListSet == priceListSet;
  }

  @override
  int get hashCode => tab.hashCode ^ priceListSet.hashCode;
}
