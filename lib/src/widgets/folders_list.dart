import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/entry.dart';
import '../models/folder.dart';
import '../pages/entries_page.dart';

class FoldersList extends StatelessWidget {
  const FoldersList(this.folders, {Key? key}) : super(key: key);

  final Folders folders;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: folders.data.length + 2,
      itemBuilder: (context, index) {
        if (index == 0 || index == folders.data.length + 1) {
          return Container(); // Height 0, so invisible
        } else {
          var folder = folders.data[index - 1];
          return ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.phone,
                color: folder.phoneNumber != null ? Colors.green : Colors.grey,
              ),
              onPressed: () async {
                if (folder.phoneNumber != null) {
                  var url = "tel:${folder.phoneNumber}";
                  if (await canLaunch(url)) {
                    await (launch(url));
                  }
                }
              },
            ),
            title: Text("${folder.firstName!} ${folder.lastName}".trim()),
            subtitle: Text((folder.allergies ?? "").isEmpty
                ? context.t("No known allergies")
                : folder.allergies),
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
        }
      },
      separatorBuilder: (context, index) => const Divider(
        height: 0,
      ),
    );
  }
}
