part of 'folders_page_cubit.dart';

@immutable
class FoldersPageState {
  const FoldersPageState(this.folders, this.showArchived);

  final List<Folder> folders;
  final bool showArchived;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoldersPageState && listEquals(other.folders, folders);
  }

  @override
  int get hashCode => folders.hashCode;
}
