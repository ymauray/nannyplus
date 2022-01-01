import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../forms/folder_form.dart';
import '../models/folder.dart';
import '../widgets/folders_list.dart';
import '../widgets/settings_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Folders>(
      builder: (context, folders, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Nanny+'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                var result = await Navigator.of(context).push<Folder>(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const FolderForm(),
                  ),
                );
                if (result != null) {
                  folders.createFolder(result);
                }
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        drawer: const SettingsMenu(),
        body: FoldersList(folders),
        //floatingActionButton: FloatingActionButton(
        //  onPressed: () async {
        //    var result = await Navigator.of(context).push<Folder>(
        //      MaterialPageRoute(
        //        fullscreenDialog: true,
        //        builder: (context) => const FolderForm(),
        //      ),
        //    );
        //    if (result != null) {
        //      folders.createFolder(result);
        //    }
        //  },
        //  child: const Icon(Icons.add),
        //),
      ),
    );
  }
}
