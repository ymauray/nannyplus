import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:nannyplus/src/models/entry.dart';
import '../src/models/entries_repository.dart';

part 'entries_page_state.dart';

class EntriesPageCubit extends Cubit<EntriesPageState> {
  EntriesPageCubit(this.repository) : super(const EntriesPageState([]));

  final EntriesRepository repository;

  Future<void> getEntries(int folderId) async {
    var entries = await repository.getEntries(folderId);
    emit(EntriesPageState(entries));
  }
}
