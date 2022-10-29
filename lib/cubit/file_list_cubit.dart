import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nannyplus/data/files_repository.dart';
import 'package:nannyplus/data/model/document.dart';
import 'package:path_provider/path_provider.dart';

part 'file_list_state.dart';

class FileListCubit extends Cubit<FileListState> {
  FileListCubit(FilesRepository filesRepository)
      : _filesRepository = filesRepository,
        super(FileListInitial());

  final FilesRepository _filesRepository;

  Future<void> addFile(int childId, File file) async {
    if (childId == 0) return;
    final directory = await getApplicationDocumentsDirectory();
    final name = file.path.split('/').last;
    var index = 0;
    var loop = true;
    var path = '';
    while (loop) {
      index += 1;
      path = '${directory.path}/${childId}_${index}_$name';
      loop = File(path).existsSync();
    }
    file.copySync(path);
    await _filesRepository.addFile(childId, name, path);
    final documents = await _filesRepository.getFiles(childId);
    emit(FileListLoaded(documents));
  }

  Future<void> loadFiles(int childId) async {
    if (childId == 0) return;
    emit(FileListLoading());
    final documents = await _filesRepository.getFiles(childId);
    emit(FileListLoaded(documents));
  }

  Future<void> removeFile(int childId, Document document) async {
    if (childId == 0) return;
    await _filesRepository.removeFile(document);
    try {
      await File(document.path).delete();
    } catch (e) {
      debugPrint('$e');
    }
    final documents = await _filesRepository.getFiles(childId);
    emit(FileListLoaded(documents));
  }

  Future<void> editFile(int childId, Document file, String newLabel) async {
    if (childId == 0) return;
    await _filesRepository.editFile(file, newLabel);
    final documents = await _filesRepository.getFiles(childId);
    emit(FileListLoaded(documents));
  }
}
