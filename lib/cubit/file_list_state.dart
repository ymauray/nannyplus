part of 'file_list_cubit.dart';

@immutable
abstract class FileListState {}

class FileListInitial extends FileListState {}

class FileListLoading extends FileListState {}

class FileListLoaded extends FileListState {
  FileListLoaded(Iterable<Document> files) : _files = files;

  final Iterable<Document> _files;

  Iterable<Document> get files => _files;
}
