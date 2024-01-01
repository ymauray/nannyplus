import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nannyplus/data/model/document.dart';
import 'package:nannyplus/data/repository/files_repository.dart';

part 'file_list_state.dart';

class FileListCubit extends Cubit<FileListState> {
  FileListCubit(FilesRepository filesRepository)
      : _filesRepository = filesRepository,
        super(FileListInitial());

  final FilesRepository _filesRepository;

  Future<void> addFile(int childId, File file) async {
    if (childId == 0) return;
    final name = file.path.split('/').last;
    await _filesRepository.addFile(childId, name, file.readAsBytesSync());
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
      if (document.path != '') {
        final file = File(document.path);
        if (file.existsSync()) {
          File(document.path).deleteSync();
        }
      }
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
