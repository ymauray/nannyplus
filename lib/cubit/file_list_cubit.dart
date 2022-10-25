import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'file_list_state.dart';

class FileListCubit extends Cubit<FileListState> {
  FileListCubit() : super(FileListInitial());
}
