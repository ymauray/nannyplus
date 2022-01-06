import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nannyplus/cubit/entries_page_cubit.dart';
import 'package:nannyplus/src/pages/entries_page.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gettext_i18n/gettext_i18n.dart';

import '../models/folder.dart';

class FolderTile extends StatelessWidget {
  const FolderTile(this.folder, {Key? key}) : super(key: key);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
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
            ? const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)
            : null,
      ),
      subtitle: Text((folder.allergies ?? "").isEmpty
          ? context.t("No known allergies")
          : folder.allergies),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EntriesPage(folder),
          ),
        );
      },
    );
  }
}
