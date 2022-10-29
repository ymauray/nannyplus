class Group<G, T> {
  const Group(this._key, this._value);
  final G _key;
  final List<T> _value;

  G get key => _key;
  List<T> get value => _value;
}

extension ListExtensions<T> on List<T> {
  List<Group<G, T>> groupBy<G extends Comparable<G>>(
    G Function(T element) groupBy, {
    int Function(G value1, G value2)? groupComparator,
  }) {
    final result = <Group<G, T>>[];
    final map = <G, List<T>>{};
    for (final element in this) {
      final key = groupBy(element);
      if (!map.containsKey(key)) {
        map[key] = <T>[];
      }
      map[key]!.add(element);
    }
    final keys = map.keys.toList()
      ..sort(groupComparator ?? (G a, G b) => a.compareTo(b));
    for (final key in keys) {
      result.add(Group<G, T>(key, map[key]!));
    }

    return result;
  }
}
