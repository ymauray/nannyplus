import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nannyplus/data/model/document.dart';
import 'package:path_provider/path_provider.dart';

import '../data/files_repository.dart';

part 'file_list_state.dart';

class FileListCubit extends Cubit<FileListState> {
  FileListCubit(FilesRepository filesRepository)
      : _filesRepository = filesRepository,
        super(FileListInitial());

  final FilesRepository _filesRepository;

  void addFile(int childId, File file) async {
    if (childId == 0) return;
    final directory = await getApplicationDocumentsDirectory();
    final name = file.path.split('/').last;
    var index = 0;
    var loop = true;
    var path = "";
    while (loop) {
      index += 1;
      path = "${directory.path}/${childId}_${index}_$name";
      loop = File(path).existsSync();
    }
    file.copySync(path);
    _filesRepository.addFile(childId, name, path);
    final documents = await _filesRepository.getFiles(childId);
    emit(FileListLoaded(documents));
  }

  void loadFiles(int childId) async {
    if (childId == 0) return;
    emit(FileListLoading());
    final documents = await _filesRepository.getFiles(childId);
    emit(FileListLoaded(documents));
  }

  void removeFile(int childId, Document document) async {
    if (childId == 0) return;
    await _filesRepository.removeFile(document);
    try {
      await File(document.path).delete();
    } catch (e) {
      debugPrint("$e");
    }
    final documents = await _filesRepository.getFiles(childId);
    emit(FileListLoaded(documents));
  }
}
