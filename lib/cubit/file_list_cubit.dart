import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nannyplus/data/model/document.dart';

import '../data/files_repository.dart';

part 'file_list_state.dart';

class FileListCubit extends Cubit<FileListState> {
  FileListCubit(FilesRepository filesRepository)
      : _filesRepository = filesRepository,
        super(FileListInitial());

  final FilesRepository _filesRepository;

  void addFile(int id, String label, String path) async {
    await _filesRepository.addFile(id, label, path);
  }

  void loadFiles(int childId) async {
    if (childId == 0) return;
    emit(FileListLoading());
    final documents = await _filesRepository.getFiles(childId);
    emit(FileListLoaded(documents));
  }
}
