import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:nannyplus/src/models/folders_repository.dart';

import '../../cubit/folders_page_cubit.dart';
import '../../src/widgets/folder_tile.dart';

class FoldersTab extends StatelessWidget {
  const FoldersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FoldersPageCubit(FoldersRepository())..getFolders(false),
      child: BlocBuilder<FoldersPageCubit, FoldersPageState>(
        builder: (context, foldersPageState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                context.t('Nanny+'),
              ),
              actions: [
                PopupMenuButton<String>(
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: "show_archived",
                      child: Row(
                        children: [
                          Text(foldersPageState.showArchived
                              ? context.t("Hide archived folders")
                              : context.t("Show archived folders")),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'show_archived') {
                      context.read<FoldersPageCubit>().toggleShowArchived();
                    }
                  },
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: foldersPageState.folders.length + 2,
              itemBuilder: (context, index) {
                if (index == 0 ||
                    index == foldersPageState.folders.length + 1) {
                  return Container();
                } else {
                  var folder = foldersPageState.folders[index - 1];
                  return FolderTile(folder);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
