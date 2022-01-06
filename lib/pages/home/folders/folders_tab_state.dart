part of 'folders_tab_cubit.dart';

@immutable
class FoldersTabState {
  const FoldersTabState(this.folders, this.showArchived);

  final List<Folder> folders;
  final bool showArchived;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoldersTabState && listEquals(other.folders, folders);
  }

  @override
  int get hashCode => folders.hashCode;
}
