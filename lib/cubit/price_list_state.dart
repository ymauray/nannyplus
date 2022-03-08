part of 'price_list_cubit.dart';

// ---------------------------------------------------------------------------

@immutable
abstract class PriceListState {
  const PriceListState();
}

// ---------------------------------------------------------------------------

class PriceListInitial extends PriceListState {
  const PriceListInitial();
}

// ---------------------------------------------------------------------------

class PriceListLoaded extends PriceListState {
  final List<Price> priceList;
  const PriceListLoaded(this.priceList);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceListLoaded && listEquals(other.priceList, priceList);
  }

  @override
  int get hashCode => priceList.hashCode;
}

// ---------------------------------------------------------------------------

class PriceListError extends PriceListState {
  final String message;
  const PriceListError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceListError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

// ---------------------------------------------------------------------------
