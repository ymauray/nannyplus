import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/src/models/folder.dart';
import 'package:nannyplus/src/models/folders_repository.dart';

part 'folders_page_state.dart';

class FoldersPageCubit extends Cubit<FoldersPageState> {
  FoldersPageCubit(this.repository) : super(const FoldersPageState([], false));

  final FoldersRepository repository;

  Future<void> getFolders(bool showArchived) async {
    var folders = await repository.getFolders(showArchived);
    emit(FoldersPageState(folders, showArchived));
  }

  Future<void> toggleShowArchived() async {
    getFolders(!state.showArchived);
  }
}
