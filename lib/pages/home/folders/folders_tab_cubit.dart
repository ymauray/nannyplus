import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/src/models/folder.dart';
import 'package:nannyplus/src/models/folders_repository.dart';

part 'folders_tab_state.dart';

class FoldersTabCubit extends Cubit<FoldersTabState> {
  FoldersTabCubit(this.repository) : super(const FoldersTabState([], false));

  final FoldersRepository repository;

  Future<void> getFolders(bool showArchived) async {
    var folders = await repository.getFolders(showArchived);
    emit(FoldersTabState(folders, showArchived));
  }

  Future<void> toggleShowArchived() async {
    getFolders(!state.showArchived);
  }
}
