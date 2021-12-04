import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/entry.dart';
import '../models/folder.dart';
import '../pages/entries_page.dart';

class FoldersList extends StatelessWidget {
  const FoldersList(this.folders, {Key? key}) : super(key: key);

  final Folders folders;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: folders.data.length,
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 80),
      itemBuilder: (context, index) {
        var folder = folders.data[index];
        return ListTile(
          title: Text("${folder.firstName!} ${folder.lastName}".trim()),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<Entries>(
                  create: (_) => Entries.load(folder),
                  builder: (context, _) => EntriesPage(folder),
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
