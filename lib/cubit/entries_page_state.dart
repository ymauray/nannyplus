part of 'entries_page_cubit.dart';

@immutable
class EntriesPageState {
  const EntriesPageState(this.entries);

  final List<Entry> entries;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EntriesPageState && listEquals(other.entries, entries);
  }

  @override
  int get hashCode => entries.hashCode;
}
