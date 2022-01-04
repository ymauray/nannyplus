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
  bool _showArchived = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<Folders>(
      builder: (context, folders, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Nanny+'),
          centerTitle: true,
          //bottom: const MyFilter(),
          actions: [
            Switch(
                activeColor: Colors.white,
                activeTrackColor: Colors.grey[300],
                value: _showArchived,
                onChanged: (value) {
                  setState(() {
                    _showArchived = value;
                  });
                })
          ],
        ),
        drawer: const SettingsMenu(),
        body: FoldersList(folders, _showArchived),
        floatingActionButton: FloatingActionButton(
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
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
