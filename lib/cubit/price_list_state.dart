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
  const PriceListLoaded(
    this.priceList,
    this.inUse,
  );

  final List<Price> priceList;
  final Set<int> inUse;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceListLoaded &&
        listEquals(other.priceList, priceList) &&
        setEquals(other.inUse, inUse);
  }

  @override
  int get hashCode => priceList.hashCode ^ inUse.hashCode;

  PriceListLoaded copyWith({
    List<Price>? priceList,
    Set<int>? inUse,
  }) {
    return PriceListLoaded(
      priceList ?? this.priceList,
      inUse ?? this.inUse,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'priceList': priceList.map((x) => x.toMap()).toList(),
      'inUse': inUse.toList(),
    };
  }

  factory PriceListLoaded.fromMap(Map<String, dynamic> map) {
    return PriceListLoaded(
      List<Price>.from(map['priceList']?.map((x) => Price.fromMap(x))),
      Set<int>.from(map['inUse']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceListLoaded.fromJson(String source) =>
      PriceListLoaded.fromMap(json.decode(source));

  @override
  String toString() => 'PriceListLoaded(priceList: $priceList, inUse: $inUse)';
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
