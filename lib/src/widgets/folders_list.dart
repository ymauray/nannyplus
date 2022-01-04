import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/tabbed_entries_page.dart';
import '../models/entry.dart';
import '../models/folder.dart';

class FoldersList extends StatelessWidget {
  const FoldersList(this.folders, this.showArchived, {Key? key})
      : super(key: key);

  final Folders folders;
  final bool showArchived;

  @override
  Widget build(BuildContext context) {
    var data = folders.getData(showArchived);
    return ListView.separated(
      itemCount: data.length + 2,
      itemBuilder: (context, index) {
        if (index == 0 || index == data.length + 1) {
          return Container(); // Height 0, so invisible
        } else {
          var folder = data[index - 1];
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
            title: Text(
              "${folder.firstName!} ${folder.lastName} ${kDebugMode ? folder.id : ''}"
                  .trim(),
              style: (folder.archived ?? false)
                  ? const TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey)
                  : null,
            ),
            subtitle: Text((folder.allergies ?? "").isEmpty
                ? context.t("No known allergies")
                : folder.allergies),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider<Entries>(
                    create: (_) => Entries.load(folder),
                    builder: (context, _) => TabbedEntriesPage(folder),
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
