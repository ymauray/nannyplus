import 'package:flutter/material.dart';

import '../models/folder.dart';

class ChildNameAppBarTitle extends StatelessWidget {
  const ChildNameAppBarTitle(this.folder, {Key? key}) : super(key: key);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${folder.firstName} ${folder.lastName}",
      style: (folder.archived ?? false)
          ? const TextStyle(fontStyle: FontStyle.italic)
          : null,
    );
  }
}
