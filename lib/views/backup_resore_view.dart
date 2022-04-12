import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gettext_i18n/gettext_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/database_util.dart';
import '../utils/snack_bar_util.dart';
import '../views/app_view.dart';
import '../views/child_list_view.dart';
import '../widgets/card_scroll_view.dart';
import '../widgets/card_tile.dart';

class BackupRestoreView extends StatelessWidget {
  const BackupRestoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppView(
      title: Text(context.t('Backup') + ' / ' + context.t('Restore')),
      body: CardScrollView(
        children: [
          CardTile(
            title: Text(context.t('Backup')),
            onTap: () async => await _backup(context),
          ),
          CardTile(
            title: Text(context.t('Restore')),
            onTap: () async {
              var success = await _restore(context);
              if (success) {
                ScaffoldMessenger.of(context).success(
                  context.t('Database successfully restored'),
                );
                Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ChildListView()),
                );
              } else {
                ScaffoldMessenger.of(context).failure(
                  context.t('Error restoring database'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _backup(BuildContext context) async {
    DatabaseUtil.closeDatabase();
    await Share.shareFiles([await DatabaseUtil.databasePath]);
  }

  Future<bool> _restore(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: context.t('Select a backup file'),
      type: FileType.any,
      withData: true,
    );

    if (result != null) {
      var fileBytes = result.files.first.bytes;
      if (fileBytes != null) {
        XFile file = XFile.fromData(fileBytes);
        await DatabaseUtil.closeDatabase();
        await file.saveTo(await DatabaseUtil.databasePath);

        return true;
      }
    }

    return false;
  }
}
