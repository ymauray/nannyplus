class Group<G, T> {
  final G _key;
  final List<T> _value;
  const Group(this._key, this._value);

  G get key => _key;
  List<T> get value => _value;
}

extension ListExtensions<T> on List<T> {
  List<Group<G, T>> groupBy<G extends Comparable>(
    G Function(T element) groupBy, {
    int Function(G value1, G value2)? groupComparator,
  }) {
    var result = <Group<G, T>>[];
    var map = <G, List<T>>{};
    for (var element in this) {
      var key = groupBy(element);
      if (!map.containsKey(key)) {
        map[key] = <T>[];
      }
      map[key]!.add(element);
    }
    var keys = map.keys.toList();
    keys.sort(groupComparator ?? (G a, G b) => a.compareTo(b));
    for (var key in keys) {
      result.add(Group<G, T>(key, map[key]!));
    }

    return result;
  }
}
